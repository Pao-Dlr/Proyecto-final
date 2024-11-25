`timescale 1ns/1ns

module ALUcontrol(
	input [2:0] selAlu,
	input [5:0] func,
	output reg [2:0] SaluC
);

always @* begin
	case(selAlu) 
	3'b000:
	begin
		case(func) //INSTRUCCIONES TIPO R
		6'b100100 : SaluC = 3'b000;//AND
		6'b100101 : SaluC = 3'b001;//OR
		6'b100000 : SaluC = 3'b010;//ADD
		6'b100010 : SaluC = 3'b011;//SUB
		6'b101010 : SaluC = 3'b100;//STL
		6'b000000 : SaluC = 3'b101;//NOP
		endcase
	end
	3'b001 : SaluC = 3'b010; //ADDI, SW Y LW
	3'b010 : SaluC = 3'b001; //ORI
	3'b011 : SaluC = 3'b000; //ANDI
	3'b100 : SaluC = 3'b100; //SLTI
	3'b101 : SaluC = 3'b011; //BEQ
	endcase
end

endmodule

