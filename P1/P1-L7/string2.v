`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:04 10/10/2022 
// Design Name: 
// Module Name:    string2 
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
module string2(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );

reg result;
assign out = (result == 1) ? 1 : 0;

integer state = 0;

always @(posedge clk or posedge clr)begin
	if(clr == 1) begin
		state <= 0;
		result <= 0;
	end
	else begin
		case(state)
		0:begin
			if(in >= "0" && in <= "9")begin
				state <= 1;
				result <= 1;
			end
			else if(in == "(")begin
				state <= 3;
				result <= 0;
			end
			else begin
				state <= 6;
				result <= 0;
			end
		end
		1:begin
			if(in == "+" || in == "*")begin
				state <= 2;
				result <= 0;
			end
			else begin
				state <= 6;
				result <= 0;
			end
		end
		2:begin
			if(in >= "0" && in <= "9")begin
				state <= 1;
				result <= 1;
			end
			else if(in == "(")begin
				state <= 3;
				result <= 0;
			end
			else begin
				state <= 6;
				result <= 0;
			end
		end
		3:begin
			if(in >= "0" && in <= "9")begin
				state <= 4;
				result <= 0;
			end
			else begin
				state <= 6;
				result <= 0;
			end
		end
		4:begin
			if(in == "+" || in == "*")begin
				state <=	5;
				result <= 0;
			end
			else if(in == ")")begin
				state <= 1;
				result <= 1;
			end
			else begin
				state <= 6;
				result <= 0;
			end
		end
		5:begin
			if(in >= "0" && in <= "9")begin
				state <= 4;
				result <= 0;
			end
			else begin
				state <= 6;
				result <= 0;
			end
		end
		6:begin
			state <= 6;
			result <= 0;
		end
		default:begin
		end
		endcase
	end
end

endmodule
