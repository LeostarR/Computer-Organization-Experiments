`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:31:43 11/11/2022 
// Design Name: 
// Module Name:    M_CONTROLLER 
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
module M_CONTROLLER(
    input [31:0] INSTR_M,
    output DMWr_M,
    output [4:0] rt_M,
    output RFWr_M,
	 output [2:0] Tnew_M,
	 output [1:0] RSel_M
    );

wire [5:0] opcode;
wire [5:0] func;

assign opcode = INSTR_M[31:26];
assign func = INSTR_M[5:0];

assign add = (opcode == 6'b000000 && func == 6'b100000)? 1 : 0;
assign sub = (opcode == 6'b000000 && func == 6'b100010)? 1 : 0;
assign ori = (opcode == 6'b001101)? 1 : 0;
assign lw = (opcode == 6'b100011)? 1 : 0;
assign sw = (opcode == 6'b101011)? 1 : 0;
assign beq = (opcode == 6'b000100)? 1 : 0;
assign lui = (opcode == 6'b001111)? 1 : 0;
assign jal = (opcode == 6'b000011)? 1 : 0;
assign jr = (opcode == 6'b000000 && func == 6'b001000)? 1 : 0;

assign DMWr_M = sw;
assign rt_M = INSTR_M [20:16];
assign RFWr_M = add | sub | ori | lw | lui | jal;
assign Tnew_M = (lw == 1) ? 3'b001 :
					 (add | sub | ori | lui | jal | jr) ? 3'b000 :
					 3'b111;
					 
assign RSel_M[0] = lw;
assign RSel_M[1] = jal; 

endmodule
