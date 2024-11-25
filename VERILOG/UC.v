`timescale 1ns/1ns

module UDC(
	input [5:0] opCode,
	output reg BR_en,
	output reg [2:0] AluC,
	output reg EnW,
	output reg EnR,
	output reg MUX1,
	output reg branch,
	output reg regDest,
	output reg ALUsrc
);

always @* begin
	case(opCode)
	6'b000000: //TIPO R
	begin
		BR_en = 1'b1; //regwrite
		AluC = 3'b000;//aluop
		EnW = 1'b0;//memwrite
		EnR = 1'b0;//memread
		MUX1 = 1'b0;//memtoreg
		branch = 1'b0;//branch
		regDest = 1'b1;//regdst
		ALUsrc = 1'b0;//alusrc
	end
	6'b001000: //ADDI
	begin
		BR_en = 1'b1;
		AluC = 3'b001;
		EnW = 1'b0;
		EnR = 1'b0;
		MUX1 = 1'b0;
		branch = 1'b0;
		regDest = 1'b0;
		ALUsrc = 1'b1;
	end
	6'b001101: //ORI
	begin
		BR_en = 1'b1;
		AluC = 3'b010;
		EnW = 1'b0;
		EnR = 1'b0;
		MUX1 = 1'b0;
		branch = 1'b0;
		regDest = 1'b0;
		ALUsrc = 1'b1;
	end
	6'b001100: //ANDI
	begin
		BR_en = 1'b1;
		AluC = 3'b011;
		EnW = 1'b0;
		EnR = 1'b0;
		MUX1 = 1'b0;
		branch = 1'b0;
		regDest = 1'b0;
		ALUsrc = 1'b1;
	end
	6'b100011: //LW
	begin
		BR_en = 1'b1; //regwrite
		AluC = 3'b001;//aluop
		EnW = 1'b0;//memwrite
		EnR = 1'b1;//memread
		MUX1 = 1'b1;//memtoreg
		branch = 1'b0;//branch
		regDest = 1'b0;//regdst
		ALUsrc = 1'b1;//alusrc
	end
	6'b101011: //SW
	begin
		BR_en = 1'b0; //regwrite
		AluC = 3'b001;//aluop
		EnW = 1'b1;//memwrite
		EnR = 1'b0;//memread
		MUX1 = 1'b0;//memtoreg
		branch = 1'b0;//branch
		regDest = 1'b0;//regdst
		ALUsrc = 1'b1;//alusrc
	end
	6'b001010: //SLTI
	begin
		BR_en = 1'b1;
		AluC = 3'b100;
		EnW = 1'b0;
		EnR = 1'b0;
		MUX1 = 1'b0;
		branch = 1'b0;
		regDest = 1'b0;
		ALUsrc = 1'b1;
	end
	6'b000100: //BEQ
	begin
		BR_en = 1'b0;//regwrite
		AluC = 3'b101;//aluop
		EnW = 1'b0;//memwrite
		EnR = 1'b0;//memread
		MUX1 = 1'b0;//memtoreg
		branch = 1'b1;//branch
		regDest = 1'b0;//regdst
		ALUsrc = 1'b0;//alusrc
	end
	endcase
end

endmodule

