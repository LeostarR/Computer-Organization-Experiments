`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:08 11/10/2022 
// Design Name: 
// Module Name:    D_EXT 
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
module D_EXT(
    input [15:0] IMM_D,
    input EXTOP,
    output [31:0] EXT_D
    );

assign EXT_D =    (EXTOP == 1'b0) ? {{16{1'b0}}, IMM_D} :
					   (EXTOP == 1'b1) ? {{16{IMM_D[15]}}, IMM_D}:
						32'b0 ;

endmodule
