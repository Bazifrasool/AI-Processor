module top1;

reg[7:0] a,b;
wire[15:0] prod;

wallace w(a,b,prod);

initial
begin
  a=8'b1101_0011; b=8'b1100_1110; #10
  a=$random%3000; b=$random%2304;
end

initial
begin
  $monitor($time,"\ta=%d b=%d product=%d",a,b,prod);
  $dumpfile("wallace.vcd");
  $dumpvars;
end
endmodule
