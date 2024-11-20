//////////////////////////////////////////////////////////////////////////////////
// Created by: Haneen Haris Kormath 
// 
// Create Date: 20.11.2024 10:28:33
// Design Name: Test Bench
// Module Name: Regfile_testbench
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
module regfile_unittest();
	
	//variable declaration
	//regs
	reg I_CLK;
	reg I_EN;
	reg I_WE;
	reg [2:0] I_SELA;
	reg [2:0] I_SELB;
	reg [2:0] I_SELD;
	reg [15:0] I_DATAD;
	//wires
	wire [15:0] O_DATAA;
	wire [15:0] O_DATAB;
	
	reg_file reg_unit(
		//inputs
		I_CLK,
		I_EN,
		I_WE,
		I_SELA,
		I_SELB,
		I_SELD,
		I_DATAD,
		//outputs
		O_DATAA,
		O_DATAB
	);

	initial begin
	//reseting all inputs
		I_CLK = 1'b0;
		I_DATAD = 0;
		I_EN = 0;
		I_SELA = 0;
		I_SELB = 0;
		I_SELD = 0;
		I_WE = 0;
		
		//start test
		//time = 7
		#7
		I_EN = 1'b1;
		
		I_SELA = 3'b000;
		I_SELB = 3'b000;
		I_SELD = 3'b000;
		
		I_DATAD = 16'hFFFF;
		I_WE = 1'b1;
		
		//time = 17
		#10;
		I_WE = 1'b0;
		I_SELD = 3'b010;
		I_DATAD = 16'h2222;
		
		//time = 27
		#10;
		I_WE = 1;
		
		//time = 37
		#10;
		I_DATAD = 16'h3333;
		
		//time = 47
		#10;
		I_WE = 0;
		I_SELD = 3'b001;
		I_DATAD = 16'hFEED;
		
		//time = 57
		#10;
		I_SELD = 3'b100;
		I_DATAD = 16'h4444;
		
		//time = 67
		#10;
		I_WE = 1;
		
		//time = 117
		#50;
		I_SELA = 3'b010;
		I_SELB = 3'b100;
		
	end
	
	//clock generation
	always begin
		#5;
		I_CLK = ~I_CLK;
	end
	
endmodule