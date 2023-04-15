`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:49:47 11/11/2022 
// Design Name: 
// Module Name:    E_CONTROLLER 
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
module E_CONTROLLER(
    input [31:0] INSTR_E,
    output ASel_E,
    output [3:0] ALUOP,
    output [4:0] rs_E,
    output [4:0] rt_E,
    output RFWr_E,
	 output [2:0] Tnew_E,
	 output [2:0] RSel_E,
	 output [2:0] HILOOP,
	 output [1:0] HILOSel_E,
	 output [1:0] WHILO,
	 output start,
	 output ALUOV,
	 output mtc0_E,
	 output [4:0] rd_E
    );
	 
wire add, sub, ori, lw, sw, lui, jal, jr, beq;
wire bne, andd, orr, slt, sltu, addi, andi;
wire lb, lh, sb, sh;
wire mult, multu, div, divu, mfhi, mflo, mthi, mtlo;

wire [5:0] opcode;
wire [5:0] func;
wire [4:0] rs;

assign opcode = INSTR_E[31:26];
assign func = INSTR_E[5:0];
assign rs = INSTR_E[25:21];

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
assign eret = (opcode == 6'b010000 && func == 6'b011000 && INSTR_E[25:6] == 20'h80000) ? 1 : 0;
assign syscall = (opcode == 6'b000000 && func == 6'b001100) ? 1 : 0;

assign ASel_E = ori | lw | sw | lui | addi | andi | lb | lh | sb | sh;

assign ALUOP[0] = sub | lui | slt ;
assign ALUOP[1] = ori | lui | orr | sltu;
assign ALUOP[2] = andd | slt | sltu | andi;
assign ALUOP[3] = 0;

assign rs_E = INSTR_E [25:21];
assign rt_E = INSTR_E [20:16];
assign rd_E = INSTR_E [15:11];

assign RFWr_E = add | sub | ori | lw | lui | jal | andd | orr | slt | sltu | addi | andi | lb | lh | mfhi | mflo | mfc0;
assign Tnew_E = (add | sub | ori | lui | andd | orr | slt | sltu | addi | andi | mfhi | mflo == 1) ? 3'b001 :
				  (lw | lb | lh | mfc0 == 1) ? 3'b010 :
				  (jal /*| jr*/ == 1) ? 3'b000 :
				  3'b111;
				 
assign RSel_E[0] = lw | lb | lh | mfhi | mflo;
assign RSel_E[1] = jal | mfhi | mflo; 
assign RSel_E[2] = mfc0;

assign HILOOP = (mult== 1) ? 3'b000 :
					 (multu  == 1) ? 3'b001 :
					 (div == 1) ? 3'b010 :
					 (divu == 1) ? 3'b011 :
					 3'b111;
					 
assign HILOSel_E = (mfhi == 1) ? 2'b00 :
					  (mflo == 1) ? 2'b01 :
					  2'b11;
				
assign WHILO = (mthi == 1) ? 2'b00 :
					(mtlo == 1) ? 2'b01 :
					2'b11;
					
assign start = (mult | multu | div | divu == 1) ? 1 : 0;

assign ALUOV = add | sub | addi;
assign mtc0_E = mtc0;

endmodule
