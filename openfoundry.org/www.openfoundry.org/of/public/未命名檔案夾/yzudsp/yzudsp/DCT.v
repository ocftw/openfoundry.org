`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:57 09/22/2009 
// Design Name: 
// Module Name:    DCT 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DCT(count,clk,dct_out,scan_port,seg_out);
input clk;
output [10:0]count;
reg [2:0] i,j,k;
reg [10:0]count;
output [11:0] dct_out;
reg [11:0] dct_out;
reg    [23:0] a,b,c,d,e,f,g;
reg [23:0] dct_in[7:0][7:0];
reg [47:0] tmp[7:0][7:0];
reg [23:0]tmp_int[7:0][7:0];
reg [11:0] dct_out0,dct_out1,dct_out2,dct_out3,dct_out4,dct_out5,dct_out6,dct_out7;
reg [11:0] dct_tmp;
output [5:0]scan_port;
output [7:0]seg_out;
reg clk_div;
reg [5:0]scan_port;
reg [3:0]one,two,three,four;
reg [7:0]seg_out;
integer scan_timer;

initial
begin 
	a = 24'b000000000000_0101_1010_1000;//a
   b = 24'b000000000000_0111_1101_1000;//b
   c = 24'b000000000000_0111_0110_0100;//c
	d = 24'b000000000000_0110_1010_0110;//d
	e = 24'b000000000000_0100_0111_0001;//e
	f = 24'b000000000000_0011_0000_1111;//f
	g = 24'b000000000000_0001_1000_1111;//g
	///////////////////////////////////////////////////
	dct_in[0][0]=10;
	dct_in[0][1]=40;
	dct_in[0][2]=201;
	dct_in[0][3]=255;
	dct_in[0][4]=247;
	dct_in[0][5]=254;
	dct_in[0][6]=254;
	dct_in[0][7]=254;
	
	dct_in[1][0]=11;
	dct_in[1][1]=39;
	dct_in[1][2]=200;
	dct_in[1][3]=255;
	dct_in[1][4]=247;
	dct_in[1][5]=254;
	dct_in[1][6]=254;
	dct_in[1][7]=254;
	
	dct_in[2][0]=10;
	dct_in[2][1]=36;
	dct_in[2][2]=205;
	dct_in[2][3]=255;
	dct_in[2][4]=165;
	dct_in[2][5]=132;
	dct_in[2][6]=137;
	dct_in[2][7]=133;
	
	dct_in[3][0]=9;
	dct_in[3][1]=36;
	dct_in[3][2]=210;
	dct_in[3][3]=238;
	dct_in[3][4]=121;
	dct_in[3][5]=168;
	dct_in[3][6]=255;
	dct_in[3][7]=254;
	
	dct_in[4][0]=8;
	dct_in[4][1]=35;
	dct_in[4][2]=210;
	dct_in[4][3]=234;
	dct_in[4][4]=130;
	dct_in[4][5]=137;
	dct_in[4][6]=132;
	dct_in[4][7]=168;
	
	dct_in[5][0]=8;
	dct_in[5][1]=37;
	dct_in[5][2]=197;
	dct_in[5][3]=255;
	dct_in[5][4]=247;
	dct_in[5][5]=172;
	dct_in[5][6]=132;
	dct_in[5][7]=128;
	
	dct_in[6][0]=9;
	dct_in[6][1]=36;
	dct_in[6][2]=200;
	dct_in[6][3]=255;
	dct_in[6][4]=243;
	dct_in[6][5]=255;
	dct_in[6][6]=223;
	dct_in[6][7]=124;
	
	dct_in[7][0]=9;
	dct_in[7][1]=36;
	dct_in[7][2]=210;
	dct_in[7][3]=234;
	dct_in[7][4]=130;
	dct_in[7][5]=133;
	dct_in[7][6]=144;
	dct_in[7][7]=124;
	i=0;
	j=0;
	k=0;
	count=0;
	one=0;
	two=0;
	three=0;
	four=0;
	scan_timer = 0;
	scan_port = 6'b000001;
end
always@(posedge clk)
begin
	scan_timer = scan_timer + 1;
	if(scan_timer == 142857)
	begin
		scan_port = scan_port << 1;
		scan_timer = 0; 
	end
	if(scan_port[5] == 1)
		begin
			scan_port = 6'b000001;
		end
	
	if (count<=7 && count>=0)
	begin
		tmp[i][0]=a*(dct_in[i][0]+dct_in[i][1]+dct_in[i][2]+dct_in[i][3]+dct_in[i][4]+dct_in[i][5]+dct_in[i][6]+dct_in[i][7]);
		tmp[i][1]=b*(dct_in[i][0]-dct_in[i][7])+d*(dct_in[i][1]-dct_in[i][6])+e*(dct_in[i][2]-dct_in[i][5])+g*(dct_in[i][3]-dct_in[i][4]);
		tmp[i][2]=c*(dct_in[i][0]+dct_in[i][7])+f*(dct_in[i][1]+dct_in[i][6])-f*(dct_in[i][2]+dct_in[i][5])-c*(dct_in[i][3]+dct_in[i][4]);
		tmp[i][3]=d*(dct_in[i][0]-dct_in[i][7])-g*(dct_in[i][1]-dct_in[i][6])-b*(dct_in[i][2]-dct_in[i][5])-e*(dct_in[i][3]-dct_in[i][4]);
		tmp[i][4]=a*(dct_in[i][0]+dct_in[i][7])-a*(dct_in[i][1]+dct_in[i][6])-a*(dct_in[i][2]+dct_in[i][5])+a*(dct_in[i][3]+dct_in[i][4]);
		tmp[i][5]=e*(dct_in[i][0]-dct_in[i][7])-b*(dct_in[i][1]-dct_in[i][6])+g*(dct_in[i][2]-dct_in[i][5])+d*(dct_in[i][3]-dct_in[i][4]);
		tmp[i][6]=f*(dct_in[i][0]+dct_in[i][7])-c*(dct_in[i][1]+dct_in[i][6])+c*(dct_in[i][2]+dct_in[i][5])-f*(dct_in[i][3]+dct_in[i][4]);
		tmp[i][7]=g*(dct_in[i][0]-dct_in[i][7])-e*(dct_in[i][1]-dct_in[i][6])+d*(dct_in[i][2]-dct_in[i][5])-b*(dct_in[i][3]-dct_in[i][4]);
		tmp_int[i][0]=tmp[i][0][35:12];
		tmp_int[i][1]=tmp[i][1][35:12];
		tmp_int[i][2]=tmp[i][2][35:12];
		tmp_int[i][3]=tmp[i][3][35:12];
		tmp_int[i][4]=tmp[i][4][35:12];
		tmp_int[i][5]=tmp[i][5][35:12];
		tmp_int[i][6]=tmp[i][6][35:12];
		tmp_int[i][7]=tmp[i][7][35:12];
		i=i+1;
		
	end
	
	else if (count>7 && count <=15)
	begin
		tmp[0][j]=a*(tmp_int[0][j]+tmp_int[1][j]+tmp_int[2][j]+tmp_int[3][j]+tmp_int[4][j]+tmp_int[5][j]+tmp_int[6][j]+tmp_int[7][j]);
		tmp[1][j]=b*(tmp_int[0][j]-tmp_int[7][j])+d*(tmp_int[1][j]-tmp_int[6][j])+e*(tmp_int[2][j]-tmp_int[5][j])+g*(tmp_int[3][j]-tmp_int[4][j]);
		tmp[2][j]=c*(tmp_int[0][j]+tmp_int[7][j])+f*(tmp_int[1][j]+tmp_int[6][j])-f*(tmp_int[2][j]+tmp_int[5][j])-c*(tmp_int[3][j]+tmp_int[4][j]);
		tmp[3][j]=d*(tmp_int[0][j]-tmp_int[7][j])-g*(tmp_int[1][j]-tmp_int[6][j])-b*(tmp_int[2][j]-tmp_int[5][j])-e*(tmp_int[3][j]-tmp_int[4][j]);
		tmp[4][j]=a*(tmp_int[0][j]+tmp_int[7][j])-a*(tmp_int[1][j]+tmp_int[6][j])-a*(tmp_int[2][j]+tmp_int[5][j])+a*(tmp_int[3][j]+tmp_int[4][j]);
		tmp[5][j]=e*(tmp_int[0][j]-tmp_int[7][j])-b*(tmp_int[1][j]-tmp_int[6][j])+g*(tmp_int[2][j]-tmp_int[5][j])+d*(tmp_int[3][j]-tmp_int[4][j]);
		tmp[6][j]=f*(tmp_int[0][j]+tmp_int[7][j])-c*(tmp_int[1][j]+tmp_int[6][j])+c*(tmp_int[2][j]+tmp_int[5][j])-f*(tmp_int[3][j]+tmp_int[4][j]);
		tmp[7][j]=g*(tmp_int[0][j]-tmp_int[7][j])-e*(tmp_int[1][j]-tmp_int[6][j])+d*(tmp_int[2][j]-tmp_int[5][j])-b*(tmp_int[3][j]-tmp_int[4][j]);
		/*tmp_int2[0][j]=tmp[0][j][35:12];
		tmp_int2[1][j]=tmp[1][j][35:12];
		tmp_int2[2][j]=tmp[2][j][35:12];
		tmp_int2[3][j]=tmp[3][j][35:12];
		tmp_int2[4][j]=tmp[4][j][35:12];
		tmp_int2[5][j]=tmp[5][j][35:12];
		tmp_int2[6][j]=tmp[6][j][35:12];
		tmp_int2[7][j]=tmp[7][j][35:12];*/
		j=j+1;
	end
	else if (count>15)
	begin
		dct_out0=tmp[0][k][35:12];
		dct_out1=tmp[1][k][35:12];
		dct_out2=tmp[2][k][35:12];
		dct_out3=tmp[3][k][35:12];
		dct_out4=tmp[4][k][35:12];
		dct_out5=tmp[5][k][35:12];
		dct_out6=tmp[6][k][35:12];
		dct_out7=tmp[7][k][35:12];
		k=k+1;
		if (count==17)
		begin
			dct_out=tmp[0][0][35:12];
			dct_tmp=dct_out;
		end
	end
	if (count<=25)
		count = count+1;
	if(dct_tmp >= 1000)
		begin
			four = four + 1;
			dct_tmp = dct_tmp- 1000;
		end
   else if(dct_tmp >= 100)
		begin
			three = three + 1;
			dct_tmp = dct_tmp - 100;
			end	
	else if(dct_tmp >= 10)
		begin
			two = two + 1;
			dct_tmp = dct_tmp - 10;
		end	
	else if(dct_tmp >= 1)
		begin
			one = one + 1;
			dct_tmp = dct_tmp - 1;
		end
//////////////////////////////////////////////
end

//////////////////////////////////////////////////
always@(scan_port)
begin
	if(scan_port == 2)
		seg_out = seg7(one);		
	else if(scan_port == 4)
		seg_out = seg7(two);
	else if(scan_port == 8)
		seg_out = seg7(three);
	else if(scan_port == 16)
		seg_out = seg7(four);
end


function [7:0] seg7;
input [3:0] table_1;
begin
	case(table_1)
		4'b0000:
			seg7 = 8'b11000000;
		4'b0001:
			seg7 = 8'b11111001;	
		4'b0010:
			seg7 = 8'b10100100;
		4'b0011:
			seg7 = 8'b10110000;
		4'b0100:
			seg7 = 8'b10011001;
		4'b0101:
			seg7 = 8'b10010010;
		4'b0110:
			seg7 = 8'b10000010;
		4'b0111:
			seg7 = 8'b11111000;
		4'b1000:
			seg7 = 8'b10000000;
		4'b1001:	
			seg7 = 8'b10011000;
		default:
			seg7 = 8'b11111111;
	endcase
end
endfunction
endmodule
