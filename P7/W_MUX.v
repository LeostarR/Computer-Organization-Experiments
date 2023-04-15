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
    input [2:0] RSel_W,
    output [31:0] Result_W,
	 input [31:0] CP0Out_W
    );

assign Result_W = (RSel_W == 3'b000) ? ALUOUT_W :
						(RSel_W == 3'b001) ? DMOUT_W :
						(RSel_W == 3'b010) ? PC4_W + 4:
						(RSel_W == 3'b011) ? MDdata_W:
						CP0Out_W;

endmodule
