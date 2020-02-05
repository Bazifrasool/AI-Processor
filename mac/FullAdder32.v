//`include "FullAdder16.v"
module FullAdder32(a,b,c,sum,carry);
input [31:0] a,b;
input c;
output [31:0] sum;
output carry;
wire c1;

FullAdder16 FA0(a[15:0],b[15:0],c,sum[15:0],c1);
FullAdder16 FA1(a[31:16],b[31:16],c1,sum[31:16],carry);
endmodule
