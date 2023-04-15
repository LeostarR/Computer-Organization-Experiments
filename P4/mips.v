`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:35 10/28/2022 
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

wire [5:0] opcode;
wire [5:0] func;
wire beq;
wire jal;
wire jr;
wire [2:0] ALUOP;
wire EXTOP;
wire [1:0] WRSel;
wire BSel;
wire [1:0] WDSel;
wire RFWr;
wire DMWr;

datapath DATA(
    .clk(clk), 
    .reset(reset), 
    .beq(beq), 
    .jal(jal), 
    .jr(jr), 
    .ALUOP(ALUOP), 
    .EXTOP(EXTOP), 
    .WRSel(WRSel), 
    .BSel(BSel), 
    .WDSel(WDSel), 
    .RFWr(RFWr), 
    .DMWr(DMWr), 
    .opcode(opcode), 
    .func(func)
    );
	 
ctrl CTRL (
    .opcode(opcode), 
    .func(func), 
    .RFWr(RFWr), 
    .EXTOP(EXTOP), 
    .WRSel(WRSel), 
    .BSel(BSel), 
    .WDSel(WDSel), 
    .DMWr(DMWr), 
    .ALUOP(ALUOP), 
    .jal(jal), 
    .jr(jr), 
    .beq(beq)
    );

endmodule
