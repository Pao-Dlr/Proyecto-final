`timescale 1ns/1ns

module signExtend(
	input [15:0] A,
	output reg [31:0] S
);

always @(*) begin
	if(A[15] == 1'b0) begin
		S = {16'b000000000000, A};
	end else begin
		S = {16'b111111111111, A};
	end
end

endmodule

