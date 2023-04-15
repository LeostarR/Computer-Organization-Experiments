`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:49 12/10/2022 
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
    input clk,                    // 时钟信号
    input reset,                  // 同步复位信号
    input interrupt,              // 外部中断信号
    output [31:0] macroscopic_pc, // 宏观 PC

    output [31:0] i_inst_addr,    // IM 读取地址（取指 PC）
    input  [31:0] i_inst_rdata,   // IM 读取数据

    output [31:0] m_data_addr,    // DM 读写地址
    input  [31:0] m_data_rdata,   // DM 读取数据
    output [31:0] m_data_wdata,   // DM 待写入数据
    output [3 :0] m_data_byteen,  // DM 字节使能信号

    output [31:0] m_int_addr,     // 中断发生器待写入地址
    output [3 :0] m_int_byteen,   // 中断发生器字节使能信号

    output [31:0] m_inst_addr,    // M 级 PC

    output w_grf_we,              // GRF 写使能信号
    output [4 :0] w_grf_addr,     // GRF 待写入寄存器编号
    output [31:0] w_grf_wdata,    // GRF 待写入数据

    output [31:0] w_inst_addr     // W 级 PC
);

wire [31:0] B_data_rdata;
wire [31:0] B_data_addr;
wire [31:0] B_data_wdata;
wire [3 :0] B_data_byteen;
wire enT1;
wire enT2;
wire [31:0] Dout1;
wire [31:0] Dout2;
wire IRQ1;
wire IRQ2;
wire [5:0] HWInt;
wire Req;

cpu CPU (
    .clk(clk), 
    .reset(reset), 
    .i_inst_rdata(i_inst_rdata), 
    .m_data_rdata(B_data_rdata), //b
    .i_inst_addr(i_inst_addr), 
    .m_data_addr(B_data_addr), //b
    .m_data_wdata(B_data_wdata), //b
    .m_data_byteen(B_data_byteen), //b
    .m_inst_addr(m_inst_addr), 
    .w_grf_we(w_grf_we), 
    .w_grf_addr(w_grf_addr), 
    .w_grf_wdata(w_grf_wdata), 
    .w_inst_addr(w_inst_addr), 
    .HWInt(HWInt), //b
    .macroscopic_pc(macroscopic_pc), 
    //.m_int_addr(m_int_addr), //b
    //.m_int_byteen(m_int_byteen),//b,
	 .Req(Req)
    );

BRIDGE bridge (
    .B_data_addr(B_data_addr), 
    .B_data_wdata(B_data_wdata), 
    .B_data_byteen(B_data_byteen), 
    .m_data_rdata(m_data_rdata), 
    .B_data_rdata(B_data_rdata), 
    .m_data_addr(m_data_addr), 
    .m_data_wdata(m_data_wdata), 
    .m_data_byteen(m_data_byteen),
	 .enT1(enT1),
	 .enT2(enT2),
	 .Dout1(Dout1),
	 .Dout2(Dout2),
	 .IRQ1(IRQ1),
	 .IRQ2(IRQ2),
	 .interrupt(interrupt),
	 .HWInt(HWInt),
	 .Req(Req),
	 .m_int_addr(m_int_addr),
	 .m_int_byteen(m_int_byteen)
    );	
	
TC Timer1 (
    .clk(clk), 
    .reset(reset), 
    .Addr(m_data_addr[31:2]), 
    .WE(enT1), 
    .Din(m_data_wdata), 
    .Dout(Dout1), 
    .IRQ(IRQ1)
    );

TC Timer2 (
    .clk(clk), 
    .reset(reset), 
    .Addr(m_data_addr[31:2]), 
    .WE(enT2), 
    .Din(m_data_wdata), 
    .Dout(Dout2), 
    .IRQ(IRQ2)
    );	 

endmodule
