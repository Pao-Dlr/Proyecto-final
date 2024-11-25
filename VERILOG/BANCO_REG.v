`timescale 1ns/1ns

module bancoDeReg(
	input [31:0] data,
	input [4:0] readDir1,
	input [4:0] readDir2,
	input [4:0] writeDir,
	input WE,
	output reg [31:0] Dato1,
	output reg [31:0] Dato2
);

reg [31:0] BR [0:63];

always @(*) begin
	if(WE) begin
		BR[writeDir] = data;
	end
		Dato1 = BR[readDir1];
		Dato2 = BR[readDir2];
end

initial
begin
	$readmemh("TEST.txt", BR);
	#10;
end

endmodule

