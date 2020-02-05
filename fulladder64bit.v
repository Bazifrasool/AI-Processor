`include "fulladder32bit.v"

module fulladder64bit(a,b,ci,sum,co);

input [63:0] a,b;
input ci;
output [63  :0] sum;
output co;

wire c1;

fulladder32bit f1(a[31:0],b[31:0],ci,sum[31:0],c1);
fulladder32bit f2(a[63:32],b[63:32],c1,sum[63:32],co);

endmodule
