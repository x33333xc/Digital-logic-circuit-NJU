module rand(clk,num1,num0,rand_num);
	input clk;
	output [6:0]num1,num0;
	output reg[7:0]rand_num=255;
	
	always@(posedge clk) begin
		rand_num<={rand_num[4]^rand_num[3]^rand_num[2]^rand_num[0],rand_num[7:1]};
	end
	
	
	decoder d1(rand_num[3:0],num0);
	decoder d2(rand_num[7:4],num1);
	
	
endmodule
