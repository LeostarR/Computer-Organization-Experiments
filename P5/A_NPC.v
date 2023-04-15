`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:48 11/11/2022 
// Design Name: 
// Module Name:    A_NPC 
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
module A_NPC(
    input [31:0] PC_F,
    input [15:0] IMM_D,
    input [25:0] INDEX_D,
    input [31:0] A1_D,
	 input BR,
	 input jal,
	 input jr,
    output [31:0] NPC_F,
    output [31:0] PC4_F
    );

assign NPC_F = (jr == 1) ? A1_D :
					(jal == 1) ? {{PC_F[31]}, {PC_F[30]}, {PC_F[29]}, {PC_F[28]}, INDEX_D, 1'b0, 1'b0} :
					(BR == 1) ? PC_F + {{14{IMM_D[15]}}, IMM_D, 1'b0, 1'b0} :
					PC_F + 4;

assign PC4_F = PC_F + 4;

endmodule
