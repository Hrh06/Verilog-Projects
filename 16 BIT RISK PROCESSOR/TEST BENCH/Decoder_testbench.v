//////////////////////////////////////////////////////////////////////////////////
// Created by: Haneen Haris Kormath 
// 
// Create Date: 20.11.2024 10:28:33
// Design Name: Test Bench
// Module Name: decoder_testbench
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
module decoder_unittest();
	//variable declerations
	//reg
	reg I_CLK	;
	reg I_EN	;
	reg [15:0] I_INST	;
	//wires
	wire [4:0] O_ALUOP;
	wire [3:0] O_SELA;
	wire [3:0] O_SELB;
	wire [3:0] O_SELD;
	wire [15:0] O_IMME;
	wire O_REGWE;

inst_deco inst_unit(
	//INPUTS
	I_CLK	,
	I_EN	,
	I_INST	,
	//OUTPUTS
	O_ALUOP	,
 	O_SELA	,
	O_SELB	,
 	O_SELD	,
 	O_IMME	,
	O_REGWE
);

	initial begin
		//time equal to 0
		I_CLK	= 0;
		I_EN	= 0;
		I_INST	= 0;
		//time = 10
		#10;
		I_INST = 16'b1100011100000111;
		//time = 20
		#10;
		I_EN = 1;
		//time = 70
		#50;
		I_INST = 16'b0001100010010001;
	end
	
	always begin
		#5;
		I_CLK = ~I_CLK;
	end
		

endmodule