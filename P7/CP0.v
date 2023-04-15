`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:22:20 12/09/2022 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
    input clk,
    input reset,
    input en,
    input [4:0] CP0Add,
    input [31:0] CP0In,
    output [31:0] CP0Out,
    input [31:0] VPC,
    input BDIn,
    input [4:0] ExcCodeIn,
    input [5:0] HWInt,
    input EXLClr,
    output [31:0] EPCOut,
    output Req
    );


//SR
wire [31:0] SR;
reg [15:10] IM;
reg EXL;
reg IE;

//Cause
wire [31:0] Cause;
reg BD;
reg [15:10] IP;
reg [6:2] ExcCode;

//EPC
reg [31:0] EPC;

initial begin
		//EPC
		EPC <= 0;
		//Cause
		BD <= 0;
		IP <= 0;
		ExcCode <= 0;
		//SR
		IM <= 0;
		EXL <= 0;
		IE <= 0;
end

wire Int;
assign Int = IE & !EXL & (|(HWInt & IM));
wire Exc;
assign Exc = !EXL & (|ExcCodeIn);
assign Req = Int | Exc;

wire [31:0] temp;
assign temp = (Req == 1) ? ((BDIn == 1) ? (VPC - 4) : VPC) : EPC;

always @(posedge clk)begin
	if(reset)begin
		//EPC
		EPC <= 0;
		//Cause
		BD <= 0;
		IP <= 0;
		ExcCode <= 0;
		//SR
		IM <= 0;
		EXL <= 0;
		IE <= 0;
	end
	else begin
		IP <= HWInt;
		if(EXLClr == 1)begin
			EXL <= 0;
		end
		
		if(en & !Req)begin
			if(CP0Add == 12)begin
				{IM, EXL, IE} <= {CP0In[15:10], CP0In[1], CP0In[0]}; 
			end
			else if(CP0Add == 14)begin
				EPC <= CP0In;
			end
		end
		else if(Req)begin
			EXL <= 1;
			EPC <= temp;
			BD <= BDIn;
			ExcCode <= (Int == 1) ? 5'b0 : ExcCodeIn ;
		end
	end
end

assign SR = {16'b0, IM, 8'b0, EXL, IE};
assign Cause = {BD, 15'b0, IP, 3'b0, ExcCode, 2'b0};
assign EPCOut = temp;

assign CP0Out = (CP0Add == 12) ? SR :
					 (CP0Add == 13) ? Cause :
					 (CP0Add == 14) ? EPCOut :
					 0;
endmodule
