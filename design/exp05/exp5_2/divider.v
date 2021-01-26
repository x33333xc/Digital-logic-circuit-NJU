module divider(clk, clk_1hz);//divide the clk
	input clk;
	output reg clk_1hz=0;
	reg[36:0] count_clk=0;
	always@(posedge clk)
	begin
		if(count_clk==25000000) begin
			count_clk<=0;
			clk_1hz=~clk_1hz;
		end
		else
			count_clk=count_clk+1;
	end
	
endmodule
