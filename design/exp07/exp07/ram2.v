module ram2(
	input clk,
	input we,
	input [3:0] inaddr,
	input [3:0] outaddr,
	input [7:0] din,
	output [7:0] dout=0
);	
	ram2port(clk,din,inaddr,outaddr,we,dout);
endmodule
