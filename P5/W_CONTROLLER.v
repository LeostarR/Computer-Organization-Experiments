`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:51:43 11/11/2022 
// Design Name: 
// Module Name:    W_CONTROLLER 
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
module W_CONTROLLER(
    input [31:0] INSTR_W,
    output RFWr_W,
    output [1:0] RSel_W,
	 output Tnew_W
    );

wire [5:0] opcode;
wire [5:0] func;

assign opcode = INSTR_W[31:26];
assign func = INSTR_W[5:0];

assign add = (opcode == 6'b000000 && func == 6'b100000)? 1 : 0;
assign sub = (opcode == 6'b000000 && func == 6'b100010)? 1 : 0;
assign ori = (opcode == 6'b001101)? 1 : 0;
assign lw = (opcode == 6'b100011)? 1 : 0;
assign sw = (opcode == 6'b101011)? 1 : 0;
assign beq = (opcode == 6'b000100)? 1 : 0;
assign lui = (opcode == 6'b001111)? 1 : 0;
assign jal = (opcode == 6'b000011)? 1 : 0;
assign jr = (opcode == 6'b000000 && func == 6'b001000)? 1 : 0;

assign RFWr_W = add | sub | ori | lw | lui | jal;
assign RSel_W[0] = lw;
assign RSel_W[1] = jal; 
assign Tnew_W = (add | sub | ori | lw | lui | jal | jr  == 1) ? 0 : 1;
endmodule
