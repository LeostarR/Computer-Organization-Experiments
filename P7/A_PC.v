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
	 input BUSY,
	 input start,
    output [31:0] i_inst_addr,
	 input [31:0] EPCOut,
	 input eret_D,
	 input Req
    );

reg [31:0] code;
wire EN_PC;

initial begin
	code <= 32'h0000_3000;
end

assign EN_PC = !(stall | BUSY | start);

always @(posedge clk)begin
	if(reset | Req)begin
		code <= (reset == 1) ? 32'h0000_3000 : 32'h0000_4180;
	end
	else begin
		if(EN_PC)begin
			code <= NPC_F;
		end
	end
end

assign i_inst_addr = (eret_D == 1) ? EPCOut : code;

endmodule
