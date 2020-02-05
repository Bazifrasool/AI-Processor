`include "fulladder16bit.v"

module top;
reg [15:0] a,b;
reg ci;
wire [15:0] sum;
wire co;

fulladder16bit f(a,b,ci,sum,co);

initial
begin
    a=16'd8 ;
    b=16'd8;
    ci=1'b0;
    #10 a=16'd42 ;
    b=16'd88;
    ci=1'b0;
    #10 a=16'd100 ;
    b=16'd185;
    ci=1'b0;


end

initial
begin
	$monitor("%d",sum);


end

endmodule
