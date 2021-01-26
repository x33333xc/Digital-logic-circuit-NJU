module Trigger(d,clk,clr1,clr2,q1,q2);
	input d,clk,clr1,clr2;
	output q1,q2;
	mysynchro A(d,clk,clr1,q1);
	myasynchro B(d,clk,clr2,q2);
	
endmodule
	