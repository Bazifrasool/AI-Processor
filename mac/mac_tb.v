`include "mac.v"
module top1;
reg [15:0] a,b;
wire [35:0] out2;
reg clk,reset;
mac m1(a,b,clk,reset,out2);
initial
begin
#10;
a=10.792933193143925;b=1;
#10;
a=-12.502467366397473;b=1;
end
initial
begin
reset=1;
clk =0;
a=16'd0;
b=16'd0;
#5 reset=0;
forever #5 clk=~clk;
end
initial
begin
#30;
$display("%d",out2);
$finish;
end
endmodule
