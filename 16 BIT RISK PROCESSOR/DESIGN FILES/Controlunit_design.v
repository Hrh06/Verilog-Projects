//////////////////////////////////////////////////////////////////////////////////
// Created by: Haneen Haris Kormath 
// 
// Create Date: 20.11.2024 10:28:33
// Design Name: Processor Design
// Module Name: Controlunit_Design
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
module control_unit(
	//inputs
	input I_CLK,
	input I_RESET,
	
	//outputs
	output O_ENFETCH,
	output O_ENDECO,
	output O_ENRGRD,
	output O_ENALU,
	output O_ENRGWR,
	output O_ENMEM
	
);
	//register Declaration
		
	reg [5:0] state;
	
	//initial block
	initial begin
		state <= 6'b000001;
	end
	
	//state select block
	always@(posedge I_CLK) begin
		if(I_RESET)
			state <= 6'b000001;
		else begin
			case(state)
				6'b000001 : state <= 6'b000010;
				6'b000010 : state <= 6'b000100;
				6'b000100 : state <= 6'b001000;
				6'b001000 : state <= 6'b010000;
				6'b010000 : state <= 6'b100000;
				default : state <= 6'b000001;
			endcase
		end
	end
	
	//Assignment enable block
	assign O_ENFETCH	= state[0];
	assign O_ENDECO		= state[1];
	assign O_ENRGRD		= state[2] | state[4];
	assign O_ENALU		= state[3];
	assign O_ENRGWR		= state[4];
	assign O_ENMEM		= state[5];
	
	
endmodule