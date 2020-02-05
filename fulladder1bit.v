module fulladder1bit(a,b,cin,sum,cout);

input a,b,cin;
output sum,cout;
wire k;
assign k=a^b;
assign sum = k^cin;
assign cout = (k&cin) | (a&b);

endmodule   
