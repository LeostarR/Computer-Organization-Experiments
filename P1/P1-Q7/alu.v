`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:33 10/05/2022 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] C
    );

/*	 wire shift;
assign shift = $signed(A) >>> B;

assign C = (ALUOp == 0)? A + B:
			  (ALUOp == 1)? A - B:
			  (ALUOp == 2)? A & B:
			  (ALUOp == 3)? A | B:
			  (ALUOp == 4)? A >> B:
			  (ALUOp == 5)? $signed($signed(A) >>> B):
			  0;*/

always @(*)
begin
	case(ALUOp)
		0:	begin
			C = A + B;
		end
		1:begin
			C = A - B;
		end
		2: begin
			C = A & B;
		end 
		3: begin
			C = A | B;
		end 
		4: begin
			C = A >> B;
		end
		5 : begin
			C = $signed(A) >>> B;
		end
        6 : begin
            C = (A > B) ? 1 : 0;
        end
        7 : begin
            if($signed(A) > $signed(B))begin
				C = 1;
			end
			else begin
				C = 0;
			end
        end
		default:
		begin
		end
		endcase
end

endmodule
