`include "FullAdder16.v"
`include "HalfAdder.v"
module wallace(a,b,prod);
input[7:0] a,b;
output [15:0] prod;
wire [7:0] p0;
wire [8:1] p1;
wire [9:2] p2;
wire [10:3] p3;
wire [11:4] p4;
wire [12:5] p5;
wire [13:6] p6;
wire [14:7] p7;
wire[9:0] s11;    //s1-stage 1-group
wire[12:3] s12;
wire[10:0] s21;
wire[14:5] s22;
wire[14:0] s31;
wire[15:0] s41;//wire[14:0]  s41;
wire[9:2] c11;
wire[12:5] c12;
wire[12 :3] c21;
wire[14:7] c22;
wire[14:4] c31;
wire [15:0] c41;//wire[15:5] c41;

genvar i;
generate
for(i=0;i<=4;i=i+1)
  assign c41[i]=1'b0;
endgenerate
assign s41[15]=1'b0;



/*Partial Product*/

generate
  for(i=0;i<8;i=i+1)
  begin
    assign p0[i]=a[i]&b[0];
    assign p1[i+1]=a[i]&b[1];
    assign p2[i+2]=a[i]&b[2];
    assign p3[i+3]=a[i]&b[3];
    assign p4[i+4]=a[i]&b[4];
    assign p5[i+5]=a[i]&b[5];
    assign p6[i+6]=a[i]&b[6];
    assign p7[i+7]=a[i]&b[7];
    end
endgenerate

/*Iteration 1*/

///////Group 1
assign s11[0]=p0[0];
HalfAdder h1(p0[1],p1[1],s11[1],c11[2]);
generate
for(i=2;i<=7;i=i+1)
begin
FullAdder f1(p0[i],p1[i],p2[i],s11[i],c11[i+1]);
end
endgenerate
HalfAdder h2(p1[8],p2[8],s11[8],c11[9]);
assign s11[9]=p2[9];

//////Group 2
assign s12[3]=p3[3];
HalfAdder h3(p3[4],p4[4],s12[4],c12[5]);
generate
for(i=5;i<=10;i=i+1)
begin
FullAdder f2(p3[i],p4[i],p5[i],s12[i],c12[i+1]);
end/////Group 1
assign s41[0]=s31[0];

endgenerate
HalfAdder h4(p4[11],p5[11],s12[11],c12[12]);
assign s12[12]=p5[12];

/*Iteration 2*/
///////Group 1
assign s21[0]=s11[0];
assign s21[1]=s11[1];
HalfAdder h5(s11[2],c11[2],s21[2],c21[3]);
generate
for(i=3;i<=9;i=i+1)
begin
FullAdder f3(s11[i],c11[i],s12[i],s21[i],c21[i+1]);
end
endgenerate
//HalfAdder(p1[8],p2[8],s11[8],c11[9]);
assign s21[10]=s12[10];
assign c21[11]=s12[11];
assign c21[12]=s12[12];

///////Group 2
assign s22[5]=c12[5];
HalfAdder h6(c12[6],p6[6],s22[6],c22[7]);
generate
for(i=7;i<=12;i=i+1)
begin
FullAdder f4(p7[i],p6[i],c12[i],s22[i],c22[i+1]);
end
endgenerate
HalfAdder h7(p6[13],p7[13],s22[13],c22[14]);
assign s22[14]=p7[14];


/*Iteration 3*/
///////Group 1
assign s31[0]=s21[0];
assign s31[1]=s21[1];
assign s31[2]=s21[2];
HalfAdder h8(s21[3],c21[3],s31[3],c31[4]);
HalfAdder h9(s21[4],c21[4],s31[4],c31[5]);
generate
for(i=5;i<=10;i=i+1)
begin
FullAdder f5(s21[i],c21[i],s22[i],s31[i],c31[i+1]);
end
endgenerate
HalfAdder h10(c21[11],s22[11],s31[11],c31[12]);
HalfAdder h11(c21[12],s22[12],s31[12],c31[13]);
assign s31[13]=s22[13];
assign c31[14]=s22[14];

/*Iteration 4*/
///////Group 1
assign s41[0]=s31[0];
assign s41[1]=s31[1];
assign s41[2]=s31[2];
assign s41[3]=s31[3];
HalfAdder h12(s31[4],c31[4],s41[4],c41[5]);
HalfAdder h13(s31[5],c31[5],s41[5],c41[6]);
HalfAdder h14(s31[6],c31[6],s41[6],c41[7]);
generate
for(i=7;i<=13;i=i+1)
begin
FullAdder f6(s31[i],c31[i],c22[i],s41[i],c41[i+1]);
end
endgenerate
HalfAdder h15(c31[14],c22[14],s41[14],c41[15]);

wire cin=1'b0;
wire cout;
FullAdder16 f16(s41,c41,cin,prod,cout);



endmodule
