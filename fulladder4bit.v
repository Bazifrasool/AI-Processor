`include "fulladder1bit.v"

module fulladder4bit(a,b,ci,sum,co);

input [3:0] a;
input [3:0] b;
input ci;
output [3:0] sum;
output co;

wire c1,c2,c3;

fulladder1bit FA0(a[0],b[0],ci,sum[0],c1);
fulladder1bit FA1(a[1],b[1],c1,sum[1],c2);
fulladder1bit FA2(a[2],b[2],c2,sum[2],c3);
fulladder1bit FA3(a[3],b[3],c3,sum[3],co);

endmodule


