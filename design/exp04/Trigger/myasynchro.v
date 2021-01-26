module myasynchro(d,clk,clr,q);
	input d,clk,clr;
	output reg q;
	
	always @(posedge clk or posedge clr)
		begin
			if(clr)	q<=0;
			else 	q<=d;
		end
		
endmodule	

