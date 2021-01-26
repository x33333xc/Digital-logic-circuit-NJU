module timer(clk,start,pause,reset,out0,out1,isEnd);
	input clk,start,pause,reset;
	output [6:0]out0,out1;
	output reg isEnd=0;
	reg [3:0]a0=0;
	reg [3:0]a1=0;
	wire clk_1s;
	divider Div(clk,clk_1s);
	
	always@(posedge clk_1s) begin
		if(reset==1) begin
			a0<=0;
			a1<=0;
		end else if(pause==1) begin
			a0<=a0;
			a1<=a1;
		end else if(start==1) begin
			if(a0==9)begin
				if(a1==9)begin
					a0<=0;
					a1<=0;
					isEnd<=1;
				end
				else begin
					a0<=0;
					a1<=a1+1;
					isEnd=0;
				end
			end
			else begin
				a0<=a0+1;
				isEnd=0;
			end
		end	
	end
	decoder D1(a0,out0);
	decoder D2(a1,out1);
endmodule	