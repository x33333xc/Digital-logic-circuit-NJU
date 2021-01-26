module exp3_2(A,B,s,res,CF,OF,ZF);
	input [3:0] A,B;	//operate num
	//input Cin;
	input [2:0] s;		//command
	
	output reg [3:0] res;
	output reg CF,OF,ZF;
	
	reg [3:0]x;
	integer i;

	
	always @(*) begin
		CF=0;
		OF=0;
		ZF=0;//initial
		case(s)
			3'd0:
				begin
					{CF,res} = A+B;
					OF = (A[3]==B[3])&&(res[3]!=A[3]);
					ZF = (res==0);
				end
			3'd1:
				begin
					x = (~B);
					{CF, res} = A + x+1;
					OF = (A[3]==x[3])&&(res[3]!=A[3]);
					ZF = (res==0);
				end
			3'd2:
				begin
					for(i=0;i<=3;i=i+1)
						res[i]=A[i]^1;
					ZF = (res==0);
					
				end
			3'd3:
				begin
					for(i=0;i<=3;i=i+1)
						res[i]=A[i]&B[i];
					ZF = (res==0);
				end
			3'd4:
				begin
					for(i=0;i<=3;i=i+1)
						res[i]=A[i]|B[i];
					ZF = (res==0);
				end
			3'd5:
				begin
				for(i=0;i<=3;i=i+1)
						res[i]=A[i]^B[i];
					ZF = (res==0);
				end
			3'd6:
				begin
					case({A[3],B[3]})
						2'b0_0: res=(A>B);
						2'b0_1: res=1;
						2'b1_0: res=0;
						2'b1_1: res=(A[2:0]>B[2:0]);
						default: res=0;
					endcase
				end
			3'd7:
				begin
					if(A==B) res=1;
					else res=0;
				end
			
		endcase
	end
	
endmodule
	
	