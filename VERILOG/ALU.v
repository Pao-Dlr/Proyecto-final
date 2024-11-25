`timescale 1ns/1ns

module AND(
	input [31:0] A,
	input [31:0] B,
	output [31:0] S
);

assign S = A & B;

endmodule

module and1(
	input A,
	input B,
	output S
);

assign S = A & B;

endmodule

module OR(
	input [31:0] A,
	input [31:0] B,
	output [31:0] S
);

assign S = A | B;

endmodule

module add(
	input [31:0] A,
	input [31:0] B,
	output [31:0] S
);

assign S = A + B;

endmodule

module subs(
	input [31:0] A,
	input [31:0] B,
	output [31:0] S
);

assign S = A - B;

endmodule

module setLessThan(
	input [31:0] A,
	input [31:0] B,
	output [31:0] S
);

assign S = A < B;

endmodule



module ALU(
	input[31:0] op1,
	input[31:0] op2,
	input[2:0] sel,
	output reg [31:0] SALU,
	output reg ZF
);

wire[31:0] C1, C2, C3, C4, C5, C6, C7;

AND I1(.A(op1),.B(op2),.S(C1));
OR I2(.A(op1),.B(op2),.S(C2));
add I3(.A(op1),.B(op2),.S(C3));
subs I4(.A(op1),.B(op2),.S(C4));
setLessThan I5(.A(op1),.B(op2),.S(C5));


always @(*) begin
	case(sel)
		3'b000 : SALU = C1;
		3'b001 : SALU = C2;
		3'b010 : SALU = C3;
		3'b011 : SALU = C4;
		3'b100 : SALU = C5;
		3'b101 : SALU = 32'd1;
	default: 
		SALU = 32'd0;
	endcase
end

always@(*) begin
	if(SALU == 0) begin
		ZF = 1'b1;
	end
end

always@(*) begin
	if(SALU != 0) begin
		ZF = 1'b0;
	end
end

endmodule


