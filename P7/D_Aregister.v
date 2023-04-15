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
    output [31:0] INSTR_D,
    output [31:0] PC4_D,
	 input [3:0] F_ExcCode,
	 output [3:0] D_OldCode,
	 input Req,
	 input BD_F,
	 output BD_D,
	 input pcRange
    );


reg [31:0] INSTR;
reg [31:0] PC4;
reg [3:0] code;
reg BD;
wire EN_D;
assign EN_D = !(stall | BUSY | start);

wire [31:0] INSTR_F;
assign INSTR_F = i_inst_rdata;

always @(posedge clk) begin
	if(reset | Req ) begin
		INSTR <= 0;
		PC4 <= (reset == 1) ? 0 : 32'h0000_4180;
		code <= 0;
		BD <= 0;
	end
	else begin
		if(EN_D)begin
			INSTR <= INSTR_F;
			PC4 <= PC4_F;
			code <= F_ExcCode;
			BD <= BD_F;
		end
	end
end

assign INSTR_D = INSTR;
assign PC4_D = PC4;
assign D_OldCode = code;
assign BD_D = BD;

endmodule
