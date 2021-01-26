module mysynchro(d,clk,clr,q);
	input d,clk,clr;
	output reg q;
	
	always @(posedge clk)
		begin
			if(clr)	q<=0;
			else 	q<=d;
		end
		
endmodule	
