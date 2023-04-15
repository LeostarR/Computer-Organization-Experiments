`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:43 10/06/2022 
// Design Name: 
// Module Name:    BlockChecker 
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
module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );


reg beginc, endc, gre;

initial 
begin
	beginc = 0;
	endc = 0;
	gre = 0;
end

assign result = (beginc == 0 && endc == 0)? 1 : 0;

wire sym;
assign sym = ((in >= "a" && in <= "z" && in != "e" && in != "b") || (in >= "A" && in <= "Z" && in != "E" && in != "B"))? 1 : 0;

integer state = 0;
always @(posedge clk or posedge reset)
begin  
	if(reset)begin
		state <= 0;
		beginc <= 0;
		endc <= 0;
		gre <= 0;
	end
	else begin
		case(state)
		0:begin
			if(in == "b" || in == "B")begin
				state <= 10;
			end
			else if(in == "e"|| in == "E")begin
				state <= 20;
			end
			else if(in == " ")begin
				state <= 0;
			end
			else begin
				state <= 1;
			end
		end
		1:begin
			if(in == " ")begin
				state <= 0;
			end
			else begin
				state <= 1;
			end
		end
			10:begin 
				if(in == "e" || in == "E")begin
					state <= 11;
				end
				else if(in == " ")begin
					state <= 0;
				end
				else begin
					state <= 1;
				end
			end
			11:begin
				if(in == "g" || in == "G")begin
					state <= 12;
				end
				else if(in == " ")begin
					state <= 0;
				end
				else begin
					state <= 1;
				end
			end
			12:begin
				if(in == "i" || in == "I")begin
					state <= 13;
				end
				else if(in == " ")begin
					state <= 0;
				end
				else begin
					state <= 1;
				end
			end
			13:begin
				if(in == "n" || in == "N")begin
					state <= 14;
					beginc <= beginc + 1;
				end
				else if(in == " ")begin
					state <= 0;
				end
				else begin
					state <= 1;
				end
			end
			14:begin
				if(in == " ")begin
					state <= 0;
				end
				else begin
					state <= 1;
					beginc <= beginc - 1;
				end
			end
			20:begin
				if(in == "n" || in == "N")begin
					state <= 21;
				end
				else if(in == " ")begin
					state <= 0;
				end
				else begin
					state <= 1;
				end
			end
			21:begin
				if(in == "d" || in == "D")begin
					state <= 22;
					if(beginc > 0)begin
						gre <= 1;
						beginc <= beginc - 1;
					end
					else if(beginc == 0) begin
						endc <= endc + 1;
					end
				end
				else if(in == " ")begin
					state <= 0;
				end
				else begin
					state <= 1;
				end
			end
			22:begin
				if(in == " ")begin
					state <= 0;
					gre <= 0;
				end
				else begin
					state <= 1;
					if(gre == 1)begin
						gre <= 0;
						beginc <= beginc + 1;
					end
					else begin
						endc <= endc - 1;
					end
				end
			
			end
			default:
			begin
				state <= 0;
			end
			endcase
		end
		

end

endmodule
