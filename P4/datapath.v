`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:53:40 10/28/2022 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
	input clk,
	input reset,
	input beq,
	input jal,
	input jr,
	input [2:0] ALUOP,
	input EXTOP,
	input [1:0] WRSel,
	input BSel,
	input [1:0] WDSel,
	input RFWr,
	input DMWr,
	output [5:0] opcode,
	output [5:0] func
    );

wire ZERO;
wire [31:0] NPC;
//reg [31:0] code;
wire [31:0] PC;
wire [15:0] imm;
wire [25:0] index;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] ari2;
wire [31:0] OUT;
wire [31:0] EXT;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] RegAddr;
wire [31:0] Memoryout;
wire [31:0] WD;
//wire [4:0] A1;
//wire [4:0] A2;

//initial begin
//	code <= 32'h0000_3000;
//end

	 
PC pc (
    .clk(clk), 
    .reset(reset), 
    .NPC(NPC), 
    .PC(PC)
    );

NPC npc (
    .PC(PC), 
    .imm(imm), 
    .index(index), 
    .RD1(RD1), 
    .beq(beq), 
    .jal(jal), 
    .jr(jr), 
    .ZERO(ZERO), 
    .NPC(NPC)
    );

IM im (
    .PC(PC), 
    .opcode(opcode), 
    .rs(rs), 
    .rt(rt), 
    .rd(rd), 
    .func(func), 
    .imm(imm), 
    .index(index)
    );
	 
GRF grf (
    .PC(PC), 
    .WD(WD), 
    .RFWr(RFWr), 
    .clk(clk), 
    .reset(reset), 
    .RegAddr(RegAddr), 
    .rs(rs), 
    .rt(rt), 
    .RD1(RD1), 
    .RD2(RD2)
    );
	 
ALU alu(
	.RD1(RD1),
	.ari2(ari2),
	.ALUOP(ALUOP),
	.OUT(OUT),
	.ZERO(ZERO)
);

EXT ext (
    .EXTOP(EXTOP), 
    .imm(imm), 
    .EXT(EXT)
    );

MUX1 mux1 (
    .WRSel(WRSel), 
    .rt(rt), 
    .rd(rd), 
    .RegAddr(RegAddr)
    );

MUX2 mux2 (
    .RD2(RD2), 
    .EXT(EXT), 
    .BSel(BSel), 
    .ari2(ari2)
    );
	 
MUX3 mux3 (
    .OUT(OUT), 
    .Memoryout(Memoryout), 
    .PC(PC), 
    .WDSel(WDSel), 
    .WD(WD)
    );	 
	 
	 
DM dm (
    .OUT(OUT), 
    .PC(PC), 
    .clk(clk), 
    .reset(reset), 
    .RD2(RD2), 
    .DMWr(DMWr), 
	 .WDSel(WDSel),
    .Memoryout(Memoryout)
    );
	 

endmodule
