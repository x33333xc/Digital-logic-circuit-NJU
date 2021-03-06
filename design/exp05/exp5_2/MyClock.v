
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================
module MyClock(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SW //////////
	input 		     [9:0]		SW,
	input								BTN,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// Seg7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5
);

//=======================================================
//  REG/WIRE declarations
//=======================================================

clock myClock (CLOCK2_50,HEX4,HEX5,HEX2,HEX3,HEX0,HEX1,SW[9:2],BTN,SW[1:0]);

//=======================================================
//  Structural coding
//=======================================================
endmodule



