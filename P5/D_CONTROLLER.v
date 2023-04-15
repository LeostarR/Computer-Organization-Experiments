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
	 output jr,
	 output jal,
	 output [2:0] Tuse_rs,
	 output [2:0] Tuse_rt,
	 output [1:0] RSel_D
    );

wire add, sub, ori, lw, sw, lui;
wire [5:0] opcode;
wire [5:0] func;

assign opcode = INSTR_D[31:26];
assign func = INSTR_D[5:0];

assign add = (opcode == 6'b000000 && func == 6'b100000)? 1 : 0;
assign sub = (opcode == 6'b000000 && func == 6'b100010)? 1 : 0;
assign ori = (opcode == 6'b001101)? 1 : 0;
assign lw = (opcode == 6'b100011)? 1 : 0;
assign sw = (opcode == 6'b101011)? 1 : 0;
assign beq = (opcode == 6'b000100)? 1 : 0;
assign lui = (opcode == 6'b001111)? 1 : 0;
assign jal = (opcode == 6'b000011)? 1 : 0;
assign jr = (opcode == 6'b000000 && func == 6'b001000)? 1 : 0;

//assign RF = add | sub | ori | lw | lui | jal;
assign rs_D = INSTR_D [25:21];
assign rt_D = INSTR_D [20:16];
assign rd_D = INSTR_D [15:11];
assign IMM_D = INSTR_D [15:0];
assign INDEX_D = INSTR_D [25:0];

assign WSel_D[0] = add | sub;
assign WSel_D[1] = jal;
					 
assign EXTOP = lw | sw;

assign Tuse_rs = (beq | jr ==  1) ? 3'b000 :
					  (add | sub | ori | sw | lw == 1) ? 3'b001 : 
					  3'b111;
					  
assign Tuse_rt = (beq == 1) ? 3'b000 :
					  (add | sub == 1) ? 3'b001 :
					  (sw == 1) ? 3'b010 :
					  3'b111;
					  
assign RSel_D[0] = lw;
assign RSel_D[1] = jal; 
					  
endmodule
