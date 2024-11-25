`timescale 1ns/1ns

module shift2(
	input [31:0] A,
	output reg [31:0] S
);

assign S = A << 2;

endmodule


