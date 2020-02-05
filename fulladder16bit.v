`include "fulladder8bit.v"

module fulladder16bit(a,b,ci,sum,co);

input [15:0] a,b;
input ci;
output [15:0] sum;
output co;
wire c1;
fulladder8bit f1(a[7:0],b[7:0],ci,sum[7:0],c1);
fulladder8bit f2(a[15:8],b[15:8],c1,sum[15:8],co);

endmodule
