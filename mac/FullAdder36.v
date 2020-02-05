`include "FullAdder32.v"
module FullAdder36(a,b,c,sum,carry);
input [35:0] a,b;
input c;
output [35:0] sum;
output carry;
wire c1;

FullAdder32 FA0(a[31:0],b[31:0],c,sum[31:0],c1);
FullAdder4 FA1(a[35:32],b[35:32],c1,sum[35:32],carry);
endmodule
