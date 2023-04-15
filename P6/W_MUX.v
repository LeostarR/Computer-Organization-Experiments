`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:48:15 11/11/2022 
// Design Name: 
// Module Name:    W_MUX 
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
module W_MUX(
    input [31:0] ALUOUT_W,
    input [31:0] DMOUT_W,
    input [31:0] PC4_W,
	 input [31:0] MDdata_W,
    input [1:0] RSel_W,
    output [31:0] Result_W
    );

assign Result_W = (RSel_W == 2'b00) ? ALUOUT_W :
						(RSel_W == 2'b01) ? DMOUT_W :
						(RSel_W == 2'b10) ? PC4_W + 4:
						MDdata_W;

endmodule
