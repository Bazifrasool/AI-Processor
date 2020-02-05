`include "fulladder64bit.v"
module top;
reg [63:0] a,b;
reg ci;
wire [63:0] sum;
wire co;
fulladder64bit f(a,b,ci,sum,co);
initial
begin
a=64'd3;b=64'd2;ci=1'b0;
end
initial
begin

$monitor("%d",sum);
end
endmodule
