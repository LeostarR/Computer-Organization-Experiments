`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:50:41 10/05/2022 
// Design Name: 
// Module Name:    string 
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
module string(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );

reg ot = 0;
assign out = ot;

wire [1:0] symbol;
assign symbol = (in == "+")? 2'b01://+
					 (in == "*")? 2'b10://*
					 (in >= "0" && in <= "9")? 2'b11:
					 2'b00;

integer state = 0;

always @(posedge clk or posedge clr)
begin
	if(clr) begin
		state <= 0;
		ot <= 0;
	end
	else begin
		case(state)
		0:
			begin
				state <= (symbol == 2'b11)? 1 : 3;
				ot <= (symbol == 2'b11)? 1 : 0;
			end
		1:
			begin
				state <= (symbol == 2'b01 || symbol == 2'b10)? 2 : 3;
				ot <= 0;
			end
		2:
			begin
				state <= (symbol == 2'b11)? 1 : 3;
				ot <= (symbol == 2'b11)? 1 : 0;
			end 
		3:
			begin
				state <= 3;
				ot <= 0;
			end
		default:
			begin
				state <= state;
				ot <= ot;
			end
		endcase
	end
end

endmodule
