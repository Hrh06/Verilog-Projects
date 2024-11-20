//////////////////////////////////////////////////////////////////////////////////
// Created by: Haneen Haris Kormath 
// 
// Create Date: 20.11.2024 10:28:33
// Design Name: Processor Design
// Module Name: Regfile_design
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
module reg_file(
	//inputs
	input I_CLK,
	input I_EN,
	input I_WE,
	input [2:0] I_SELA,
	input [2:0] I_SELB,
	input [2:0] I_SELD,
	input [15:0] I_DATAD,
	//outputs
	output reg [15:0] O_DATAA,
	output reg [15:0] O_DATAB
);
	//INTERNAL REGISTER DECLARATION
	reg [15:0] regs [7:0];
	
	//loop variable
	integer count;
	
	//initialise register
	initial begin
		O_DATAA <= 0;
		O_DATAB <= 0;
		
		for(count = 0; count < 8; count = count + 1) begin
			regs[count] = 0;
		end
	end
	
	//Assigning correct values to OP regs
	always@(negedge I_CLK) begin
	
		if(I_EN) begin
			if(I_WE)
				regs[I_SELD] <= I_DATAD;
				
			O_DATAA <= regs[I_SELA];
			O_DATAB <= regs[I_SELB];
		end
	end

endmodule