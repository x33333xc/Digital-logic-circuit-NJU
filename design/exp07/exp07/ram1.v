module ram1(
	input clk,
	input we,
	input [3:0] inaddr,
	input [3:0] outaddr,
	input [7:0] din,
	output reg [7:0] dout=0
);	
	reg[7:0]ram[15:0];
	//reg[7:0]cache;
	initial
	begin
		$readmemh("mem.txt",ram,0,15);
		
	end
	
	always@(negedge clk)begin
		if(!we) begin
			dout=ram[outaddr];
		end
		else
			ram[inaddr]<=din;
	end

endmodule
