`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:18:11 11/11/2022 
// Design Name: 
// Module Name:    M_DM 
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
module M_DM(
	 input clk,
	 input reset,
    input [31:0] WD_M,
    input [31:0] ALUOUT_M,
    input DMWr_M,
	 input [31:0] PC4_M,
    output [31:0] DMOUT_M
    );

reg [31:0] mem [0:3071];
wire [31:0] address;
wire [31:0] PC;

assign address = {1'b0, 1'b0, {ALUOUT_M[31:2]}};
assign PC = PC4_M - 4;

integer i;
initial begin
	for(i = 0;i <= 3071;i = i + 1)begin
		mem[i] = 32'b0;
	end
end

always @(posedge clk)begin
	if(reset)begin
		for(i = 0; i <= 3071;i = i + 1)begin
			mem[i]  <= 32'b0;
		end
	end
	else begin
		if(DMWr_M)begin
			mem[address] <= WD_M;
			$display("%d@%h: *%h <= %h", $time, PC, ALUOUT_M, WD_M);
		end
	end
end

assign DMOUT_M = mem[address];

endmodule
