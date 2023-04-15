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
    output [31:0] ALUOUT_E
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
/*
assign ALUOUT_E = (ALUOP == 2'b00) ? ARI1_E + ARI2_E :
						(ALUOP == 2'b01) ? ARI1_E - ARI2_E :
						(ALUOP == 2'b10) ? ARI1_E | ARI2_E :
						ARI2_E << 16;*/

endmodule
