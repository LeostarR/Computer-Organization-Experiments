`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:39 10/28/2022 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input EXTOP,//ctrl
    input [15:0] imm,//IM
    output [31:0] EXT
    );

assign EXT = (EXTOP == 0)? /*sign*/{{16{imm[15]}},imm}: {{16{1'b0}},imm};
//0-signedext//1-zeroext
endmodule
