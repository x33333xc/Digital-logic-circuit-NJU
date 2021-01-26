module clock(clk,phr0,phr1,pmin0,pmin1,psec0,psec1,set,confirm,type);
	//input clk,start,pause,reset,confirm;
	input clk,confirm;
	input [7:0]set;
	input	[1:0]type;
	output [6:0]phr0,phr1,pmin0,pmin1,psec0,psec1;
	reg[3:0] hr0,hr1,min0,min1,sec0,sec1;
	wire clk_1s;
	reg isEndSec=0;
	reg isEndMin=0;
	divider div(clk,clk_1s);
	always@(posedge clk_1s) begin
		if(confirm==0) begin
			case(type)
				1:begin sec1=set[7:4]; sec0=set[3:0]; end
				2:begin min1=set[7:4]; min0=set[3:0]; end
				3:begin hr1=set[7:4]; hr0=set[3:0]; end
			default:;
			endcase
		end
			if(sec0==9)begin
				if(sec1==5)begin
					sec0=0;
					sec1=0;
					isEndSec=1;
					isEndMin=0;				
				end
				else begin
					sec0=0;
					sec1=sec1+1;
					isEndSec=0;
					isEndMin=0;
				end
			end
			else begin
				sec0=sec0+1;
				isEndSec=0;
				isEndMin=0;
			end
			if(isEndSec==1) begin
				if(min0==9)begin
					if(min1==5)begin
						min0=0;
						min1=0;
						isEndMin=1;
					end
					else begin
						min0=0;
						min1=min1+1;
						isEndMin=0;
					end
				end
				else begin
					min0=min0+1;
					isEndMin=0;
				end
			end
			
			if(isEndMin==1) begin
				if(hr0==9) begin
					hr0=0;
					hr1=hr1+1;
				end
				else if(hr0==3) begin
					if(hr1==2) begin
						hr0=0;
						hr1=0;
					end
				end
				else hr0=hr0+1;
			end
	end
	decoder D1(hr0,phr0);
	decoder D2(hr1,phr1);
	decoder D3(min0,pmin0);
	decoder D4(min1,pmin1);
	decoder D5(sec0,psec0);
	decoder D6(sec1,psec1);
	
	
endmodule
	