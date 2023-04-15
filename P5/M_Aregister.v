`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:04:32 11/11/2022 
// Design Name: 
// Module Name:    M_Aregister 
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
module M_Aregister(
	 input clk,
	 input reset,
    input [31:0] INSTR_E,
    input [4:0] RegWrite_E,
    input [31:0] A2_E,
    input [31:0] ALUOUT_E,
    input [31:0] PC4_E,
    output [31:0] INSTR_M,
    output [4:0] RegWrite_M,
    output [31:0] A2_M,
    output [31:0] ALUOUT_M,
    output [31:0] PC4_M
    );

reg [31:0] INSTR;
reg [4:0] RegWrite;
reg [31:0] A2;
reg [31:0] ALUOUT;
reg [31:0] PC4;

always @(posedge clk)begin
	if(reset)begin
		INSTR <= 0;
		RegWrite <= 0;
		A2 <= 0;
		ALUOUT <= 0;
		PC4 <= 0;
	end
	else begin
			INSTR <= INSTR_E;
			RegWrite <= RegWrite_E;
			A2 <= A2_E;
			ALUOUT <= ALUOUT_E;
			PC4 <= PC4_E;
	end
end

assign INSTR_M = INSTR;
assign RegWrite_M = RegWrite;
assign A2_M = A2;
assign ALUOUT_M = ALUOUT;
assign PC4_M = PC4;

endmodule
