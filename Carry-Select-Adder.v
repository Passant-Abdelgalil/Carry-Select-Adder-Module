module Select_Carry_Adder(a,b,carryIn,carryOut,sum);
input [15:0] a;
input [15:0] b;
input carryIn;
output carryOut;
output [15:0] sum;

wire Carry0,Carry10,Carry11,Carry20,Carry21,Carry30,Carry31;
wire carryf0,carryf1;
wire c0,c1,c2,c3;
wire [3:0] s0;
wire [3:0] s1;
wire [3:0] s2;
wire [3:0] s3;
wire [3:0] s4;
wire [3:0] s5;
bit_Adder Adder1(
.A(a[3:0]),
.B(b[3:0]),
.CarryIn(carryIn),
.CarryOut(Carry0),
.Sum(sum[3:0])
);

bit_Adder Adder20(
.A(a[7:4]),
.B(b[7:4]),
.CarryIn(0),
.CarryOut(Carry10),
.Sum(s0)
);

bit_Adder Adder21(
.A(a[7:4]),
.B(b[7:4]),
.CarryIn(1),
.CarryOut(Carry11),
.Sum(s1)
);

MUX Mux1(
.In0(s0),
.In1(s1),
.c0(Carry10),
.c1(Carry11),
.sel(Carry0),
.outs(sum[7:4]),
.outc(Carryf0)
);

bit_Adder Adder30(
.A(a[11:8]),
.B(b[11:8]),
.CarryIn(0),
.CarryOut(Carry20),
.Sum(s2)
);

bit_Adder Adder31(
.A(a[11:8]),
.B(b[11:8]),
.CarryIn(1),
.CarryOut(Carry21),
.Sum(s3)
);
	
MUX Mux2(
.In0(s2),
.In1(s3),
.c0(Carry20),
.c1(Carry21),
.sel(Carryf0),
.outs(sum[11:8]),
.outc(Carryf1)
);

bit_Adder Adder40(
.A(a[15:12]),
.B(b[15:12]),
.CarryIn(0),
.CarryOut(Carry30),
.Sum(s4)
);

bit_Adder Adder41(
.A(a[15:12]),
.B(b[15:12]),
.CarryIn(1),
.CarryOut(Carry31),
.Sum(s5)
);

MUX Mux3(
.In0(s4),
.In1(s5),
.c0(Carry30),
.c1(Carry31),
.sel(Carryf1),
.outs(sum[15:12]),
.outc(carryOut)
);

endmodule

module full_adder(S, Cout, A, B, Cin);
   input  A;
   input  B;
   input  Cin;
output S;
   output Cout;   
   wire   w1;
   wire   w2;
   wire   w3;
   wire   w4;
   
   xor(w1, A, B);
   xor(S, Cin, w1);
   and(w2, A, B);   
   and(w3, A, Cin);
   and(w4, B, Cin);   
   or(Cout, w2, w3, w4);
endmodule

module bit_Adder(A,B,CarryIn,CarryOut,Sum);
input [3:0] A;
input [3:0] B;
input CarryIn;
output [3:0] Sum;
output CarryOut;

wire c0,c1,c2;
full_adder adder1(
.S(Sum[0]),
.Cout(c0),
.A(A[0]),
.B(B[0]),
.Cin(CarryIn)
);
full_adder adder2(
.S(Sum[1]),
.Cout(c1),
.A(A[1]),
.B(B[1]),
.Cin(c0)
);
full_adder adder3(
.S(Sum[2]),
.Cout(c2),
.A(A[2]),
.B(B[2]),
.Cin(c1)
);

full_adder adder4(
.S(Sum[3]),
.Cout(CarryOut),
.A(A[3]),
.B(B[3]),
.Cin(c2)
);
endmodule

module MUX(In0,In1,c0,c1,sel,outs,outc);
input [3:0] In0;
input [3:0] In1;
input c0,c1,sel;
output [3:0] outs;
output outc;

 assign outs=(sel==1'b1)?In1:In0;
assign outc=(sel==1'b1)?c1:c0;
endmodule

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
