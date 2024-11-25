`timescale 1ns/1ns

module instMem(
    input [31:0] i,
    output reg [31:0] S
);

    reg [31:0] mem[0:63];

    initial begin
        $readmemb("instrucciones.txt", mem);
    end

    always @(*) begin
        S = mem[i];
    end
endmodule
