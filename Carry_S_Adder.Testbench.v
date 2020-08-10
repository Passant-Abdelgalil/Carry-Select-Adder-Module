module tb();
reg [15:0]A;
reg [15:0]B;
reg cin;
wire [15:0]sum;
wire cout;

Select_Carry_Adder sC (A,B,cin,cout,sum); 
initial begin
$monitor("Time=%g",$time,"A=%b,B=%b,Cin=%b : Sum= %b,Cout=%b",A,B,cin,sum,cout);
#1 A= 16'b0000000000011111; B=16'b000000000001100; cin=1'b0;
#1 A= 16'b1100011000011111; B=16'b000000110001100; cin=1'b1;
#1 A= 16'b1111111111111111; B=16'b000000000000000; cin=1'b1;
#1 A= 16'b1001001001001001; B=16'b1001001001001001; cin=1'b1;
end
endmodule
