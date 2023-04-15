`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:45:28 11/10/2022 
// Design Name: 
// Module Name:    D_CONTROLLER 
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
module D_CONTROLLER(
	 input [31:0] INSTR_D,
    output [4:0] rs_D,
	 output [4:0] rt_D,
	 output [4:0] rd_D,
	 output [15:0] IMM_D,
	 output [25:0] INDEX_D,
	 output [1:0] WSel_D,
    output EXTOP,
	 output beq,
	 output bne,
	 output jr,
	 output jal,
	 output [2:0] Tuse_rs,
	 output [2:0] Tuse_rt,
	 output [2:0] RSel_D,
	 output syscall_D,
	 output RI_D,
	 output eret_D
    );

wire add, sub, ori, lw, sw, lui;
wire andd, orr, slt, sltu, addi, andi;
wire lb, lh, sb, sh;
wire mult, multu, div, divu, mfhi, mflo, mthi, mtlo;

wire [5:0] opcode;
wire [5:0] func;
wire [4:0] rs;

assign opcode = INSTR_D[31:26];
assign func = INSTR_D[5:0];
assign rs = INSTR_D[25:21];

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
assign eret = (opcode == 6'b010000 && func == 6'b011000 && INSTR_D[25:6] == 20'h80000) ? 1 : 0;
assign syscall = (opcode == 6'b000000 && func == 6'b001100) ? 1 : 0;
assign nop = (opcode == 6'b000000 && func == 6'b000000) ? 1 : 0;

assign syscall_D = syscall;
assign RI_D = !(add | sub | ori | lw | sw | beq | lui | jal | jr | bne | andd | orr | slt | sltu | addi | andi | lb | lh | sb | sh | mult | multu | div | divu | mfhi | mflo | mthi | mtlo | mfc0 | mtc0 | eret | syscall | nop);

//assign RF = add | sub | ori | lw | lui | jal;
assign rs_D = INSTR_D [25:21];
assign rt_D = INSTR_D [20:16];
assign rd_D = INSTR_D [15:11];
assign IMM_D = INSTR_D [15:0];
assign INDEX_D = INSTR_D [25:0];

assign WSel_D[0] = add | sub | andd | orr | slt | sltu | mflo | mfhi;
assign WSel_D[1] = jal;
					 
assign EXTOP = lw | sw | addi | lb | lh | sb | sh;

assign Tuse_rs = (beq | jr | bne ==  1) ? 3'b000 :
					  (add | sub | ori | sw | lw | andd | orr | slt | sltu | addi | andi | lb | lh | sb | sh | mult | multu | div | divu | mtlo | mthi == 1) ? 3'b001 : 
					  3'b111;
					  
assign Tuse_rt = (beq | bne == 1) ? 3'b000 :
					  (add | sub | andd | orr | slt | sltu | mult | multu | div | divu == 1) ? 3'b001 :
					  (sw | sb | sh | mtc0 == 1) ? 3'b010 :
					  3'b111;
					  
assign RSel_D[0] = lw | lb | lh | mfhi | mflo;
assign RSel_D[1] = jal | mfhi | mflo; 
assign RSel_D[2] = mfc0;

assign eret_D = eret;
					  
endmodule
