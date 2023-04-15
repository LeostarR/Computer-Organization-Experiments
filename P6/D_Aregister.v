`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:19 11/10/2022 
// Design Name: 
// Module Name:    D_register 
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
module D_Aregister(
    input clk,
	 input reset,
	 input stall,
	 input BUSY,
	 input start,
    input [31:0] i_inst_rdata,
    input [31:0] PC4_F,
	//input [31:0] PC_F,
    output [31:0] INSTR_D,
    output [31:0] PC4_D
	//output [31:0] PC_D
    );

wire [31:0] INSTR_F;
reg [31:0] INSTR;
reg [31:0] PC4;
//reg [31:0] PC;
wire EN_D;

assign EN_D = !(stall | BUSY | start);
assign INSTR_F = i_inst_rdata;

always @(posedge clk) begin
	if(reset) begin
		INSTR <= 0;
		PC4 <= 0;
		//PC <= 0;
	end
	else begin
		if(EN_D)begin
			INSTR <= INSTR_F;
			PC4 <= PC4_F;
			//PC <= PC_F;
		end
	end
end

assign INSTR_D = INSTR;
assign PC4_D = PC4;
//assign PC_D = PC;

endmodule
