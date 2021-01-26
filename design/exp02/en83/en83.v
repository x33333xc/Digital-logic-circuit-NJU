module en83(x, en, y, sign, z);
	input [7:0] x;
	input en;
	output reg sign;
	output reg[2:0] y;
	output reg[6:0] z;//HEX_LED
	integer i=0;
	always @(*)
		begin
			if(en == 1) begin
				y=0;
				//for(i=0; i<=7; i=i+1)
					//if(x[i]==1) begin 
					//y=i;
					//trans(y,z);
					//end
				casex(x)
					8'b00000001: y=0;
					8'b0000001x: y=1;
					8'b000001xx: y=2;
					8'b00001xxx: y=3;
					8'b0001xxxx: y=4;
					8'b001xxxxx: y=5;
					8'b01xxxxxx: y=6;
					8'b1xxxxxxx: y=7;
				default y=0;
				endcase
			end
			else y=0;
			//trans(y,z);
			if(y)	sign=1;
			else sign=0;
	case(y)
			3'b000: z<=7'b1000000;		//0
			3'b001: z<=7'b1111001;		//1
			3'b010: z<=7'b0100100;		//2
			3'b011: z<=7'b0110000;		//3
			3'b100: z<=7'b0011001;		//4
			3'b101: z<=7'b0010010;		//5
			3'b110: z<=7'b0000010;		//6
			3'b111: z<=7'b1111000;		//7	
	default: z<=7'b1111111;
	endcase	
	end
			
endmodule
	