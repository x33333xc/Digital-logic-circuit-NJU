module random_data(
		 input clk_60,
		 input reset,
		 input [7:0]ori,
		 output reg [7:0] random_data
		 );
		 
reg [5:0]count;
reg [7:0] in;
always @(negedge clk_60)
begin
	if (reset) 
	begin
	 random_data<=ori;
	 in<=random_data[4]^random_data[3]^random_data[2]^random_data[0];
	 count=0;
	end
	else
	begin
	if (count==20)
	begin
		random_data<={in,random_data[7:1]};
		in<=random_data[4]^random_data[3]^random_data[2]^random_data[0]^(~(random_data[1]|random_data[2]|random_data[3]|random_data[4]|random_data[5]|random_data[6]|random_data[7]));
		count=0;
	end
	else
	count=count+1;
	end
end
endmodule