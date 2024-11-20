//////////////////////////////////////////////////////////////////////////////////
// Created by: Haneen Haris Kormath 
// 
// Create Date: 20.11.2024 10:28:33
// Design Name: Processor Design
// Module Name: PCunit_design
// Project Name: 16 BIT RISC PROCESSOR Design
// Target Devices: 
// Tool Versions: 
// Description: Board used to design is Mimas_A7_Mini
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//timescale
`timescale 1ns / 1ps

//module definition
module pc_unit(
	//inputs
	input 			I_CLK,
	input 	[1:0] 	I_OPCODE,
	input 	[15:0] 	I_PC,
	//outputs
	output reg 	[15:0]	O_PC
);

	//INITIAL BLOCK
	initial begin
		O_PC <= 0;
	end
	
	//Operations
	always@(negedge I_CLK) begin
		case(I_OPCODE)
			2'b00 : O_PC <= O_PC;
			2'b01 : O_PC <= O_PC +1;
			2'b10 : O_PC <= I_PC;
			2'b11 : O_PC <= 0;
			
		endcase
	
	end
	
endmodule