`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:43 11/11/2022 
// Design Name: 
// Module Name:    E_ALU 
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
module E_ALU(
    input [31:0] ARI1_E,
    input [31:0] ARI2_E,
    input [3:0] ALUOP,
    output [31:0] ALUOUT_E,
	 output overflow
    );

reg [31:0] ALUOUT;
always @(*)begin
	if(ALUOP == 4'b0000)begin
		ALUOUT = ARI1_E + ARI2_E;
	end
	else if(ALUOP == 4'b0001)begin
		ALUOUT = ARI1_E - ARI2_E;
	end
	else if(ALUOP == 4'b0010)begin
		ALUOUT = ARI1_E | ARI2_E;
	end
	else if(ALUOP == 4'b0011)begin
		ALUOUT = ARI2_E << 16;
	end
	else if(ALUOP == 4'b0100)begin
		ALUOUT = ARI1_E & ARI2_E;
	end
	else if(ALUOP == 4'b0101)begin
		ALUOUT = $signed(ARI1_E) < $signed(ARI2_E);
	end
	else begin
		ALUOUT = ARI1_E < ARI2_E;
	end
end
assign ALUOUT_E = ALUOUT;

wire [32:0] EA;
wire [32:0] EB;
assign EA = {ARI1_E[31], ARI1_E};
assign EB = {ARI2_E[31], ARI2_E};
wire [32:0] ADD;
wire [32:0] SUB;
assign ADD = EA + EB;
assign SUB = EA - EB;

assign overflow = ((ALUOP == 4'b0000) && (ADD[32] != ADD[31])) | ((ALUOP == 4'b0001) && (SUB[32] != SUB[31]));
endmodule
