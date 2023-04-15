`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:52 10/28/2022 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] PC,//PC
    output [5:0] opcode,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [5:0] func,
    output [15:0] imm,
    output [25:0] index
    );

reg [31:0] mem [0:4095];
wire [31:0] ins;
wire [31:0] dex;
wire [31:0] addr;

initial begin
		$readmemh("code.txt",mem);
		//addr <= 32'h0;
end



assign	addr = PC - 32'h0000_3000;
assign	dex = {1'b0, 1'b0, {addr[31:2]}};
assign	ins = mem[dex];


assign opcode = ins[31:26];
assign rs = ins[25:21];
assign rt = ins[20:16];
assign rd = ins[15:11];
assign func = ins[5:0];
assign imm = ins[15:0];
assign index = ins[25:0];

endmodule
