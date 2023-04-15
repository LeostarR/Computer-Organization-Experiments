`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:20:56 11/23/2022 
// Design Name: 
// Module Name:    E_HILO 
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
module E_HILO(
    input [31:0] ARI1_E,
	 input [31:0] ARI2_E,
    input clk,
    input reset,
	 input start,
    input [2:0] HILOOP,
    input [1:0] HILOSel_E,
	 input [1:0] WHILO,
    output [31:0] MDdata_E,
	 output BUSY
    );

reg [63:0] result;
reg [31:0] HI;
reg [31:0] LO;
reg busy;
reg [3:0]times;
reg [31:0] low;
reg [31:0] high;
reg [2:0] HILOTYPE;

always @(posedge clk)begin
	if(reset)begin
		HI <= 32'b0;
		LO <= 32'b0;
		busy <= 0;
		times <= 0;
		low <= 0;
		high <= 0;
		result <= 0;
	end
	else begin
		if(times == 0)begin
			HILOTYPE <= HILOOP;
			if(HILOOP == 3'b000)begin
				busy <= 1;
				times <= 5;
				result <= $signed(ARI1_E)*$signed(ARI2_E);
			end
			else if(HILOOP == 3'b001)begin
				busy <= 1;
				times <= 5;
				result <= ARI1_E*ARI2_E;
			end
			else if(HILOOP == 3'b010)begin
				busy <= 1;
				times <= 10;
				low <= $signed(ARI1_E)/$signed(ARI2_E);
				high <= $signed(ARI1_E)%$signed(ARI2_E);
			end
			else if(HILOOP == 3'b011)begin
				busy <= 1;
				times <= 10;
				low <= ARI1_E/ARI2_E;
				high <= ARI1_E%ARI2_E;
			end
			else if(WHILO == 2'b00)begin
				HI <= ARI1_E;
			end
			else if(WHILO == 2'b01)begin
				LO <= ARI1_E;
			end
			else begin
			
			end
		end
		else if(times == 1)begin
			busy <= 0;
			times <= 0;
			if(HILOTYPE == 3'b000 || HILOTYPE == 3'b001)begin
				HI <= result[63:32];
				LO <= result[31:0];
			end
			else begin
				HI <= high;
				LO <= low;
			end
		end
		else begin
			times <= times - 1;
		end
	end
end

assign BUSY = busy;

assign MDdata_E = (HILOSel_E == 2'b00)? HI :
					   (HILOSel_E == 2'b01)? LO :
						0;


endmodule
