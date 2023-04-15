`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:50:51 10/06/2022
// Design Name:   BlockChecker
// Module Name:   /media/shared/sharing files/P1-BlockChecker/block.v
// Project Name:  P1-BlockChecker
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BlockChecker
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module block;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] in;

	// Outputs
	wire result;

	// Instantiate the Unit Under Test (UUT)
	BlockChecker uut (
		.clk(clk), 
		.reset(reset), 
		.in(in), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		in = "a";
		#100;
		
		in = " ";
		#100;
		
		in = "B";
		#100;
		
		in = "E";
		#100;
		
		in = "g";
		#100;
		
		in = "I";
		#100;
		
		in = "n";
		#100;
		
		in = " ";
		#100;
		
		in = "E";
		#100;
		
		in = "n";
		#100;
		
		in = "d";
		#100;
		
		in = " ";
		#100;
		
		in = " ";
		#100;
		
		in = "e";
		#100;
		
		in = "n";
		#100;
		
		in = "d";
		#100;
		
		in = "d";
		#100;
		
		in = "e";
		#100;
		
		in = "n";
		#100;
		
		in = "d";
		#100;
		
		in = " ";
		#100;
		
		in = "b";
		#100;
		
		in = "E";
		#100;
		
		in = "G";
		#100;
		
		in = "i";
		#100;
		
		in = "n";
		#100;
		
		 in = "e";
		#100;
		
		in = "n";
		#100;
		
		in = "d";
		#100;
		
		in = " ";
		#100;
	end
  
 always #50 clk = ~clk;
  
endmodule

