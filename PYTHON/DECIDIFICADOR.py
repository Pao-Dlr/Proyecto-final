import tkinter as tk
from tkinter import filedialog
from tkinter import messagebox
import re

class Deco:
    def __init__(self):
        self.window = tk.Tk()
        self.textArea = tk.Text(self.window, wrap=tk.WORD, height=25, width=80, background="#F5F5F7", fg="black")
        self.createWindow()
        self.showGui()
        self.codigoMaquina = ""  # Inicializar correctamente la variable

    def createWindow(self):
        self.window.title("Decoder")
        self.window.geometry("800x750")
        self.window.configure(background="#EDDFE0")

        titleLabel = tk.Label(self.window, text="Text Analyzer", font=("Courier", 32), fg="#C75B7A", background="#EDDFE0")
        titleLabel.pack(pady=10)

        button1 = tk.Button(self.window, text="Import file", command=self.selectFile, bg="#EEEEEE", fg="black", font=("Courier", 12), relief="groove")
        button1.pack(pady=10)
        button2 = tk.Button(self.window, text="Decode", command=self.decode, bg="#EEEEEE", fg="black", font=("Courier", 12), relief="groove")
        button2.pack(pady=10)
        button3 = tk.Button(self.window, text="Save file", command=self.saveFile, bg="#EEEEEE", fg="black", font=("Courier", 12), relief="groove")
        button3.pack(pady=10)

        self.textArea.pack(pady=5)

        exitButton = tk.Button(self.window, text="Exit", command=self.exitApp, bg="#EEEEEE", fg="black", font=("Courier", 12), relief="groove")
        exitButton.pack(pady=10)

    def selectFile(self):
        file = filedialog.askopenfilename(filetypes=[("Text Files", "*.txt"),("ASM Files", "*.asm")], title="Select file")
        if file:
            self.loadFile(file)

    def loadFile(self, file):
        with open(file, 'r', encoding='utf-8') as f:
            content = f.read() 
        self.textArea.delete('1.0', tk.END)
        self.textArea.insert(tk.END, content)

    def decode(self):
        # Diccionario de operaciones (funct)
        functDic = {
            "add": "100000", "sub": "100010", "and": "100100", "slt": "101010", "or": "100101", 
            "nop": "000000"
        }

        # Diccionario de códigos de operación (opCode)
        opCodeDic = {
            "addi": "001000", "ori": "001101", "andi": "001100", "slti": "001010", 
            "lw": "100011", "sw": "101011", "beq": "000100"
        }

        # Función para decodificar números de registros a binario de 5 bits
        def decodeNum(dir):
            num = dir[1:]  # Ignorar el primer carácter (si es '$')
            try:
                last = int(num)
            except ValueError:
                messagebox.showinfo(f"El último carácter '{num}' no es un número entero.")
                return "00000"
            return bin(last)[2:].zfill(5)  # Convertir a binario y rellenar a 5 bits

        contenido = ""
        contenidoOriginal = ""
        contenidoBinario = ""
        self.codigoMaquina = ""
        lines = self.textArea.get('1.0', tk.END).strip().splitlines()

        for linea in lines:
            linea = linea.strip()
            partes = linea.split(' ')

            contenidoOriginal += linea + "\n"
            if len(partes) >= 4:  # Operaciones tipo R
                funct = partes[0].lower()
                dir1 = partes[1]
                dir2 = partes[2]
                dirSave = partes[3]

                functBin = functDic.get(funct, "000000")  # Buscar el código binario de la operación
                dir1Bin = decodeNum(dir1)
                dir2Bin = decodeNum(dir2)
                dirSaveBin = decodeNum(dirSave)

                if functBin != "000000":  # Si la instrucción tiene formato R
                    newLinea = f"000000_{dir1Bin}_{dir2Bin}_{dirSaveBin}_00000_{functBin}"
                    contenido += newLinea + "\n"
                    contenidoBinario += f"000000{dir1Bin}{dir2Bin}{dirSaveBin}00000{functBin}\n"
                else:  # Si no es una instrucción R, es un opCode (como 'addi', 'beq', etc.)
                    opCode = opCodeDic.get(funct, "000000")
                    numBin16 = dirSaveBin.zfill(16)  # El segundo registro puede ser un número inmediato, se rellena a 16 bits

                    newLinea = f"{opCode}_{dir1Bin}_{dir2Bin}_{numBin16}"
                    contenido += newLinea + "\n"
                    contenidoBinario += f"{opCode}{dir1Bin}{dir2Bin}{numBin16}\n"
                
            elif partes[0].lower() == "nop" and len(partes) == 1:  # Instrucción "nop"
                newLinea = "000000_00000_00000_00000_00000_000000"
                contenido += newLinea + "\n"
                contenidoBinario += "00000000000000000000000000000000\n"
                
            else:
                print(f"La línea no contiene suficientes partes: {linea}")

        self.textArea.delete('1.0', tk.END)
        self.textArea.insert(tk.END, "Contenido original:\n")
        self.textArea.insert(tk.END, contenidoOriginal + "\n")

        self.textArea.insert(tk.END, "Contenido decodificado:\n")
        self.textArea.insert(tk.END, contenido + "\n")

        self.codigoMaquina = contenidoBinario

    def saveFile(self):
        if not self.codigoMaquina:
            messagebox.showinfo("Error", "No hay contenido decodificado para guardar.")
            return

        file = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("Text Files", "*.txt")])
        if file:
            with open(file, 'w', encoding='utf-8') as f:
                f.write(self.codigoMaquina)

    def exitApp(self):
        self.window.quit()

    def showGui(self):
        self.window.mainloop()

if __name__ == "__main__":
    Deco()