`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:18:59 10/28/2022 
// Design Name: 
// Module Name:    MUX 
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
module MUX1(
    input [1:0] WRSel,//ctrl
    input [4:0] rt,//IM
    input [4:0] rd,//IM
    output [4:0] RegAddr
    );

assign RegAddr = (WRSel == 2'b00)? rt:
			        (WRSel == 2'b01)? rd:
				     (WRSel == 2'b10)? 31:
				      0;
						
endmodule



module MUX2(
	input [31:0] RD2,//GRF
	input [31:0] EXT,//EXT
	input BSel,//ctrl
	output [31:0] ari2
	);
	
assign ari2 = (BSel == 0)? RD2 : EXT;

endmodule



module MUX3(
	input [31:0] OUT,//ALU
	input [31:0] Memoryout,//DM
	input [31:0] PC,//PC
	input [1:0] WDSel,//ctrl
	output [31:0] WD
	);
	
assign WD = (WDSel == 2'b00)? OUT:
			   (WDSel == 2'b01)? Memoryout:
				(WDSel == 2'b10)? PC + 4:
				0;
				
endmodule
