`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:36 10/05/2022 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output [31:0] ext
    );

assign ext = (EOp == 0)? $signed({{16{imm[15]}},imm}):
				 (EOp == 1)? imm:
				 (EOp == 2)? {imm,{16{0}}}:
				 (EOp == 3)? $signed($signed({{16{imm[15]}},imm}) << 2):
				 0;

endmodule
