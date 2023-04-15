`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:40:12 11/11/2022 
// Design Name: 
// Module Name:    M_MUX 
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
module M_MUX(
    input [31:0] A2_M,
    input [31:0] Result_W,
    input FSel1_M,
    output [31:0] WD_M
    );

assign WD_M = (FSel1_M == 0) ? Result_W : A2_M;

endmodule
