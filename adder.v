`include "fullsubtractor64bit.v"
module top;
reg signed [63:0] a,b;
reg ci;
wire signed [63:0] sum;
wire co;
fullsubtractor64bit f(a,b,ci,sum,co);
initial
begin
a=3579.5499999999997;b=3468.8199999999997;ci=1'b1;
end
initial
begin

$monitor("%d",sum);
end
endmodule
