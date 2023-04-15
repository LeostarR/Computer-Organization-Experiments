`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:11:20 10/28/2022 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input [31:0] PC,//PC
    input [31:0] WD,//MUX3
    input RFWr,//ctrl
	 input clk,//mips
	 input reset,//mips
    input [4:0] RegAddr,//MUX1
    input [4:0] rs,//IM
	 input [4:0] rt,//IM
    output [31:0] RD1,
	 output [31:0] RD2
    );
	 
integer i;

reg [31:0] grf [1:31];

assign RD1 = (rs != 0)? grf[rs] : 32'b0;
assign RD2 = (rt != 0)? grf[rt] : 32'b0;

initial begin
	for(i = 1;i <= 31;i = i + 1)begin
		grf[i] <= 0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		for(i = 1;i <= 31;i = i + 1)begin
			grf[i] <= 0;
		end
	end
	else begin
		if(RFWr)begin
			if(RegAddr != 0)begin
				grf[RegAddr] <= WD;
			end
			$display("@%h: $%d <= %h", PC, RegAddr, WD);
		end
	end
end

endmodule
