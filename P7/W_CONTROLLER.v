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
    output [2:0] RSel_W,
	 output Tnew_W
    );

wire add, sub, ori, lw, sw, lui, jal, jr, beq;
wire bne, andd, orr, slt, sltu, addi, andi;
wire lb, lh, sb, sh;
wire mult, multu, div, divu, mfhi, mflo, mthi, mtlo;

wire [5:0] opcode;
wire [5:0] func;
wire [4:0] rs;

assign opcode = INSTR_W[31:26];
assign func = INSTR_W[5:0];
assign rs = INSTR_W[25:21];

assign add = (opcode == 6'b000000 && func == 6'b100000)? 1 : 0;
assign sub = (opcode == 6'b000000 && func == 6'b100010)? 1 : 0;
assign ori = (opcode == 6'b001101)? 1 : 0;
assign lw = (opcode == 6'b100011)? 1 : 0;
assign sw = (opcode == 6'b101011)? 1 : 0;
assign beq = (opcode == 6'b000100)? 1 : 0;
assign lui = (opcode == 6'b001111)? 1 : 0;
assign jal = (opcode == 6'b000011)? 1 : 0;
assign jr = (opcode == 6'b000000 && func == 6'b001000)? 1 : 0;

assign bne = (opcode == 6'b000101)? 1 : 0;
assign andd = (opcode == 6'b000000 && func == 6'b100100)? 1 : 0;
assign orr = (opcode == 6'b000000 && func == 6'b100101)? 1 : 0;
assign slt = (opcode == 6'b000000 && func == 6'b101010)? 1 : 0;
assign sltu = (opcode == 6'b000000 && func == 6'b101011)? 1 : 0;
assign addi = (opcode == 6'b001000)? 1 : 0;
assign andi = (opcode == 6'b001100)? 1 : 0;

assign lb = (opcode == 6'b100000)? 1 : 0;
assign lh = (opcode == 6'b100001)? 1 : 0;
assign sb = (opcode == 6'b101000)? 1 : 0;
assign sh = (opcode == 6'b101001)? 1 : 0;

assign mult = (opcode == 6'b000000 && func == 6'b011000)? 1 : 0;
assign multu = (opcode == 6'b000000 && func == 6'b011001)? 1 : 0;
assign div = (opcode == 6'b000000 && func == 6'b011010)? 1 : 0;
assign divu = (opcode == 6'b000000 && func == 6'b011011)? 1 : 0;
assign mfhi = (opcode == 6'b000000 && func == 6'b010000)? 1 : 0;
assign mflo = (opcode == 6'b000000 && func == 6'b010010)? 1 : 0;
assign mthi = (opcode == 6'b000000 && func == 6'b010001)? 1 : 0;
assign mtlo = (opcode == 6'b000000 && func == 6'b010011)? 1 : 0;

//P7
wire mfc0, mtc0;
wire eret;
wire syscall;
assign mfc0 = (opcode == 6'b010000 && rs == 5'b00000) ? 1 : 0;
assign mtc0 = (opcode == 6'b010000 && rs == 5'b00100) ? 1 : 0;
assign eret = (opcode == 6'b010000 && func == 6'b011000 && INSTR_W[25:6] == 20'h80000) ? 1 : 0;
assign syscall = (opcode == 6'b000000 && func == 6'b001100) ? 1 : 0;

assign RFWr_W = add | sub | ori | lw | lui | jal | andd | orr | slt | sltu | addi | andi | lb | lh | mfhi | mflo | mfc0;
assign RSel_W[0] = lw | lb | lh | mfhi | mflo;
assign RSel_W[1] = jal | mfhi | mflo; 
assign RSel_W[2] = mfc0;
assign Tnew_W = (add | sub | ori | lw | lui | jal | andd | orr | slt | sltu | addi | andi | lb | lh | mfhi | mflo | mfc0 == 1) ? 0 : 1;
endmodule
