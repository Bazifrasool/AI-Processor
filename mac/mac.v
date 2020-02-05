`include "FullAdder36.v"
`include "wallace16.v"
`include "dff36.v"
module mac(a,b,clk,reset,out2);
    input [15:0] a,b;
    wire [35:0] c,d;
    output [35:0] out2;
    input clk,reset;
    wire [35:0] out1;
    wire c1,cin;
    assign cin=1'b0;
    wallace16 m1(a,b,c[31:0]);
    assign c[35:32]=4'b0000;

    FullAdder36 f1(c,d,cin,out2,c1);
    dff36 d2(out2,clk,reset,d);

endmodule
