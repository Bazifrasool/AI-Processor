`include "wallace16.v"
module top1;

reg[15:0] a,b;
wire[31:0] prod;

wallace16 w(a,b,prod);

initial
begin
  a=16'd1245; b=16'd2347; #10
  a=$random%5000; b=$random%12304;
end

initial
begin
  $monitor($time,"\ta=%d b=%d product=%d",a,b,prod);
  $dumpfile("wallace16.vcd");
  $dumpvars;
end
endmodule
