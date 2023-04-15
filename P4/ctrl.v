`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:34 10/28/2022 
// Design Name: 
// Module Name:    ctrl 
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
module ctrl(
    input [5:0] opcode,//IM
    input [5:0] func,//IM
    output RFWr,
    output EXTOP,
    output [1:0] WRSel,
    output BSel,
    output [1:0] WDSel,
    output DMWr,
    output [2:0] ALUOP,
	 output jal,
	 output jr,
	 output beq
    );
	 
wire add, sub, ori, lw, sw, lui;

assign add = (opcode == 6'b000000 && func == 6'b100000)? 1 : 0;
assign sub = (opcode == 6'b000000 && func == 6'b100010)? 1 : 0;
assign ori = (opcode == 6'b001101)? 1 : 0;
assign lw = (opcode == 6'b100011)? 1 : 0;
assign sw = (opcode == 6'b101011)? 1 : 0;
assign lui = (opcode == 6'b001111)? 1 : 0;
assign beq = (opcode == 6'b000100)? 1 : 0;
assign jal = (opcode == 6'b000011)? 1 : 0;
assign jr = (opcode == 6'b000000 && func == 6'b001000)? 1 : 0;

assign RFWr = add | sub | ori | lw | lui | jal;
assign BSel = ori | lw | sw | lui;
assign WRSel[0] = add | sub;
assign WRSel[1] = jal;
assign ALUOP[0] = sub | beq | lui;
assign ALUOP[1] = ori | lui;
assign ALUOP[2] = 0;
assign EXTOP = ori|lui;
assign WDSel[0] = lw;
assign WDSel[1] = jal;
assign DMWr = sw;


endmodule
