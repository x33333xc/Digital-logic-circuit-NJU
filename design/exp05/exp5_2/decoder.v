module decoder(A,B);
	input [3:0]A;
	output reg[6:0]B;
	always @(*) begin
		case(A)
			 0: B<=7'b1000000;      		//0        
			 1: B<=7'b1111001;      		//1        
			 2: B<=7'b0100100;      		//2        
			 3: B<=7'b0110000;      		//3        
			 4: B<=7'b0011001;      		//4        
			 5: B<=7'b0010010;      		//5        
			 6: B<=7'b0000010;      		//6        
			 7: B<=7'b1111000;      		//7 
			 8: B<=7'b0000000; 				//8
			 9: B<=7'b0010000;				//9
			 
		
		default: B<=7'b1000000;				//0
			
	endcase
	end
endmodule
