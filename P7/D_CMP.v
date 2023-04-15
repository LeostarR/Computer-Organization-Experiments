`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:16:50 11/11/2022 
// Design Name: 
// Module Name:    D_CMP 
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
module D_CMP(
    input [31:0] A1_D,
    input [31:0] A2_D,
	 input beq,
	 input bne,
    output BE,
	 output BN
    );
	 
wire EQUAL;

assign EQUAL = (A1_D == A2_D) ? 1 : 0;

assign BE = beq & EQUAL;
assign BN = bne & (!EQUAL);

endmodule
