`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:26 11/12/2022 
// Design Name: 
// Module Name:    W_Aregister 
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
module W_Aregister(
    input clk,
    input reset,
    input [31:0] INSTR_M,
    input [4:0] RegWrite_M,
    input [31:0] ALUOUT_M,
    input [31:0] DMOUT_M,
    input [31:0] PC4_M,
    output [31:0] INSTR_W,
    output [4:0] RegWrite_W,
    output [31:0] ALUOUT_W,
    output [31:0] DMOUT_W,
    output [31:0] PC4_W
    );

reg [31:0] INSTR;
reg [4:0] RegWrite;
reg [31:0] ALUOUT;
reg [31:0] DMOUT;
reg [31:0] PC4;

always @(posedge clk) begin
	if(reset)begin
		INSTR <= 0;
		RegWrite <= 0;
		ALUOUT <= 0;
		DMOUT <= 0;
		PC4 <= 0;
	end
	else begin
		INSTR <= INSTR_M;
		RegWrite <= RegWrite_M;
		ALUOUT <= ALUOUT_M;
		DMOUT <= DMOUT_M;
		PC4 <= PC4_M;
	end
end

assign INSTR_W = INSTR;
assign RegWrite_W = RegWrite;
assign ALUOUT_W = ALUOUT;
assign DMOUT_W = DMOUT;
assign PC4_W = PC4;

endmodule
