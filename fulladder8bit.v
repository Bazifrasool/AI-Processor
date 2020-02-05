`include "fulladder4bit.v"

module fulladder8bit(a,b,ci,sum,co);

input [7:0] a,b;
input ci;
output  [7:0] sum;
output co;

wire c1;

fulladder4bit f1(a[3:0],b[3:0],ci,sum[3:0],c1);
fulladder4bit f2(a[7:4],b[7:4],c1,sum[7:4],co);


endmodule
