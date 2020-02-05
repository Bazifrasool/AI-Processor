//`include "FullAdder8.v"
module FullAdder24(a,b,c,sum,carry);
input [23:0] a,b;
input c;
output [23:0] sum;
output carry;
wire c1,c2;

FullAdder8 FA0(a[7:0],b[7:0],c,sum[7:0],c1);
FullAdder8 FA1(a[15:8],b[15:8],c1,sum[15:8],c2);
FullAdder8 FA2(a[23:16],b[23:16],c2,sum[23:16],carry);

endmodule
