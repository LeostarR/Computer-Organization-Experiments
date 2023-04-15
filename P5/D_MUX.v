`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:19 11/11/2022 
// Design Name: 
// Module Name:    D_MUX 
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
module D_MUX1(
	 input [31:0] PC4_E,
	 input [31:0] PC4_M,
    input [31:0] ALUOUT_M,
    input [31:0] Result_W,
	 input [31:0] RD1_D,
    input [2:0] FSel1_D,
    output [31:0] A1_D
    );

assign A1_D = (FSel1_D == 3'b000) ? PC4_E + 4 :
				  (FSel1_D == 3'b001) ? PC4_M + 4 :
				  (FSel1_D == 3'b010) ? ALUOUT_M :
				  (FSel1_D == 3'b011) ? Result_W :
				  RD1_D;

endmodule


module D_MUX2(
	 input [31:0] PC4_E,
	 input [31:0] PC4_M,
    input [31:0] ALUOUT_M,
    input [31:0] Result_W,
	 input [31:0] RD2_D,
    input [2:0] FSel2_D,
    output [31:0] A2_D
    );

assign A2_D = (FSel2_D == 3'b000) ? PC4_E + 4 :
				  (FSel2_D == 3'b001) ? PC4_M + 4 :
				  (FSel2_D == 3'b010) ? ALUOUT_M :
				  (FSel2_D == 3'b011) ? Result_W :
				  RD2_D;
endmodule


module D_MUX3(
	input [4:0] rt_D,
	input [4:0] rd_D,
	input [1:0] WSel_D,
	output [4:0] RegWrite_D
	);
	
assign RegWrite_D = (WSel_D == 2'b00) ? rt_D :
						  (WSel_D == 2'b01) ? rd_D :
						  31;
						 
endmodule
