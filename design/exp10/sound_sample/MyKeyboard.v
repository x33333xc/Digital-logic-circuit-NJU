module MyKeyboard(input clk,
						input clrn,
						input ps2_clk,
						input ps2_data,
						//output reg [7:0] data,
						output [7:0] ascii,
						output [6:0] d_digit_low,
						output [6:0] d_digit_high,
						output reg [6:0] a_digit_low,
						output reg [6:0] a_digit_high,
						output [6:0] c_digit_low,
						output [6:0] c_digit_high,
						//output reg[15:0] count,
						output reg ctrl,
						output reg shift,
						output reg up,
						output reg caps
						);
	
	reg [7:0] data;
	reg[15:0] count;
	reg clk_t;
	reg ctrl_f,shift_f,caps_f;
	integer count_clk;
	reg nextdata_n;
	wire ready;
	wire overflow;
	wire [7:0] temp_data;
	//wire [7:0] ascii;
	wire [7:0] ascii_u;
	wire [6:0] tmp_digit_low1,tmp_digit_high1,tmp_digit_low2,tmp_digit_high2;
	reg pre;
	
	initial
	begin
		clk_t=0;
		count_clk=0;
		nextdata_n=0;
		count=8'b00000000;
		data=8'b00000000;
		pre=1;
		ctrl=0;
		ctrl_f=0;
		up=0;
		shift=0;
		shift_f=0;
		caps=0;
		caps_f=0;
	end
	
	//divider
	always @ (posedge clk) begin
		if(count_clk>=100) begin
			count_clk<=0;
			clk_t=~clk_t;
		end
		else
			count_clk=count_clk+1;
	end
	
	//get ps2 info
	ps2_keyboard ps2(	
						.clk(clk),
						.clrn(clrn),
						.ps2_clk(ps2_clk),
						.ps2_data(ps2_data),
						.data(temp_data),
						.ready(ready),
						.nextdata_n(nextdata_n),
						.overflow(overflow)
					);
					
	//trans key code to ascii
	ram r1	(
						.address(data),
						.clock(clk),
						.data(8'b00000000),
						.rden(1'b1),
						.wren(1'b0),
						.q(ascii)
				);
	ram1up r2(
						.address(data),
						.clock(clk),
						.data(8'b00000000),
						.rden(1'b1),
						.wren(1'b0),
						.q(ascii_u)
				);
	//trans data to HEX
	/*
	decoder d1(data[3:0],d_digit_low);
	decoder d2(data[7:4],d_digit_high);
	
	decoder d3(ascii[3:0],tmp_digit_low1);
	decoder d4(ascii[7:4],tmp_digit_high1);
	decoder d3u(ascii_u[3:0],tmp_digit_low2);
	decoder d4u(ascii_u[7:4],tmp_digit_high2);
	
	decoder d5(count[3:0],c_digit_low);
	decoder d6(count[7:4],c_digit_high);
	*/
	
	decoder d1({~pre,data[3:0]},d_digit_low);
	decoder d2({~pre,data[7:4]},d_digit_high);
	
	decoder d3({~pre,ascii[3:0]},tmp_digit_low1);
	decoder d4({~pre,ascii[7:4]},tmp_digit_high1);
	decoder d3u({~pre,ascii_u[3:0]},tmp_digit_low2);
	decoder d4u({~pre,ascii_u[7:4]},tmp_digit_high2);
	
	decoder d5({1'b0,count[3:0]},c_digit_low);
	decoder d6({1'b0,count[7:4]},c_digit_high);
	always @(posedge clk) begin
		
		if(up==0) begin
			a_digit_low<=tmp_digit_low1;
			a_digit_high<=tmp_digit_high1;
		end
		else begin
			a_digit_low<=tmp_digit_low2;
			a_digit_high<=tmp_digit_high2;
		end
		
	end
	
	always @ (posedge clk_t) begin
		if(ready==1)
		begin
			if(temp_data[7:0]==8'h58) begin //caps
				if((pre==1)&&caps==0) begin
					up=~up;
					caps=1;
				end
				else if(pre==0) begin
					caps=0;
				end
			end
			
			if(temp_data[7:0]==8'h12||temp_data[7:0]==8'h59) begin	//shift
				if(pre==1&&shift==0) begin
					up=~up;
					shift=1;
				end
				else if(pre==0) begin
					up=~up;
					shift=0;
				end
			end
			
			if(temp_data[7:0]==8'h14) begin		//ctrl
				if(pre==1&&ctrl==0) begin
					ctrl=1;
				end
				else if(pre==0) begin
					ctrl=0;
				end
			end
			
			
			if((temp_data[7:0]!=8'hf0)&&(pre==1)) begin //keep the data
				pre=1;
				data=temp_data;
			end
			else if(temp_data[7:0]==8'hf0) begin
				pre=0;
				count=count+1;
				data=temp_data;
			end
			else if(pre==0)
				pre=1;
			
			nextdata_n=0;
		end
		else
			nextdata_n=1;
	end
	
	
	
	
endmodule

	
	