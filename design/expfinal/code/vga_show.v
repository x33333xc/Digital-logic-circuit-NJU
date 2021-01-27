module vga_show(
	input vga_clk,
	input reset,
	input [9:0]score,
	input [9:0]miss,
	input[9:0] vga_haddr,
	input[9:0] vga_vaddr,
	input [9:0] mem_ascii [71:0],
	input [9:0] mem_row[71:0],
	input mem_valid[71:0],
	output reg [23:0] vga_data
	);

/***********字模点阵**********/
reg [11:0] rom [4097:0];
initial begin
	$readmemh("D:/My_design/final/vga_font.txt", rom, 0, 4097);
end

wire[11:0]c;
wire[3:0]x;
wire[3:0]y;		
reg[7:0]ascii_temp;
reg [11:0]rom_temp;
wire flag_word;
assign c=vga_haddr/9;	
assign x=vga_vaddr-mem_row[c];
assign y=vga_haddr%9; 
assign flag_word=(((vga_vaddr-mem_row[c])>=0)&&((vga_vaddr-mem_row[c])<16))?1:0;//超出就不显示


always @(negedge vga_clk)
begin
	if(c >= 5 && c < 68) begin//字符掉落界面
		if(flag_word && mem_valid[c]) begin
			ascii_temp = mem_ascii[c];
			rom_temp = rom[{ascii_temp,x}];
			vga_data =(rom_temp[y]==1)?24'h000000:24'hFFFFFF;
		end
		else
			vga_data = 24'h000000;
	end
	else if(c >= 0 && c < 5) begin//左五列
			if(vga_vaddr >= 0 && vga_vaddr <16) begin//左上角显示60FPS
				case(c)
					0: ascii_temp = 8'h36;
					1: ascii_temp = 8'h30;
					2: ascii_temp = 8'h46;
					3: ascii_temp = 8'h50;
					4: ascii_temp = 8'h53;
					default:;
				endcase
				rom_temp = rom[{ascii_temp,vga_vaddr}];
				vga_data =(rom_temp[y]==1)?24'h00FFFF:24'h000000;
			end

			else if(vga_vaddr >= 464 && vga_vaddr <= 479) begin//左下角显示分数
				case(c)
					0: ascii_temp = 8'h30 + (score/100) % 10;
					1: ascii_temp = 8'h30 + (score/10) % 10;
					2: ascii_temp = 8'h30 + score%10;
					3: ascii_temp = 8'h0;
					4: ascii_temp = 8'h0;
					default:;
				endcase
				rom_temp = rom[{ascii_temp,vga_vaddr-464}];
				vga_data =(rom_temp[y]==1)?24'h00FF00:24'h000000;
			end
	end
	else if (c >= 68 && c < 71)begin
		if(vga_vaddr >= 0 && vga_vaddr <16) begin//右上角显示时间
				case(c)
					68: ascii_temp = 8'h30 + (count_time / 100) % 10;
					69: ascii_temp = 8'h30 + (count_time / 10) % 10;
					70: ascii_temp = 8'h30 + count_time % 10;
					default:;
				endcase
				rom_temp = rom[{ascii_temp,vga_vaddr}];
				vga_data =(rom_temp[y]==1)?24'hFFFF00:24'h000000;
			end

			else if(vga_vaddr >= 464 && vga_vaddr <= 479) begin//右下角显示miss数
				case(c)
					68: ascii_temp = 8'h30 + (miss / 100) % 10;
					69: ascii_temp = 8'h30 + (miss / 10) % 10;
					70: ascii_temp = 8'h30 + miss % 10;
					default:;
				endcase
				rom_temp = rom[{ascii_temp,vga_vaddr-464}];
				vga_data =(rom_temp[y]==1)?24'hFF0000:24'h000000;
			end
		end
end
endmodule
