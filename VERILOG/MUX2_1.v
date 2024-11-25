`timescale 1ns/1ns

module mux2_1(
	input sel,
	input [31:0] A,
	input [31:0] B,
	output reg [31:0] S
);

always @* begin
	if(sel) begin
	S = B;
	end
	else begin
	S = A;
	end
end
endmodule

module mux2_1_5b(
	input sel,
	input [4:0] A,
	input [4:0] B,
	output reg [4:0] S
);

always @* begin
	if(sel) begin
	S = B;
	end
	else begin
	S = A;
	end
end
endmodule
