`include "fulladder16bit.v"

module fulladder32bit(a,b,ci,sum,co);

input [31:0] a,b;
input ci;
output [31:0] sum;
output co;

wire c1;

fulladder16bit f1(a[15:0],b[15:0],ci,sum[15:0],c1);
fulladder16bit f2(a[31:16],b[31:16],c1,sum[31:16],co);

endmodule
