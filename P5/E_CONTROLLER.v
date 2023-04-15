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
    output [2:0] ALUOP,
    output [4:0] rs_E,
    output [4:0] rt_E,
    output RFWr_E,
	 output [2:0] Tnew_E,
	 output [1:0] RSel_E
	 //output load
    );

wire [5:0] opcode;
wire [5:0] func;

assign opcode = INSTR_E[31:26];
assign func = INSTR_E[5:0];

assign add = (opcode == 6'b000000 && func == 6'b100000)? 1 : 0;
assign sub = (opcode == 6'b000000 && func == 6'b100010)? 1 : 0;
assign ori = (opcode == 6'b001101)? 1 : 0;
assign lw = (opcode == 6'b100011)? 1 : 0;
assign sw = (opcode == 6'b101011)? 1 : 0;
assign beq = (opcode == 6'b000100)? 1 : 0;
assign lui = (opcode == 6'b001111)? 1 : 0;
assign jal = (opcode == 6'b000011)? 1 : 0;
assign jr = (opcode == 6'b000000 && func == 6'b001000)? 1 : 0;

assign ASel_E = ori | lw | sw | lui;

assign ALUOP[0] = sub | lui;
assign ALUOP[1] = ori | lui;
assign ALUOP[2] = 0;

assign rs_E = INSTR_E [25:21];
assign rt_E = INSTR_E [20:16];

assign RFWr_E = add | sub | ori | lw | lui | jal;
assign Tnew_E = (add | sub | ori | lui == 1) ? 3'b001 :
				  (lw == 1) ? 3'b010 :
				  (jal | jr == 1) ? 3'b000 :
				  3'b111;
				 
assign RSel_E[0] = lw;
assign RSel_E[1] = jal; 

//assign load = lw;

endmodule
