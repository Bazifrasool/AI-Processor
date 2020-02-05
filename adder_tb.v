`include "fulladder64bit.v"
module top;
reg signed [63:0] a,b;
reg ci;
wire signed [63:0] sum;
wire co;
fulladder64bit f(a,b,ci,sum,co);
initial
begin
a=-34000;b=31000;ci=1'b0;
end
initial
begin

$monitor("%d",sum);
end
endmodule
