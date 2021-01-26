module exp4_1_2(clk,in_d,en,out_lock1,out_lock2);
	input clk,in_d,en;
	output reg out_lock1, out_lock2;
	
	always @(posedge clk) begin
		if(en)
			begin
				out_lock1<=in_d;
				out_lock2<=out_lock1;
			end
		else
			begin
				out_lock1<=out_lock1;
				out_lock2<=out_lock2;
			end
	end
	
endmodule
		