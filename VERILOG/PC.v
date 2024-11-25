`timescale 1ns/1ns

module PC (
    input clk,
    input [31:0] PCin,
    output reg [31:0] PCout
);

initial begin
    PCout = 32'd0;
end

always @(posedge clk)
    begin
        PCout = (PCin) ? PCin : 32'd0;
    end
    
endmodule