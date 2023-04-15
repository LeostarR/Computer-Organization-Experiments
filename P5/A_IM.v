`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:32 11/11/2022 
// Design Name: 
// Module Name:    A_IM 
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
module A_IM(
    input [31:0] PC_F,
    output [31:0] INSTR_F
    );

wire [31:0] addr;
wire [31:0] dex;
reg [31:0] mem [0:4095];

initial begin
	$readmemh("code.txt",mem);
end

assign addr = PC_F - 32'h0000_3000;
assign dex = {1'b0, 1'b0, {addr[31:2]}};
assign INSTR_F = mem[dex];

endmodule
