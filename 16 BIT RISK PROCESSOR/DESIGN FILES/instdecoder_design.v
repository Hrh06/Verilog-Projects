//////////////////////////////////////////////////////////////////////////////////
// Created by: Haneen Haris Kormath 
// 
// Create Date: 20.11.2024 10:28:33
// Design Name: Processor Design
// Module Name: Instdecoder_design
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
module inst_deco(
	//INPUTS
	input 			I_CLK	,
	input 			I_EN	,
	input [15:0] 	I_INST	,
	
	//OUTPUTS
	output reg [4:0]	O_ALUOP	,
	output reg [2:0] 	O_SELA	,
	output reg [2:0]	O_SELB	,
	output reg [2:0] 	O_SELD	,
	output reg [7:0] 	O_IMME	,
	output reg			O_REGWE	
);

	initial begin
		O_ALUOP	<= 0;
	 	O_SELA	<= 0;
		O_SELB	<= 0;
	 	O_SELD	<= 0;
	 	O_IMME	<= 0;
		O_REGWE <= 0;
	end
	
	//Instruction decoder block
	always@(negedge I_CLK) begin
		
		if(I_EN) begin
			O_ALUOP <= I_INST[15:11]	;	//Opcode
			O_SELA 	<= I_INST[10:8]		;	//reg A
			O_SELB 	<= I_INST[7:5]		;	//regB
			O_SELD 	<= I_INST[4:2]		;	//regD
			O_IMME 	<= I_INST[7:0]		;	//Immediate data
		
			//Register Write Enable
			case(I_INST[15:12])
				4'b0111: O_REGWE <= 0	;
				4'b1100: O_REGWE <= 0	;
				4'b1101: O_REGWE <= 0	;
				default: O_REGWE <= 1	;
			
			endcase
		end
		
	end
	
	

endmodule