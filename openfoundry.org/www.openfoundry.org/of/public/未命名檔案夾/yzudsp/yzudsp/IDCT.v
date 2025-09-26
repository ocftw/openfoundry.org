`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:57 09/22/2009 
// Design Name: 
// Module Name:    idct 
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
module idct(clk,idct_out0,idct_out1,idct_out2,idct_out3,idct_out4,idct_out5,idct_out6,idct_out7);
input clk;
reg [2:0]i,j,k;
integer count;
output [11:0] idct_out0,idct_out1,idct_out2,idct_out3,idct_out4,idct_out5,idct_out6,idct_out7;
reg    [23:0] a,b,c,d,e,f,g;
reg [23:0] idct_in[7:0][7:0];
reg [47:0] tmp[7:0][7:0];
reg [23:0]tmp_int[7:0][7:0];
reg [11:0] idct_out0,idct_out1,idct_out2,idct_out3,idct_out4,idct_out5,idct_out6,idct_out7;
initial
begin 
	a = 24'b00000000000000000000_0101_1010_1000;//a
   b = 24'b00000000000000000000_0111_1101_1000;//b
   c = 24'b00000000000000000000_0111_0110_0100;//c
	d = 24'b00000000000000000000_0110_1010_0110;//d
	e = 24'b00000000000000000000_0100_0111_0001;//e
	f = 24'b00000000000000000000_0011_0000_1111;//f
	g = 24'b00000000000000000000_0001_1000_1111;//g
	///////////////////////////////////////////////////
	idct_in[0][0]=1248;
	idct_in[0][1]=-391;
	idct_in[0][2]=-416;
	idct_in[0][3]=-225;
	idct_in[0][4]=7;
	idct_in[0][5]=150;
	idct_in[0][6]=79;
	idct_in[0][7]=14;
	
	idct_in[1][0]=108;
	idct_in[1][1]=-111;
	idct_in[1][2]=45;
	idct_in[1][3]=-12;
	idct_in[1][4]=15;
	idct_in[1][5]=-13;
	idct_in[1][6]=-1;
	idct_in[1][7]=-1;
	
	idct_in[2][0]=72;
	idct_in[2][1]=-47;
	idct_in[2][2]=-41;
	idct_in[2][3]=61;
	idct_in[2][4]=-13;
	idct_in[2][5]=-15;
	idct_in[2][6]=-4;
	idct_in[2][7]=9;
	
	idct_in[3][0]=61;
	idct_in[3][1]=-38;
	idct_in[3][2]=-48;
	idct_in[3][3]=50;
	idct_in[3][4]=18;
	idct_in[3][5]=-44;
	idct_in[3][6]=5;
	idct_in[3][7]=11;
	
	idct_in[4][0]=-29;
	idct_in[4][1]=-12;
	idct_in[4][2]=89;
	idct_in[4][3]=-70;
	idct_in[4][4]=-15;
	idct_in[4][5]=27;
	idct_in[4][6]=12;
	idct_in[4][7]=-17;
	
	idct_in[5][0]=50;
	idct_in[5][1]=-46;
	idct_in[5][2]=-4;
	idct_in[5][3]=28;
	idct_in[5][4]=-26;
	idct_in[5][5]=21;
	idct_in[5][6]=-16;
	idct_in[5][7]=4;
	
	idct_in[6][0]=-87;
	idct_in[6][1]=92;
	idct_in[6][2]=-28;
	idct_in[6][3]=-26;
	idct_in[6][4]=36;
	idct_in[6][5]=-15;
	idct_in[6][6]=-4;
	idct_in[6][7]=4;
	
	idct_in[7][0]=-56;
	idct_in[7][1]=61;
	idct_in[7][2]=-29;
	idct_in[7][3]=4;
	idct_in[7][4]=-3;
	idct_in[7][5]=1;
	idct_in[7][6]=10;
	idct_in[7][7]=-10;
	i=0;
	j=0;
	k=0;
	count=-1;
end

always@(posedge clk)
begin
	
	if (count>=0 && count<=7)
	begin
		tmp[i][0]=a*idct_in[i][0]+c*idct_in[i][2]+a*idct_in[i][4]+f*idct_in[i][6]+b*idct_in[i][1]+d*idct_in[i][3]+e*idct_in[i][5]+g*idct_in[i][7];
		tmp[i][1]=a*idct_in[i][0]+f*idct_in[i][2]-a*idct_in[i][4]-c*idct_in[i][6]+d*idct_in[i][1]-g*idct_in[i][3]-b*idct_in[i][5]-e*idct_in[i][7];
		tmp[i][2]=a*idct_in[i][0]-f*idct_in[i][2]-a*idct_in[i][4]+c*idct_in[i][6]+e*idct_in[i][1]-b*idct_in[i][3]+g*idct_in[i][5]+d*idct_in[i][7];
		tmp[i][3]=a*idct_in[i][0]-c*idct_in[i][2]+a*idct_in[i][4]-f*idct_in[i][6]+g*idct_in[i][1]-e*idct_in[i][3]+d*idct_in[i][5]-b*idct_in[i][7];
		tmp[i][4]=a*idct_in[i][0]-c*idct_in[i][2]+a*idct_in[i][4]-f*idct_in[i][6]-(g*idct_in[i][1]-e*idct_in[i][3]+d*idct_in[i][5]-b*idct_in[i][7]);
		tmp[i][5]=a*idct_in[i][0]-f*idct_in[i][2]-a*idct_in[i][4]+c*idct_in[i][6]-(e*idct_in[i][1]-b*idct_in[i][3]+g*idct_in[i][5]+d*idct_in[i][7]);
		tmp[i][6]=a*idct_in[i][0]+f*idct_in[i][2]-a*idct_in[i][4]-c*idct_in[i][6]-(d*idct_in[i][1]-g*idct_in[i][3]-b*idct_in[i][5]-e*idct_in[i][7]);
		tmp[i][7]=a*idct_in[i][0]+c*idct_in[i][2]+a*idct_in[i][4]+f*idct_in[i][6]-(b*idct_in[i][1]+d*idct_in[i][3]+e*idct_in[i][5]+g*idct_in[i][7]);
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
	
   else if (count>7 && count<=15)	
	begin
		tmp[0][j]=a*idct_in[0][j]+c*idct_in[2][j]+a*idct_in[4][j]+f*idct_in[6][j]+b*idct_in[1][j]+d*idct_in[3][j]+e*idct_in[5][j]+g*idct_in[7][j];
		tmp[1][j]=a*idct_in[0][j]+f*idct_in[2][j]-a*idct_in[4][j]-c*idct_in[6][j]+d*idct_in[1][j]-g*idct_in[3][j]-b*idct_in[5][j]-e*idct_in[7][j];
		tmp[2][j]=a*idct_in[0][j]-f*idct_in[2][j]-a*idct_in[4][j]+c*idct_in[6][j]+e*idct_in[1][j]-b*idct_in[3][j]+g*idct_in[5][j]+d*idct_in[7][j];
		tmp[3][j]=a*idct_in[0][j]-c*idct_in[2][j]+a*idct_in[4][j]-f*idct_in[6][j]+g*idct_in[1][j]-e*idct_in[3][j]+d*idct_in[5][j]-b*idct_in[7][j];
		tmp[4][j]=a*idct_in[0][j]-c*idct_in[2][j]+a*idct_in[4][j]-f*idct_in[6][j]-(g*idct_in[1][j]-e*idct_in[3][j]+d*idct_in[5][j]-b*idct_in[7][j]);
		tmp[5][j]=a*idct_in[0][j]-f*idct_in[2][j]-a*idct_in[4][j]+c*idct_in[6][j]-(e*idct_in[1][j]-b*idct_in[3][j]+g*idct_in[5][j]+d*idct_in[7][j]);
		tmp[6][j]=a*idct_in[0][j]+f*idct_in[2][j]-a*idct_in[4][j]-c*idct_in[6][j]-(d*idct_in[1][j]-g*idct_in[3][j]-b*idct_in[5][j]-e*idct_in[7][j]);
		tmp[7][j]=a*idct_in[0][j]+c*idct_in[2][j]+a*idct_in[4][j]+f*idct_in[6][j]-(b*idct_in[1][j]+d*idct_in[3][j]+e*idct_in[5][j]+g*idct_in[7][j]);
		/*tmp_int[0][j]=tmp[0][j][35:12];
		tmp_int[1][j]=tmp[1][j][35:12];
		tmp_int[2][j]=tmp[2][j][35:12];
		tmp_int[3][j]=tmp[3][j][35:12];
		tmp_int[4][j]=tmp[4][j][35:12];
		tmp_int[5][j]=tmp[5][j][35:12];
		tmp_int[6][j]=tmp[6][j][35:12];
		tmp_int[7][j]=tmp[7][j][35:12];*/
		j=j+1;
	end 
	
	else if (count>15)
	begin
			idct_out0=tmp[0][k][23:12];
			idct_out1=tmp[1][k][23:12];
			idct_out2=tmp[2][k][23:12];
			idct_out3=tmp[3][k][23:12];
			idct_out4=tmp[4][k][23:12];
			idct_out5=tmp[5][k][23:12];
			idct_out6=tmp[6][k][23:12];
			idct_out7=tmp[7][k][23:12];
			k=k+1;
	end
	
	count=count+1;
	
end
endmodule
