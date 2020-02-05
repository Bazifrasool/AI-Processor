`include "dff.v"
module dff36(d,clk,reset,q);
input [35:0] d;
input clk, reset;
output [35:0]q;


genvar i;
generate
for(i=0;i<36;i=i+1)
  dff d1(d[i],clk,reset,q[i]);
endgenerate


endmodule
