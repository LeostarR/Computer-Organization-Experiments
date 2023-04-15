`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:26:32 11/23/2022 
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
	input clk,
	input reset,
	input stall,
	input start,
	input [15:0] IMM_D,
   input [25:0] INDEX_D,
	input jal,
	input jr,
	output [31:0] i_inst_addr,
	//D
	input [31:0] i_inst_rdata,
	input EXTOP,
	input RFWr_W,
	input [4:0] rs_D,
	input [4:0] rt_D,
	input [4:0] rd_D,
	input [2:0] FSel1_D,
	input [2:0] FSel2_D,
	input [1:0] WSel_D,
	input beq,
	input bne,
	output [31:0] INSTR_D,
	input syscall_D,
	input RI_D,
	input eret_D,
	
	//E
	input [2:0] FSel1_E,
	input [2:0] FSel2_E,
	input ASel_E,
	input [3:0] ALUOP,
	input [2:0] HILOOP,
   input [1:0] HILOSel_E,
	input [1:0] WHILO,
	output [31:0] INSTR_E,
	output [4:0] RegWrite_E,
	input ALUOV,
	
	
	//M
	input FSel1_M,
	input [31:0] m_data_rdata,
	output [31:0] INSTR_M,
   output [4:0] RegWrite_M,
	output [3:0] m_data_byteen,
	output [31:0] m_data_wdata,
	output [31:0] m_data_addr,
	output [31:0] m_inst_addr,
	input eret_M,
	input mtc0_M,
	input [4:0] rt_M,
	output [31:0] PC4_M,
	input [5:0] HWInt,
	output Req,
	input [4:0] rd_M,
	
	//W
	input [2:0] RSel_W,
	output [31:0] INSTR_W,
	output [4:0] RegWrite_W,
	output [31:0] Result_W,
	output [31:0] PC4_W
    );
	 
/*F*/
wire BE;
wire BN;
wire [31:0] NPC_F;
wire [31:0] PC4_F;
wire BD_F;

/*D*/
wire [31:0] PC4_D;
wire [31:0] EXT_D;
wire [31:0] RD1_D;
wire [31:0] RD2_D;
wire [31:0] A1_D;
wire [31:0] A2_D;
wire [4:0] RegWrite_D;
wire BD_D;

/*E*/
wire [31:0] PC4_E;
wire [31:0] A1_E;
wire [31:0] A2_E0;
wire [31:0] EXT_E;
wire [31:0] ARI1_E;
wire [31:0] A2_E;
wire [31:0] ARI2_E;
wire [31:0] ALUOUT_E;
wire [31:0] MDdata_E;
wire BUSY;
wire BD_E;

/*M*/
//wire [31:0] PC4_M;
wire [31:0] ALUOUT_M;
wire [31:0] MDdata_M;
wire [31:0] A2_M;
wire [31:0] WD_M;
wire [31:0] DMOUT_M;
//wire Req;
wire [31:0] EPCOut;
wire BD_M;

/*W*/
wire [31:0] ALUOUT_W;
wire [31:0] DMOUT_W;
wire [31:0] MDdata_W;

/***** stage F*****/
A_NPC a_npc (
    .i_inst_addr(i_inst_addr), 
    .IMM_D(IMM_D), 
    .INDEX_D(INDEX_D), 
    .A1_D(A1_D), 
    .BE(BE), 
    .BN(BN), 
    .jal(jal), 
    .jr(jr), 
    .NPC_F(NPC_F), 
    .PC4_F(PC4_F),
	 .EPCOut(EPCOut),
	 .eret_D(eret_D),
	 .Req(Req),
	 .BD_F(BD_F)
    );
	 
A_PC a_pc (
    .NPC_F(NPC_F), 
    .clk(clk), 
    .reset(reset), 
    .stall(stall), 
	 .BUSY(BUSY),
	 .start(start),
    .i_inst_addr(i_inst_addr),
	 .EPCOut(EPCOut),
	 .eret_D(eret_D),
	 .Req(Req)
    );
	
wire pc_Adel;
assign pc_Adel = ((i_inst_addr[0]|i_inst_addr[1] == 1) | (i_inst_addr > 32'h0000_6ffc || i_inst_addr < 32'h0000_3000)) & !eret_D;
wire pcRange;
assign pcRange = (i_inst_addr > 32'h0000_6ffc || i_inst_addr < 32'h0000_3000);

wire [3:0] F_ExcCode;
assign F_ExcCode = (pc_Adel == 1) ? 4 : 0;
wire [3:0] D_OldCode;

/***** stage D *****/	
D_Aregister d_register (
    .clk(clk), 
    .reset(reset), 
    .stall(stall), 
	 .BUSY(BUSY),
	 .start(start),
    .i_inst_rdata(i_inst_rdata), 
    .PC4_F(PC4_F), 
    .INSTR_D(INSTR_D), 
    .PC4_D(PC4_D),
	 .F_ExcCode(F_ExcCode),
	 .D_OldCode(D_OldCode),
	 .Req(Req),
	 .BD_F(BD_F),
	 .BD_D(BD_D),
	 .pcRange(pcRange)
    );

wire [3:0] D_ExcCode;
assign D_ExcCode = (D_OldCode != 0) ? D_OldCode :
						  (syscall_D) ? 8 :
						  (RI_D) ? 10 :
						  0;

D_EXT d_ext (
    .IMM_D(IMM_D), 
    .EXTOP(EXTOP), 
    .EXT_D(EXT_D)
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
	

D_MUX1 d_mux1 (
    .PC4_E(PC4_E), 
    .PC4_M(PC4_M), 
    .ALUOUT_M(ALUOUT_M), 
    .MDdata_M(MDdata_M), 
    .Result_W(Result_W), 
    .RD1_D(RD1_D), 
    .FSel1_D(FSel1_D), 
    .A1_D(A1_D)
    );
	 
D_MUX2 d_mux2 (
    .PC4_E(PC4_E), 
    .PC4_M(PC4_M), 
    .ALUOUT_M(ALUOUT_M), 
    .MDdata_M(MDdata_M), 
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
	 
D_CMP d_cmp (
    .A1_D(A1_D), 
    .A2_D(A2_D), 
    .beq(beq), 
    .bne(bne), 
    .BE(BE), 
    .BN(BN)
    );
	

/***** stage E *****/	
wire overflow_E;
wire [3:0] E_OldCode;

E_Aregister e_register (
    .clk(clk), 
    .reset(reset), 
    .stall(stall), 
    .BUSY(BUSY), 
	 .start(start),
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
    .PC4_E(PC4_E),
	 .D_ExcCode(D_ExcCode),
	 .E_OldCode(E_OldCode),
	 .Req(Req),
	 .BD_D(BD_D),
	 .BD_E(BD_E),
	 .RI_D(RI_D)
    );

E_MUX1 e_mux1 (
    .A1_E(A1_E), 
    .PC4_M(PC4_M), 
    .ALUOUT_M(ALUOUT_M), 
    .MDdata_M(MDdata_M), 
    .Result_W(Result_W), 
    .FSel1_E(FSel1_E), 
    .ARI1_E(ARI1_E)
    );
	 
E_MUX2 e_mux2 (
    .A2_E0(A2_E0), 
    .PC4_M(PC4_M), 
    .ALUOUT_M(ALUOUT_M), 
    .MDdata_M(MDdata_M), 
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
    .ALUOUT_E(ALUOUT_E),
	 .overflow(overflow_E)
    );
	 
wire Ov_E;
assign Ov_E = ALUOV & overflow_E;
	
E_HILO e_hilo (
    .ARI1_E(ARI1_E), 
	 .ARI2_E(ARI2_E),
    .clk(clk), 
    .reset(reset), 
    .HILOOP(HILOOP), 
    .HILOSel_E(HILOSel_E), 
    .WHILO(WHILO), 
    .MDdata_E(MDdata_E),
    .BUSY(BUSY),
	 .start(start),
	 .Req(Req)
    );	

wire [3:0] E_ExcCode;
assign E_ExcCode = (E_OldCode != 0) ? E_OldCode :
						 (Ov_E == 1) ? 12 :
						 0;

/***** stage M *****/
wire overflow_M;
wire [3:0] M_OldCode;

M_Aregister m_register (
    .clk(clk), 
    .reset(reset), 
	 .BUSY(BUSY),
    .INSTR_E(INSTR_E), 
    .RegWrite_E(RegWrite_E), 
    .A2_E(A2_E), 
    .ALUOUT_E(ALUOUT_E), 
    .PC4_E(PC4_E), 
    .MDdata_E(MDdata_E), 
    .INSTR_M(INSTR_M), 
    .RegWrite_M(RegWrite_M), 
    .A2_M(A2_M), 
    .ALUOUT_M(ALUOUT_M), 
    .PC4_M(PC4_M), 
    .MDdata_M(MDdata_M),
	 .overflow_E(overflow_E),
	 .overflow_M(overflow_M),
	 .E_ExcCode(E_ExcCode),
	 .M_OldCode(M_OldCode),
	 .Req(Req),
	 .BD_E(BD_E),
	 .BD_M(BD_M)
    );	

M_MUX m_mux (
    .A2_M(A2_M), 
    .Result_W(Result_W), 
    .FSel1_M(FSel1_M), 
    .WD_M(WD_M)
    );
	 
	 
M_DataExt m_dataext (
    .INSTR_M(INSTR_M), 
    .WD_M(WD_M), 
    .ALUOUT_M(ALUOUT_M), 
    .PC4_M(PC4_M), 
    .m_data_rdata(m_data_rdata), 
    .DMOUT_M(DMOUT_M), 
    .m_data_byteen(m_data_byteen), 
    .m_data_wdata(m_data_wdata), 
    .m_data_addr(m_data_addr), 
    .m_inst_addr(m_inst_addr),
	 .overflow_M(overflow_M),
	 .Adel_M(Adel_M),
	 .Ades_M(Ades_M)
    );

wire [3:0] M_ExcCode;
assign M_ExcCode = (M_OldCode != 0)? M_OldCode :
						 (Adel_M == 1) ? 4 :
						 (Ades_M == 1) ? 5 :
						 0;

wire [4:0] ExcCodeIn = (M_ExcCode != 0) ? {1'b0, M_ExcCode} : 5'b0;
wire [31:0] VPC = PC4_M - 4;
wire [31:0] CP0Out_M;
wire [31:0] CP0Out_W;
//wire en = mtc0_M;
//wire [31:0] CPOIn = WD_M;
//wire [4:0] CP0Add = rt_M;

CP0 m_cp0 (
    .clk(clk), 
    .reset(reset), 
    .en(mtc0_M), 
    .CP0Add(rd_M), 
    .CP0In(WD_M), 
    .CP0Out(CP0Out_M), 
    .VPC(VPC), 
    .BDIn(BD_M), 
    .ExcCodeIn(ExcCodeIn), 
    .HWInt(HWInt), 
    .EXLClr(eret_M), 
    .EPCOut(EPCOut), 
    .Req(Req)
    );
	 
/***** stage W *****/
W_Aregister w_register (
    .clk(clk), 
    .reset(reset), 
    .INSTR_M(INSTR_M), 
    .RegWrite_M(RegWrite_M), 
    .ALUOUT_M(ALUOUT_M), 
    .DMOUT_M(DMOUT_M), 
    .PC4_M(PC4_M), 
    .MDdata_M(MDdata_M), 
    .INSTR_W(INSTR_W), 
    .RegWrite_W(RegWrite_W), 
    .ALUOUT_W(ALUOUT_W), 
    .DMOUT_W(DMOUT_W), 
    .PC4_W(PC4_W), 
    .MDdata_W(MDdata_W),
	 .CP0Out_M(CP0Out_M),
	 .CP0Out_W(CP0Out_W),
	 .Req(Req)
    );
	 
W_MUX w_mux (
    .ALUOUT_W(ALUOUT_W), 
    .DMOUT_W(DMOUT_W), 
    .PC4_W(PC4_W), 
    .MDdata_W(MDdata_W), 
    .RSel_W(RSel_W), 
    .Result_W(Result_W),
	 .CP0Out_W(CP0Out_W)
    );
	 
endmodule
