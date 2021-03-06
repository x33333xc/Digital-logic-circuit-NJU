
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module RAM(

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// Seg7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3
);

wire [7:0] dout1;
wire [7:0] dout2;
ram1(KEY[0],SW[9],SW[3:0],SW[3:0],{6'b000000,SW[5:4]},dout1);
ram2(KEY[0],SW[9],SW[3:0],SW[3:0],{6'b000000,SW[7:6]},dout2);
decoder d0(dout1[3:0],HEX0);
decoder d1(dout1[7:4],HEX1);
decoder d2(dout2[3:0],HEX2);
decoder d3(dout2[7:4],HEX3);

//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================



endmodule
