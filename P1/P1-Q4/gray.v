`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:58 10/05/2022 
// Design Name: 
// Module Name:    gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output Overflow
    );

reg [2:0] net;
initial begin
	net = 3'b000;
end

reg over;
initial begin
	over = 0;
end

assign Output = net;

assign Overflow = over;

always @(posedge Clk)
begin
	if(Reset)  begin
		net <= 3'b000;
		over <= 0;
	end
	else if(En)  begin
		if(net == 3'b000) begin
			net <= 3'b001;
		end 
		else if(net == 3'b001) begin
			net <= 3'b011;
		end 
		else if(net == 3'b011) begin
			net <= 3'b010;
		end
		else if(net == 3'b010) begin
			net <= 3'b110;
		end
		else if(net == 3'b110) begin
			net <= 3'b111;
		end
		else if(net == 3'b111) begin
			net <= 3'b101;
		end
		else if(net == 3'b101) begin
			net <= 3'b100;
		end
		else if(net == 3'b100) begin
			net <= 3'b000;
			over <= 1;
		end
		else begin
			net <= net;
		end
	end
		
end
	
endmodule
