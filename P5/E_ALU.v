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
    input [2:0] ALUOP,
    output [31:0] ALUOUT_E
    );

reg [31:0] OUT;
always@(*)begin
	if(ALUOP == 3'b000)begin
		OUT = ARI1_E + ARI2_E;
	end
	else if(ALUOP == 3'b001)begin
		OUT = ARI1_E - ARI2_E;
	end
	else if(ALUOP == 3'b010)begin
		OUT = ARI1_E | ARI2_E;
	end
	else if(ALUOP == 3'b011)begin
		OUT = ARI2_E << 16;
	end
	else begin
	
	end
end
assign ALUOUT_E = OUT;


/*assign ALUOUT_E = (ALUOP == 3'b000) ? ARI1_E + ARI2_E :
						(ALUOP == 3'b001) ? ARI1_E - ARI2_E :
						(ALUOP == 3'b010) ? ARI1_E | ARI2_E :
						ARI2_E << 16;*/

endmodule
