`include "fullsubtractor64bit.v"

module top;
reg [63:0] a,b;
reg ci;
wire [63:0] sum;
wire co;

fullsubtractor64bit f(a,b,ci,sum,co);

initial
begin
    a=64'd8 ;
    b=64'd1;
    ci=1'b1;


end

initial
begin
	$monitor("%d",sum);


end

endmodule
