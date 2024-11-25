`timescale 1ns/1ns

module topLevel(
input clk
);

//PC
wire [31:0] it, instNum;

PC I1(.PCin(it),.PCout(instNum),.clk(clk));

//ADD4

wire [31:0] Sadd4;

ADD_4 I2(.A(instNum),.B(32'd4),.S(Sadd4));

//SIGN EXTEND

wire [31:0] signExtOut;
wire [31:0] instruction;

signExtend I3(.A(instruction[15:0]),.S(signExtOut));

//SHIFT LEFT 2
wire [31:0] shift2Out;

shift2 I4(.A(signExtOut),.S(shift2Out));

//ADD ALU RESULT

wire[31:0] aluResOut;

addAlu I5(.A(Sadd4),.B(shift2Out),.S(aluResOut));


//MUX2_1 ADD4

wire selBranch;

mux2_1 I6(.A(Sadd4),.B(aluResOut),.sel(selBranch),.S(it));

//instruction memory

instMem I7(.i(instNum),.S(instruction));

//DATA MEMORY

wire [31:0] readDataMem, result, readData2;
wire memRead, memWrite;

dataMem I16(.writeData(readData2),.dir(result),.memWrite(memWrite),.memRead(memRead),.readData(readDataMem));


//UNIDAD DE CONTROL

wire RegWrite, memToReg, branch, ALUsrc, regDst;
wire [2:0] ALUop;

UDC I8(.opCode(instruction[31:26]),.BR_en(RegWrite),.AluC(ALUop),.EnW(memWrite),.EnR(memRead),.MUX1(memToReg),.branch(branch),.regDest(regDst),.ALUsrc(ALUsrc));

//MUX2_1 FROM INST TO BANK

wire[4:0] writeReg;

mux2_1_5b I9(.sel(regDst),.A(instruction[20:16]),.B(instruction[15:11]),.S(writeReg));

//BANCO DE REGISTROS

wire [31:0]writeData, op1;

bancoDeReg I10(.data(writeData),.readDir1(instruction[25:21]),.readDir2(instruction[20:16]),.writeDir(writeReg),.WE(RegWrite),.Dato1(op1),.Dato2(readData2));

//MUX2_1 TO ALU

wire [31:0] op2;

mux2_1 I11(.sel(ALUsrc),.A(readData2),.B(signExtOut),.S(op2));

//ALU CONTROL

wire [2:0] operador;

ALUcontrol I12(.selAlu(ALUop),.func(instruction[5:0]),.SaluC(operador));

//ALU

wire flagToMux;

ALU I13(.op1(op1),.op2(op2),.sel(operador),.SALU(result),.ZF(flagToMux));

//MUX2_1 FROM ALU TO BANK

mux2_1 I14(.sel(memToReg),.A(result),.B(readDataMem),.S(writeData));

//AND


and1 I15 (.A(branch),.B(flagToMux),.S(selBranch));

endmodule





