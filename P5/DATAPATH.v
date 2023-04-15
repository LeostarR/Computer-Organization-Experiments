`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:28 11/12/2022 
// Design Name: 
// Module Name:    DATAPATH 
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
module DATAPATH(
	 /***** INPUT*****/
	 /*****mips*****/
    input clk,
    input reset,
	 /***** HAZARD*****/
	 input stall,
	 input [2:0] FSel1_D,
    input [2:0] FSel2_D,
    input [2:0] FSel1_E,
    input [2:0] FSel2_E,
    input FSel1_M,
	 /****** D_CONTROLLER*****/
    input [4:0] rs_D,
	 input [4:0] rt_D,
	 input [4:0] rd_D,
	 input [15:0] IMM_D,
	 input [25:0] INDEX_D,
	 input [1:0] WSel_D,
    input EXTOP,
	 input beq,
	 input jr,
	 input jal,
	 
	 /***** E_CONTROLLER*****/
	 input ASel_E,
    input [2:0] ALUOP,
    input [4:0] rs_E,
    input [4:0] rt_E,
	 /***** M_CONTROLLER*****/
	 input DMWr_M,
    input [4:0] rt_M,
	 /***** W_CONTROLLER****/
	 input RFWr_W,
    input [1:0] RSel_W,
	 /***** OUTPUT*****/
	 /***** CONTROLLER*****/
	 output [31:0] INSTR_D,
	 output [31:0] INSTR_E,
	 output [31:0] INSTR_M,
	 output [31:0] INSTR_W,
	 /*****HAZARD*****/
	 output [4:0] RegWrite_E,
	 output [4:0] RegWrite_M,
	 output [4:0] RegWrite_W
	 //output BR
    );

wire [31:0] PC4_E;
wire BR;
wire [31:0] PC4_M;
wire [31:0] PC4_D;

/*****stage F*****/
wire [31:0] PC_F;
wire [31:0] INSTR_F;
wire [31:0] NPC_F;
wire [31:0] A1_D;
//wire BR;
wire [31:0] PC4_F;


A_IM a_im (
    .PC_F(PC_F), 
    .INSTR_F(INSTR_F)
    );

A_PC a_pc (
    .NPC_F(NPC_F), 
    .clk(clk), 
    .reset(reset), 
    .stall(stall), 
    .PC_F(PC_F)
    );	 
	 
A_NPC a_npc (
    .PC_F(PC_F), 
    .IMM_D(IMM_D), 
    .INDEX_D(INDEX_D), 
    .A1_D(A1_D), 
    .BR(BR), 
    .jal(jal), 
    .jr(jr), 
    .NPC_F(NPC_F), 
    .PC4_F(PC4_F)
    );

/***** stage D*****/	 
//wire [31:0] PC4_D;
wire [31:0] PC_D;
wire [31:0] PC4_W;
wire [4:0] RegWrite_D;
wire [31:0] Result_W;
wire [31:0] RD1_D;
wire [31:0] RD2_D;
wire[31:0] EXT_D;
wire [31:0] ALUOUT_M; 
//wire [31:0] A1_D;
wire [31:0] A2_D;

D_Aregister d_register (
    .clk(clk), 
    .reset(reset), 
    .stall(stall), 
    .INSTR_F(INSTR_F), 
    .PC4_F(PC4_F), 
    .PC_F(PC_F), 
    .INSTR_D(INSTR_D), 
    .PC4_D(PC4_D), 
    .PC_D(PC_D)
    );

D_GRF d_grf (
    .clk(clk), 
    .reset(reset), 
    .RFWr_W(RFWr_W), 
    .PC4_W(PC4_W), 
    .rs_D(rs_D), 
    .rt_D(rt_D), 
    .RegWrite_W(RegWrite_W), 
    .Result_W(Result_W), 
    .RD1_D(RD1_D), 
    .RD2_D(RD2_D)
    );
	 
D_EXT d_ext (
    .IMM_D(IMM_D), 
    .EXTOP(EXTOP), 
    .EXT_D(EXT_D)
    );
	 
D_CMP d_cmp (
    .A1_D(A1_D), 
    .A2_D(A2_D), 
    .beq(beq), 
    .BR(BR)
    );

D_MUX1 d_mux1 (
	 .PC4_E(PC4_E),
	 .PC4_M(PC4_M),
    .ALUOUT_M(ALUOUT_M), 
    .Result_W(Result_W), 
    .RD1_D(RD1_D), 
    .FSel1_D(FSel1_D), 
    .A1_D(A1_D)
    );
	 
D_MUX2 d_mux2 (
	 .PC4_E(PC4_E),
	 .PC4_M(PC4_M),
    .ALUOUT_M(ALUOUT_M), 
    .Result_W(Result_W), 
    .RD2_D(RD2_D), 
    .FSel2_D(FSel2_D), 
    .A2_D(A2_D)
    );
	 
D_MUX3 d_mux3 (
    .rt_D(rt_D), 
    .rd_D(rd_D), 
    .WSel_D(WSel_D), 
    .RegWrite_D(RegWrite_D)
    );
	 
/***** stage E*****/
wire [31:0] A1_E;
wire [31:0] A2_E0;
wire [31:0] A2_E;
wire [31:0] EXT_E;

wire [31:0] ARI1_E;
wire [31:0] ARI2_E;
wire [31:0] ALUOUT_E;

E_Aregister e_register (
    .clk(clk), 
    .reset(reset), 
	 .stall(stall),
    .INSTR_D(INSTR_D), 
    .RegWrite_D(RegWrite_D), 
    .A1_D(A1_D), 
    .A2_D(A2_D), 
    .EXT_D(EXT_D), 
    .PC4_D(PC4_D), 
    .INSTR_E(INSTR_E), 
    .RegWrite_E(RegWrite_E), 
    .A1_E(A1_E), 
    .A2_E0(A2_E0), 
    .EXT_E(EXT_E), 
    .PC4_E(PC4_E)
    );

E_MUX1 e_mux1 (
    .A1_E(A1_E), 
	 .PC4_M(PC4_M),
    .ALUOUT_M(ALUOUT_M), 
    .Result_W(Result_W), 
    .FSel1_E(FSel1_E), 
    .ARI1_E(ARI1_E)
    );
	 
E_MUX2 e_mux2 (
    .A2_E0(A2_E0), 
	 .PC4_M(PC4_M),
    .ALUOUT_M(ALUOUT_M), 
    .Result_W(Result_W), 
    .FSel2_E(FSel2_E), 
    .A2_E(A2_E)
    );
	 
E_MUX3 e_mux3 (
    .A2_E(A2_E), 
    .EXT_E(EXT_E), 
    .ASel_E(ASel_E), 
    .ARI2_E(ARI2_E)
    );
	 
E_ALU e_alu (
    .ARI1_E(ARI1_E), 
    .ARI2_E(ARI2_E), 
    .ALUOP(ALUOP), 
    .ALUOUT_E(ALUOUT_E)
    );
	 
/***** stage M*****/
wire [31:0] A2_M;
wire [31:0] WD_M;
wire [31:0] DMOUT_M;

M_Aregister m_register (
    .clk(clk), 
    .reset(reset), 
    .INSTR_E(INSTR_E), 
    .RegWrite_E(RegWrite_E), 
    .A2_E(A2_E), 
    .ALUOUT_E(ALUOUT_E), 
    .PC4_E(PC4_E), 
    .INSTR_M(INSTR_M), 
    .RegWrite_M(RegWrite_M), 
    .A2_M(A2_M), 
    .ALUOUT_M(ALUOUT_M), 
    .PC4_M(PC4_M)
    );
	 
M_DM m_dm (
    .clk(clk), 
    .reset(reset), 
    .WD_M(WD_M), 
    .ALUOUT_M(ALUOUT_M), 
    .DMWr_M(DMWr_M), 
    .PC4_M(PC4_M), 
    .DMOUT_M(DMOUT_M)
    );
	 
M_MUX m_mux (
    .A2_M(A2_M), 
    .Result_W(Result_W), 
    .FSel1_M(FSel1_M), 
    .WD_M(WD_M)
    );
	 
/***** stage W*****/
wire [31:0] ALUOUT_W;
wire [31:0] DMOUT_W;


W_Aregister w_register (
    .clk(clk), 
    .reset(reset), 
    .INSTR_M(INSTR_M), 
    .RegWrite_M(RegWrite_M), 
    .ALUOUT_M(ALUOUT_M), 
    .DMOUT_M(DMOUT_M), 
    .PC4_M(PC4_M), 
    .INSTR_W(INSTR_W), 
    .RegWrite_W(RegWrite_W), 
    .ALUOUT_W(ALUOUT_W), 
    .DMOUT_W(DMOUT_W), 
    .PC4_W(PC4_W)
    );
	 
W_MUX w_mux (
    .ALUOUT_W(ALUOUT_W), 
    .DMOUT_W(DMOUT_W), 
    .PC4_W(PC4_W), 
    .RSel_W(RSel_W), 
    .Result_W(Result_W)
    );

endmodule
