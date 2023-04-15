`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:35 11/11/2022 
// Design Name: 
// Module Name:    HAZARD 
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
module HAZARD(
    input [2:0] Tuse_rs,
    input [2:0] Tuse_rt,
    input [2:0] Tnew_E,
    input [2:0] Tnew_M,
	 input Tnew_W,
	 input [4:0] rs_D,
	 input [4:0] rt_D,
	 input [4:0] rs_E,
	 input [4:0] rt_E,
	 input [4:0] rt_M,
	 input [4:0] RegWrite_E,
	 input RFWr_E,
	 input [4:0] RegWrite_M,
	 input RFWr_M,
	 input [4:0] RegWrite_W,
	 input RFWr_W,
	 input [1:0] RSel_D,
	 input [1:0] RSel_E,
	 input [1:0] RSel_M,
	 input BUSY,
	 //input BR,
	 //input load,
    output stall,
    output [2:0] FSel1_D,
    output [2:0] FSel2_D,
    output [2:0] FSel1_E,
    output [2:0] FSel2_E,
    output FSel1_M
    );

wire stall_rs0_E2, stall_rs0_E1, stall_rs0_M1, stall_rs1_E2;
wire stall_rt0_E2, stall_rt0_E1, stall_rt0_M1, stall_rt1_E2;
wire stall_rs, stall_rt;

assign stall_rs0_E2 = (Tuse_rs == 3'b000) & (Tnew_E == 3'b010) & (rs_D == RegWrite_E) & (rs_D != 5'b0) & RFWr_E;
assign stall_rs0_E1 = (Tuse_rs == 3'b000) & (Tnew_E == 3'b001) & (rs_D == RegWrite_E) & (rs_D != 5'b0) & RFWr_E;
assign stall_rs0_M1 = (Tuse_rs == 3'b000) & (Tnew_M == 3'b001) & (rs_D == RegWrite_M) & (rs_D != 5'b0) & RFWr_M;
assign stall_rs1_E2 = (Tuse_rs == 3'b001) & (Tnew_E == 3'b010) & (rs_D == RegWrite_E) & (rs_D != 5'b0) & RFWr_E;
assign stall_rs = stall_rs0_E2 | stall_rs0_E1 | stall_rs0_M1 | stall_rs1_E2;

assign stall_rt0_E2 = (Tuse_rt == 3'b000) & (Tnew_E == 3'b010) & (rt_D == RegWrite_E) & (rt_D != 5'b0) & RFWr_E;
assign stall_rt0_E1 = (Tuse_rt == 3'b000) & (Tnew_E == 3'b001) & (rt_D == RegWrite_E) & (rt_D != 5'b0) & RFWr_E;
assign stall_rt0_M1 = (Tuse_rt == 3'b000) & (Tnew_M == 3'b001) & (rt_D == RegWrite_M) & (rt_D != 5'b0) & RFWr_M;
assign stall_rt1_E2 = (Tuse_rt == 3'b001) & (Tnew_E == 3'b010) & (rt_D == RegWrite_E) & (rt_D != 5'b0) & RFWr_E;
assign stall_rt = stall_rt0_E2 | stall_rt0_E1 | stall_rt0_M1 | stall_rt1_E2;

//wire branchstall;
//assign branchstall = (((rs_D == RegWrite_E) || (rt_D == RegWrite_E)) && RSel_E == 2'b00 && BR && RFWr_E) ||
//							(((rs_D == RegWrite_M) || (rt_D == RegWrite_M)) && RSel_M == 2'b01 && BR && RFWr_M);

//wire lwstall;							
//assign lwstall = (((rs_D == RegWrite_E) || (rt_D == RegWrite_E)) && RSel_E == 2'b01 && RFWr_E) || 
//					  (((rs_E == RegWrite_M) || (rt_E == RegWrite_M)) && RSel_M == 2'b01 && RFWr_M);

//wire jrstall;
//assign jrstall = ((rs_D == RegWrite_E) && RFWr_E && RSel_E == 2'b00 && RSel_D == 2'b10) || ((rs_D == RegWrite_M) && RFWr_M && RSel_M == 2'b01 && RSel_D == 2'b10);

assign stall = stall_rs | stall_rt ;

assign FSel1_D = (rs_D == RegWrite_E && rs_D != 5'b0 && RSel_E == 2'b10 && RFWr_E == 1) ? 3'b000 ://PC4_E
					  (rs_D == RegWrite_M && rs_D != 5'b0 && RSel_M == 2'b10 && RFWr_M == 1) ? 3'b001 ://PC4_M
					  (rs_D == RegWrite_M && rs_D != 5'b0 && RSel_M == 2'b00 && RFWr_M == 1) ? 3'b010 ://ALUOUT_M
					  (rs_D == RegWrite_M && rs_D != 5'b0 && RSel_M == 2'b11 && RFWr_M == 1) ? 3'b011 ://MDdata_M
					  (rs_D == RegWrite_W && rs_D != 5'b0 && RFWr_W == 1) ? 3'b100 ://Result_W
					  3'b101;//RD1_D
					
assign FSel2_D = (rt_D == RegWrite_E && rt_D != 5'b0 && RSel_E == 2'b10 && RFWr_E == 1) ? 3'b000 ://PC4_E
					  (rt_D == RegWrite_M && rt_D != 5'b0 && RSel_M == 2'b10 && RFWr_M == 1) ? 3'b001 ://PC4_M
					  (rt_D == RegWrite_M && rt_D != 5'b0 && RSel_M == 2'b00 && RFWr_M == 1) ? 3'b010 ://ALUOUT_M
					  (rt_D == RegWrite_M && rt_D != 5'b0 && RSel_M == 2'b11 && RFWr_M == 1) ? 3'b011 ://MDdata_M
					  (rt_D == RegWrite_W && rt_D != 5'b0 && RFWr_W == 1) ? 3'b100 ://Result_W
					  3'b101;//RD2_D
		
assign FSel1_E = (rs_E == RegWrite_M && rs_E != 5'b0 && RSel_M == 2'b10 && RFWr_M == 1) ? 3'b000 ://PC4_M
					  (rs_E == RegWrite_M && rs_E != 5'b0 && RSel_M == 2'b00 && RFWr_M == 1) ? 3'b001 ://ALUOUT_M
					  (rs_E == RegWrite_M && rs_E != 5'b0 && RSel_M == 2'b11 && RFWr_M == 1) ? 3'b010 ://MDdata_M
					  (rs_E == RegWrite_W && rs_E != 5'b0 && RFWr_W == 1) ? 3'b011 ://Result_W
					  3'b100;//A1_E
					  
assign FSel2_E = (rt_E == RegWrite_M && rt_E != 5'b0 && RSel_M == 2'b10 && RFWr_M == 1) ? 3'b000 ://PC4_M
					  (rt_E == RegWrite_M && rt_E != 5'b0 && RSel_M == 2'b00 && RFWr_M == 1) ? 3'b001 ://ALUOUT_M
					  (rt_E == RegWrite_M && rt_E != 5'b0 && RSel_M == 2'b11 && RFWr_M == 1) ? 3'b010 ://MDdata_M
					  (rt_E == RegWrite_W && rt_E != 5'b0 && RFWr_W == 1) ? 3'b011 ://Result_W
					  3'b100;//A2_E0
					  
assign FSel1_M = (rt_M == RegWrite_W && rt_M != 5'b0 && RFWr_W == 1) ? 0 : 1;//Result_W, A2_M

endmodule
