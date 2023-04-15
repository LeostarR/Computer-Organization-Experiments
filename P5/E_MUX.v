`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:26 11/11/2022 
// Design Name: 
// Module Name:    E_MUX1 
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
module E_MUX1(
    input [31:0] A1_E,
	 input [31:0] PC4_M,
    input [31:0] ALUOUT_M,
    input [31:0] Result_W,
	 input [2:0] FSel1_E,
    output [31:0] ARI1_E
    );

assign ARI1_E = (FSel1_E == 3'b000) ? PC4_M + 4 :
					 (FSel1_E == 3'b001) ? ALUOUT_M :
					 (FSel1_E == 3'b010) ? Result_W :
					 A1_E;

endmodule


module E_MUX2(
	input [31:0] A2_E0,
	input [31:0] PC4_M,
	input [31:0] ALUOUT_M,
	input [31:0] Result_W,
	input [2:0] FSel2_E,
	output [31:0] A2_E
	);
	
assign A2_E = (FSel2_E == 3'b000) ? PC4_M + 4 :
				  (FSel2_E == 3'b001) ? ALUOUT_M :
				  (FSel2_E == 3'b010) ? Result_W :
				  A2_E0;
				 
endmodule


module E_MUX3(
	input [31:0] A2_E,
	input [31:0] EXT_E,
	input ASel_E,
	output [31:0] ARI2_E
	);

assign ARI2_E = (ASel_E == 0) ? A2_E : EXT_E;

endmodule





				