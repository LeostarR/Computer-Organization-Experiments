`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:58:49 10/28/2022 
// Design Name: 
// Module Name:    PC 
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
module PC(
	 input [31:0] NPC,
    input clk,//mips
    input reset,//mips
    output [31:0] PC
	 //output reg [31:0] code
    );
	
reg [31:0] code;

initial begin
	code <= 32'h0000_3000;
end

always @(posedge clk)begin
	if(reset)begin
		code <= 32'h0000_3000;
	end
	else begin
		code <= NPC;
	end
end

assign PC = code;

endmodule
