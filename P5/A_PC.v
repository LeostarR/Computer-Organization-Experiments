`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:00 11/11/2022 
// Design Name: 
// Module Name:    A_PC 
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
module A_PC(
    input [31:0] NPC_F,
    input clk,
    input reset,
	 input stall,
    output [31:0] PC_F
    );

reg [31:0] code;
wire EN_PC;

initial begin
	code <= 32'h0000_3000;
end

assign EN_PC = !stall;

always @(posedge clk)begin
	if(reset)begin
		code <= 32'h0000_3000;
	end
	else begin
		if(EN_PC)begin
			code <= NPC_F;
		end
	end
end

assign PC_F = code;

endmodule
