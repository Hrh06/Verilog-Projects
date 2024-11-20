//////////////////////////////////////////////////////////////////////////////////
// Created by: Haneen Haris Kormath 
// 
// Create Date: 20.11.2024 10:28:33
// Design Name: Test Bench
// Module Name: Main_testbench
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
module main_test();
	//variable declaration
	//regs
	reg clk;
	reg reset;
	reg RAM_WE = 0;
	reg [15:0] DATAI = 0;
	//wires
	wire [2:0] SELA;
	wire [2:0] SELB;
	wire [2:0] SELD;
	wire [15:0] DATAA;
	wire [15:0] DATAB;
	wire [15:0] DATAD;
	wire [4:0] ALUOP;
	wire [7:0] IMME;
	wire [15:0] DATAO;
	wire [1:0] OPCODE;
	wire [15:0] PCO;
	wire 	JMPBRANCH;
	wire	ENFETCH;
	wire	ENDECO;
	wire	ENRGRD;
	wire	ENALU;
	wire	ENRGWR;
	wire	ENMEM;
	wire    UPDATE;
	wire	REGWE;
	//wire    DATARESULT;
	
	//assignments
	assign  ENRGWR = REGWE & UPDATE;
	assign	OPCODE = (reset) ? 2'b11 : ((JMPBRANCH) ? 2'b10 : ((ENMEM) ? 2'b01 : 2'b00));
	
	
	//instantiations
	reg_file main_reg(
		//inputs
		clk,
		ENRGRD,
		ENRGWR,
		SELA,
		SELB,
		SELD,
		DATAD,
		//outputs
		DATAA,
		DATAB
	);
	inst_deco main_inst(
		//INPUTS
		clk	,
		ENDECO	,
		DATAO	,
		//OUTPUTS
		ALUOP	,
		SELA	,
		SELB	,
		SELD	,
		IMME	,
		REGWE	
	);
	
	alu main_alu(
	//inputs
		clk,
		ENALU,
		ALUOP,
		DATAA,
		DATAB,
		IMME,
	//Outputs
		DATAD,
		JMPBRANCH
	);
	
	control_unit main_ctrl(
	//inputs
		clk,
		reset,
	
	//outputs
		ENFETCH,
		ENDECO,
		ENRGRD,
		ENALU,
		UPDATE,
		ENMEM
	);
	
	pc_unit main_pc(
	//inputs
		clk,
		OPCODE,
		DATAD,
	//outputs
		PCO
	);
	
	fake_ram main_fakeram(
	//inputs
		clk,
		RAM_WE,
		PCO,
		DATAI,
	//outputs
		DATAO
	);
	
	initial begin
	
	clk = 0;
	reset = 1;
	#20
	reset = 0;
	end
	
	//clock generation
	always begin
		#5;
		clk = ~clk;
	end


endmodule