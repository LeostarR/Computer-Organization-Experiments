`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:47:03 11/24/2022 
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
    input reset,
    input [31:0] i_inst_rdata,
    input [31:0] m_data_rdata,
    output [31:0] i_inst_addr,
    output [31:0] m_data_addr,
    output [31:0] m_data_wdata,
    output [3 :0] m_data_byteen,
    output [31:0] m_inst_addr,
    output w_grf_we,
    output [4:0] w_grf_addr,
    output [31:0] w_grf_wdata,
    output [31:0] w_inst_addr
);

wire start;
wire stall;
wire [15:0] IMM_D;
wire [25:0] INDEX_D;
wire jal;
wire jr;
wire EXTOP;
wire RFWr_W;
wire [4:0] rs_D;
wire [4:0] rt_D;
wire [4:0] rd_D;
wire [2:0] FSel1_D;
wire [2:0] FSel2_D;
wire [1:0] WSel_D;
wire beq;
wire bne;
wire [31:0] INSTR_D;
wire [2:0] FSel1_E;
wire [2:0] FSel2_E;
wire ASel_E;
wire [3:0] ALUOP;
wire [2:0] HILOOP; 
wire [1:0] HILOSel_E; 
wire [1:0] WHILO;
wire [31:0] INSTR_E; 
wire [4:0] RegWrite_E;
wire BUSY; 
wire FSel1_M;  
wire [31:0] INSTR_M;
wire [4:0] RegWrite_M; 
wire [1:0] RSel_W; 
wire [31:0] INSTR_W; 
wire [4:0] RegWrite_W;
wire [31:0] Result_W;
wire [31:0] PC4_W;

DATAPATH datapath (
    .clk(clk), 
    .reset(reset), 
    .stall(stall), 
    .IMM_D(IMM_D), 
    .INDEX_D(INDEX_D), 
    .jal(jal), 
    .jr(jr), 
    .i_inst_addr(i_inst_addr), 
    .i_inst_rdata(i_inst_rdata), 
    .EXTOP(EXTOP), 
    .RFWr_W(RFWr_W), 
    .rs_D(rs_D), 
    .rt_D(rt_D), 
    .rd_D(rd_D), 
    .FSel1_D(FSel1_D), 
    .FSel2_D(FSel2_D), 
    .WSel_D(WSel_D), 
    .beq(beq), 
    .bne(bne), 
    .INSTR_D(INSTR_D), 
    .FSel1_E(FSel1_E), 
    .FSel2_E(FSel2_E), 
    .ASel_E(ASel_E), 
    .ALUOP(ALUOP), 
    .HILOOP(HILOOP), 
    .HILOSel_E(HILOSel_E), 
    .WHILO(WHILO), 
    .INSTR_E(INSTR_E), 
    .RegWrite_E(RegWrite_E), 
    //.BUSY(BUSY), 
    .FSel1_M(FSel1_M), 
    .m_data_rdata(m_data_rdata), 
    .INSTR_M(INSTR_M), 
    .RegWrite_M(RegWrite_M), 
    .m_data_byteen(m_data_byteen), 
    .m_data_wdata(m_data_wdata), 
    .m_data_addr(m_data_addr), 
    .m_inst_addr(m_inst_addr), 
    .RSel_W(RSel_W), 
    .INSTR_W(INSTR_W), 
    .RegWrite_W(RegWrite_W),
	 .Result_W(Result_W),
	 .PC4_W(PC4_W),
	 .start(start)
    );

wire [2:0] Tuse_rs;
wire [2:0] Tuse_rt;
wire [2:0] Tnew_E;
wire [2:0] Tnew_M;
wire Tnew_W;
wire [4:0] rs_E;
wire [4:0] rt_E;
wire [4:0] rt_M;
wire RFWr_E;
wire RFWr_M;	
wire [1:0] RSel_D; 
wire [1:0] RSel_E;
wire [1:0] RSel_M; 
	
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
    .RFWr_W(RFWr_W), 
    .RSel_D(RSel_D), 
    .RSel_E(RSel_E), 
    .RSel_M(RSel_M), 
    .BUSY(BUSY), 
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
    .bne(bne), 
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
    .RSel_E(RSel_E), 
    .HILOOP(HILOOP), 
    .HILOSel_E(HILOSel_E), 
    .WHILO(WHILO),
	 .start(start)
    );
		
M_CONTROLLER m_controller (
    .INSTR_M(INSTR_M), 
    //.DMWr_M(DMWr_M), 
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
	 
assign w_grf_we = RFWr_W;
assign w_grf_addr = RegWrite_W;
assign w_grf_wdata = Result_W;
assign w_inst_addr = PC4_W - 4;

endmodule
