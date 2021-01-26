module exam00(A,B,C);
	input A,B;
	output C;
	
	assign C = ~A&B|A&~B;
	
endmodule
