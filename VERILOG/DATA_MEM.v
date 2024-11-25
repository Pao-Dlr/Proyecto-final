`timescale 1ns/1ns

module dataMem(
	input [31:0] writeData,
	input [31:0] dir,
	input memWrite,
	input memRead,
	output reg [31:0] readData
);

reg [31:0] dataMem [0:31];

always @(*) begin
	if(memWrite) begin
		dataMem[dir] = writeData;
	end
end
always @(*) begin
	if(memRead) begin
		readData = dataMem[dir];
	end
end

initial
begin
	$readmemh("TEST.txt", dataMem);
	#10;
end

endmodule

