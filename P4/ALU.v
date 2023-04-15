`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:10 10/28/2022 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] RD1,//GRF
    input [31:0] ari2,//MUX2
    input [2:0] ALUOP,//ctrl
    output [31:0] OUT,
    output ZERO
    );

wire [31:0] ari1;
assign ari1 = RD1;

assign OUT = (ALUOP == 3'b000)? ari1 + ari2:
			    (ALUOP == 3'b001)? ari1 - ari2:
				 (ALUOP == 3'b010)? ari1 | ari2:
				 ari2 << 16;
				 
assign ZERO = (ari1 == ari2)? 1 : 0;

endmodule
