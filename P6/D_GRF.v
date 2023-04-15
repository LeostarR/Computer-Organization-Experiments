`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:40:03 11/09/2022 
// Design Name: 
// Module Name:    D_GRF 
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
module D_GRF(
    input clk,
    input reset,
	 input RFWr_W,
	 input [31:0] PC4_W,
    input [4:0] rs_D,
    input [4:0] rt_D,
    input [4:0] RegWrite_W,
    input [31:0] Result_W,
    output [31:0] RD1_D,
    output [31:0] RD2_D
    );

reg [31:0] GRF [1:31];

integer i;
initial begin
	for(i = 1;i <= 31;i = i + 1)begin
		GRF[i] <= 0;
	end
end

assign RD1_D = (rs_D != 0) ? GRF[rs_D] : 32'b0;
assign RD2_D = (rt_D != 0) ? GRF[rt_D] : 32'b0;

always @(posedge clk) begin
	if(reset) begin
		for(i = 1;i <= 31;i = i + 1)begin
			GRF[i] <= 0;
		end
	end
	else begin
		if(RFWr_W)begin
			if(RegWrite_W != 0)begin
				GRF[RegWrite_W] <= Result_W;
			end
			//$display("%d@%h: $%d <= %h", $time, PC4_W - 4, RegWrite_W, Result_W);
		end
	end
end

endmodule
