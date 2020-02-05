`include "fulladder64bit.v"

module fullsubtractor64bit(a,b,ci,sum,co);

input [63:0] a,b;
input ci;
output [63  :0] sum;
output co;

wire c1;
wire[63:0] bc;
assign bc=~b;
fulladder64bit f1(a[63:0],bc[63:0],ci,sum[63:0],c1);


endmodule
