`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:48 11/23/2022 
// Design Name: 
// Module Name:    M_DataExt 
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
module M_DataExt(
    input [31:0] INSTR_M,
    input [31:0] WD_M,
    input [31:0] ALUOUT_M,
    input [31:0] PC4_M,
	 input [31:0] m_data_rdata,
    output [31:0] DMOUT_M,
	 output [3:0] m_data_byteen,
	 output [31:0] m_data_wdata,
	 output [31:0] m_data_addr,
	 output [31:0] m_inst_addr,
	 input overflow_M,
	 output Adel_M,
	 output Ades_M
    );

reg [31:0] Wdata;	 

assign m_data_addr = ALUOUT_M;
assign m_inst_addr = PC4_M - 4;

wire [1:0] by;
assign by = ALUOUT_M[1:0];

wire [5:0] opcode;
wire lw, lh, lb, sw, sh, sb;
assign opcode = INSTR_M[31:26];

assign lw = (opcode == 6'b100011)? 1 : 0;
assign lh = (opcode == 6'b100001)? 1 : 0;
assign lb = (opcode == 6'b100000)? 1 : 0;
assign sw = (opcode == 6'b101011)? 1 : 0;
assign sh = (opcode == 6'b101001)? 1 : 0;
assign sb = (opcode == 6'b101000)? 1 : 0;

wire load = lw | lh | lb;
wire store = sw | sh | sb;

wire lwAddExc = lw & (ALUOUT_M[0] | ALUOUT_M[1] == 1);
wire lhAddExc = lh & (ALUOUT_M[0] == 1);
wire lhlbTimer = (lb | lh) & (ALUOUT_M >= 32'h0000_7f00); /*&& ALUOUT_M <= 32'h0000_7f0b) ||(ALUOUT_M >= 32'h0000_7f10 && ALUOUT_M <= 32'h0000_7f1b));*/
wire loadOv = load & overflow_M;
wire loadRangeOff = load & (!((ALUOUT_M >= 32'h0000_0000 && ALUOUT_M <= 32'h0000_2FFF) || (ALUOUT_M >= 32'h0000_7f00 && ALUOUT_M <= 32'h0000_7f0b) ||(ALUOUT_M >= 32'h0000_7f10 && ALUOUT_M <= 32'h0000_7f1b) || (ALUOUT_M > 32'h0000_7f20 && ALUOUT_M <= 32'h0000_7f23)));
assign Adel_M = lwAddExc | lhAddExc | lhlbTimer | loadOv | loadRangeOff;

wire swAddExc = sw & (ALUOUT_M[0] | ALUOUT_M[1] == 1);
wire shAddExc = sh & (ALUOUT_M[0] == 1);
wire shsbTimer = (sb | sh) & (ALUOUT_M >= 32'h0000_7f00);
wire storeOv = store & overflow_M;
wire storeRangeOff = store & (!((ALUOUT_M >= 32'h0000_0000 && ALUOUT_M <= 32'h0000_2FFF) || (ALUOUT_M >= 32'h0000_7f00 && ALUOUT_M <= 32'h0000_7f0b) ||(ALUOUT_M >= 32'h0000_7f10 && ALUOUT_M <= 32'h0000_7f1b) || (ALUOUT_M > 32'h0000_7f20 && ALUOUT_M <= 32'h0000_7f23)));
wire storeCouter = store & ((ALUOUT_M >= 32'h0000_7f08 && ALUOUT_M <= 32'h0000_7f0b) || (ALUOUT_M >= 32'h00007f18 && ALUOUT_M <= 32'h7f1b));
assign Ades_M = swAddExc | shAddExc | shsbTimer | storeOv | storeRangeOff | storeCouter;

reg [3:0] symbol;
always @(*)begin
	if(sw == 1)begin
		symbol = 4'b1111;
		Wdata = WD_M;
	end
	else if(sh == 1)begin
		if(by[1] == 1)begin
			symbol = 4'b1100;
			Wdata = WD_M << 16;
		end
		else begin
			symbol = 4'b0011;
			Wdata = WD_M;
		end
	end
	else if(sb == 1)begin
		if(by == 2'b00)begin
			symbol = 4'b0001;
			Wdata = WD_M;
		end
		else if(by == 2'b01)begin
			symbol = 4'b0010;
			Wdata = WD_M << 8;
		end
		else if(by == 2'b10)begin
			symbol = 4'b0100;
			Wdata = WD_M << 16;
		end
		else begin
			symbol = 4'b1000;
			Wdata = WD_M << 24;
		end
	end
	else begin
		symbol = 4'b0000;
	end
end
assign m_data_byteen = symbol;
assign m_data_wdata = Wdata;

reg [31:0] Dout;
always @(*)begin
	if(lw == 1)begin
		Dout = m_data_rdata;
	end
	else if(lh == 1)begin
		if(by[1] == 1)begin
			Dout = {{16{m_data_rdata[31]}},m_data_rdata[31:16]};
		end
		else begin
			Dout = {{16{m_data_rdata[15]}},m_data_rdata[15:0]};
		end
	end
	else if(lb == 1)begin
		if(by == 2'b00)begin
			Dout = {{24{m_data_rdata[7]}}, m_data_rdata[7:0]};
		end
		else if(by == 2'b01)begin
			Dout = {{24{m_data_rdata[15]}}, m_data_rdata[15:8]};
		end
		else if(by == 2'b10)begin
			Dout = {{24{m_data_rdata[23]}}, m_data_rdata[23:16]};
		end
		else begin
			Dout = {{24{m_data_rdata[31]}}, m_data_rdata[31:24]};
		end
	end
	else begin
		Dout = 0;
	end
end
assign DMOUT_M = Dout;

endmodule
