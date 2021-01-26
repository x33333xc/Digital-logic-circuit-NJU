module exp3_1(A,B,Cin,res,CF,OF,ZF);
	input [3:0] A,B;
	input Cin;
	output reg[3:0] res;
	output reg CF,OF,ZF;//carry, overflow, zero
	
	reg [3:0]x;
	reg sign;
	
	always @(*) begin
		if(Cin)
		begin
			x = B;
			sign = 0;
		end
		else 
		begin
			x = (~B);
			sign=1;
		end
		
		{CF, res} = A + x +sign;
		OF = (A[3]==x[3])&&(res[3]!=A[3]);
		if(res==0) ZF=1;
		else ZF=0;
	end
	
endmodule