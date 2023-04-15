`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:21 12/10/2022 
// Design Name: 
// Module Name:    BRIDGE 
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
module BRIDGE(
	input [31:0] B_data_addr,
	input [31:0] B_data_wdata,
	input [3 :0] B_data_byteen,
	input [31:0] m_data_rdata,
	output [31:0] B_data_rdata,
	output [31:0] m_data_addr,
	output [31:0] m_data_wdata,
	output [3 :0] m_data_byteen,
	output enT1,
	output enT2,
	input [31:0] Dout1,
	input [31:0] Dout2,
	input IRQ1,
	input IRQ2,
	input interrupt,
	output [5:0] HWInt,
	input Req,
	output [31:0] m_int_addr,
	output [3:0] m_int_byteen
    );


assign m_data_addr = B_data_addr;
assign m_data_wdata = B_data_wdata;
assign m_data_byteen = (Req == 0) ? B_data_byteen : 4'b0000;
assign m_int_addr = B_data_addr/*(B_data_addr == 32'h7f20 && B_data_byteen == 4'b0001) ? B_data_addr : 0*/;
assign m_int_byteen = B_data_byteen;

wire WriteT1, WriteT2;
assign WriteT1 = (B_data_addr >= 32'h0000_7f00) && (B_data_addr <= 32'h0000_7f0b);
assign WriteT2 = (B_data_addr >= 32'h0000_7f10) && (B_data_addr <= 32'h0000_7f1b);
wire saveT1, saveT2;
assign saveT1 = (B_data_addr >= 32'h0000_7f00) && (B_data_addr < 32'h0000_7f08);
assign saveT2 = (B_data_addr >= 32'h0000_7f10) && (B_data_addr < 32'h0000_7f18);
assign enT1 = (saveT1 == 1) && (m_data_byteen == 4'b1111);
assign enT2 = (saveT2 == 1) && (m_data_byteen == 4'b1111);

assign B_data_rdata = (WriteT1 == 1) ? Dout1 :
							 (WriteT2 == 1) ? Dout2 :
							 ((B_data_addr >= 32'h0000_0000) && (B_data_addr <= 32'h0000_2fff)) ? m_data_rdata :
							 0;

assign HWInt = {3'b0, interrupt, IRQ2, IRQ1};

endmodule
