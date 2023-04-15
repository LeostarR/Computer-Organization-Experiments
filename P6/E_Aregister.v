`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:42 11/11/2022 
// Design Name: 
// Module Name:    E_Aregister 
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
module E_Aregister(
	 input clk,
	 input reset,
	 input stall,
	 input start,
	 input BUSY,
	 input [31:0] INSTR_D,
    input [4:0] RegWrite_D,
    input [31:0] A1_D,
    input [31:0] A2_D,
    input [31:0] EXT_D,
    input [31:0] PC4_D,
	 output [31:0] INSTR_E,
    output [4:0] RegWrite_E,
    output [31:0] A1_E,
    output [31:0] A2_E0,
    output [31:0] EXT_E,
    output [31:0] PC4_E
    );

reg [31:0] INSTR;
reg [31:0] RegWrite;
reg [31:0] A1;
reg [31:0] A2;
reg [31:0] EXT;
reg [31:0] PC4;
wire flush;
wire EN_E;

assign flush = reset | stall | start;
assign EN_E = !(BUSY | start);

always@ (posedge clk)begin
		if(flush)begin
			INSTR <= 0;
			RegWrite <= 0;
			A1 <= 0;
			A2 <= 0;
			EXT <= 0;
			PC4 <= 0;
		end
		else begin
		if(EN_E)begin
			INSTR<= INSTR_D;
			RegWrite <= RegWrite_D;
			A1 <= A1_D;
			A2 <= A2_D;
			EXT <= EXT_D;
			PC4 <= PC4_D;
		end
	end
end

assign INSTR_E = INSTR;
assign RegWrite_E = RegWrite;
assign A1_E = A1;
assign A2_E0 = A2;
assign EXT_E = EXT;
assign PC4_E = PC4;

endmodule
