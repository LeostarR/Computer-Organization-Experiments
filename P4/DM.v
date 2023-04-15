`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:14 10/28/2022 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] OUT,//ALU(OUT)
	 input [31:0] PC,//PC
    input clk,//mips
    input reset,//mips
    input [31:0] RD2,//GRF
    input DMWr,//ctrl
    input [1:0]WDSel,//ctrl
    output [31:0] Memoryout
    );

wire [31:0] address;
reg [31:0] mem [0:3071];

integer i;

assign address = {1'b0, 1'b0, {OUT[31:2]}};

initial begin
	for(i = 0;i <= 3071;i = i + 1)begin
		mem[i] = 32'b0;
	end
	//out <= 32'b0;
end

always @(posedge clk)begin
	if(reset)begin
		for(i = 0; i <= 3071;i = i + 1)begin
			mem[i]  <= 32'b0;
		end
	end
	else begin
		if(DMWr)begin
			mem[address] <= RD2;
			$display("@%h: *%h <= %h", PC, OUT, RD2);
		end
	end
end

assign Memoryout = mem[address];

endmodule
