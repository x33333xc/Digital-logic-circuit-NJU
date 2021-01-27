module sftReg(in,clk,left,op,out);
	input [7:0]in;
	input [2:0]op;
	input clk,left;
	output reg[7:0]out;
	
	always@(posedge clk) begin
		case(op)
			0:out=0;
			1:out=in;
			2:out<={1'b0,out[7:1]};		//shift right
			3:out<={out[6:0],1'b0};			//shift left
			4:out<={out[7],out[7:1]};		//shift arithmetic right
			5:out<={left,out[7:1]};
			6:out<={out[0],out[7:1]};		//shift circular right
			7:out<={out[6:0],out[7]};		//shift circular left
		endcase
	end


endmodule
