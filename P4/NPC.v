`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:36 10/28/2022 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC, // PC
    input [15:0] imm, //IM
	 input [25:0] index,//IM
	 input [31:0] RD1,//GRF
	 input beq,//ctrl
	 input jal,//ctrl
	 input jr,//ctrl
	 input ZERO,//ALU
    output [31:0] NPC
    );

assign NPC = (beq == 1 && ZERO == 1)? PC + 4 + {{14{imm[15]}}, imm, 1'b0, 1'b0} :
				 (jal == 1)? {{4{1'b0}},index, 1'b0, 1'b0}:
				 (jr == 1)? RD1:
				 PC + 4;

endmodule
