`timescale 1ns/1ns

module TOP_LEVEL_TB();

reg clk_TB;

topLevel DUV(.clk(clk_TB));

always #50 clk_TB = ~clk_TB;

initial begin
clk_TB = 0;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
#100;
$stop;
end
endmodule

