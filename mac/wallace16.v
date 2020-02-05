`include "wallace.v"
`include "FullAdder24.v"
module wallace16(a,b,prod);
input [15:0]a,b;
output [31:0] prod;
wire [15:0] q0,q1,q2,q3;
wire [15:0] temp1,t1;
wire [23:0] temp2,temp3,t2,t3;
wire x1,x2;
assign x2=1'b0;
wallace m1(a[7:0],b[7:0],q0);
wallace m2(a[15:8],b[7:0],q1);
wallace m3(a[7:0],b[15:8],q2);
wallace m4(a[15:8],b[15:8],q3);
assign temp1={8'b0,q0[15:8]};
assign temp2={8'b0,q2[15:0]};
assign temp3={q3[15:0],8'b0};
FullAdder16 f1(temp1,q1[15:0],x2,t1,x1);
FullAdder24 f2(temp2,temp3,x2,t2,x1);
assign t3={8'b0,t1};
FullAdder24 f3(t3,t2,x2,prod[31:8],x1);
assign prod[7:0]=q0[7:0];
endmodule
