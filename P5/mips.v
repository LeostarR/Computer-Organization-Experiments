`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:21 11/12/2022 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

wire stall;
wire [2:0] FSel1_D;
wire [2:0] FSel2_D;
wire [2:0] FSel1_E;
wire [2:0] FSel2_E;
wire FSel1_M;
wire [4:0] rs_D;
wire [4:0] rt_D;
wire [4:0] rd_D;
wire [15:0] IMM_D;
wire [25:0] INDEX_D;
wire [1:0] WSel_D;
wire EXTOP;
wire beq;
wire jr;
wire jal;
wire ASel_E;
wire [2:0] ALUOP;
wire [4:0] rs_E;
wire [4:0] rt_E;
wire DMWr_M;
wire [4:0] rt_M;
wire RFWr_W;
wire [1:0] RSel_W;
wire [31:0] INSTR_D;
wire [31:0] INSTR_E;
wire [31:0] INSTR_M;
wire [31:0] INSTR_W;
wire [4:0] RegWrite_E;
wire [4:0] RegWrite_M; 
wire [4:0] RegWrite_W;
wire [2:0] Tuse_rs; 
wire [2:0] Tuse_rt;
wire [2:0] Tnew_E; 
wire [2:0] Tnew_M;
wire Tnew_W;
//wire [4:0] rs_D;
//wire [4:0] rt_D;
//wire rt_M;
wire RFWr_E;
wire RFWr_M;
//wire RFWr_W;
wire [1:0] RSel_D;
wire [1:0] RSel_E;
wire [1:0] RSel_M;
//wire load;
//wire BR;

DATAPATH datapath (
    .clk(clk), 
    .reset(reset), 
    .stall(stall), 
    .FSel1_D(FSel1_D), 
    .FSel2_D(FSel2_D), 
    .FSel1_E(FSel1_E), 
    .FSel2_E(FSel2_E), 
    .FSel1_M(FSel1_M), 
    .rs_D(rs_D), 
    .rt_D(rt_D), 
    .rd_D(rd_D), 
    .IMM_D(IMM_D), 
    .INDEX_D(INDEX_D), 
    .WSel_D(WSel_D), 
    .EXTOP(EXTOP), 
    .beq(beq), 
    .jr(jr), 
    .jal(jal), 
    .ASel_E(ASel_E), 
    .ALUOP(ALUOP), 
    .rs_E(rs_E), 
    .rt_E(rt_E), 
    .DMWr_M(DMWr_M), 
    .rt_M(rt_M), 
    .RFWr_W(RFWr_W), 
    .RSel_W(RSel_W), 
    .INSTR_D(INSTR_D), 
    .INSTR_E(INSTR_E), 
    .INSTR_M(INSTR_M), 
    .INSTR_W(INSTR_W), 
    .RegWrite_E(RegWrite_E), 
    .RegWrite_M(RegWrite_M), 
    .RegWrite_W(RegWrite_W)
	 //.BR(BR)
    );
	 
HAZARD hazard (
    .Tuse_rs(Tuse_rs), 
    .Tuse_rt(Tuse_rt), 
    .Tnew_E(Tnew_E), 
    .Tnew_M(Tnew_M), 
    .Tnew_W(Tnew_W), 
    .rs_D(rs_D), 
    .rt_D(rt_D), 
    .rs_E(rs_E), 
    .rt_E(rt_E), 
    .rt_M(rt_M), 
    .RegWrite_E(RegWrite_E), 
    .RFWr_E(RFWr_E), 
    .RegWrite_M(RegWrite_M), 
    .RFWr_M(RFWr_M), 
    .RegWrite_W(RegWrite_W), 
	 .RSel_D(RSel_D),
	 .RSel_E(RSel_E),
	 .RSel_M(RSel_M),
    .RFWr_W(RFWr_W), 
	 //.BR(BR),
	 //.load(load),
    .stall(stall), 
    .FSel1_D(FSel1_D), 
    .FSel2_D(FSel2_D), 
    .FSel1_E(FSel1_E), 
    .FSel2_E(FSel2_E), 
    .FSel1_M(FSel1_M)
    );

D_CONTROLLER d_controller (
    .INSTR_D(INSTR_D), 
    .rs_D(rs_D), 
    .rt_D(rt_D), 
    .rd_D(rd_D), 
    .IMM_D(IMM_D), 
    .INDEX_D(INDEX_D), 
    .WSel_D(WSel_D), 
    .EXTOP(EXTOP), 
    .beq(beq), 
    .jr(jr), 
    .jal(jal), 
    .Tuse_rs(Tuse_rs), 
    .Tuse_rt(Tuse_rt),
	 .RSel_D(RSel_D)
    );
	 
E_CONTROLLER e_controller (
    .INSTR_E(INSTR_E), 
    .ASel_E(ASel_E), 
    .ALUOP(ALUOP), 
    .rs_E(rs_E), 
    .rt_E(rt_E), 
    .RFWr_E(RFWr_E), 
    .Tnew_E(Tnew_E),
	 .RSel_E(RSel_E)
	 //.load(load)
    );
	
M_CONTROLLER m_controller (
    .INSTR_M(INSTR_M), 
    .DMWr_M(DMWr_M), 
    .rt_M(rt_M), 
    .RFWr_M(RFWr_M), 
    .Tnew_M(Tnew_M),
	 .RSel_M(RSel_M)
    );
	 
W_CONTROLLER w_controller (
    .INSTR_W(INSTR_W), 
    .RFWr_W(RFWr_W), 
    .RSel_W(RSel_W), 
    .Tnew_W(Tnew_W)
    );
	 
endmodule
