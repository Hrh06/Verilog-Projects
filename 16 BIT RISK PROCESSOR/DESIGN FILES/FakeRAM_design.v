//////////////////////////////////////////////////////////////////////////////////
// Created by: Haneen Haris Kormath 
// 
// Create Date: 20.11.2024 10:28:33
// Design Name: Processor Design
// Module Name: FakeRAM_design
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
module fake_ram(
	//inputs
	input 			I_CLK,
	input 			I_WE,
	input [15:0]	I_ADDR,
	input [15:0]	I_DATA,
	//outputs
	output reg [15:0]	O_DATA
);
	//memory declaration
	reg [15:0] mem [8:0];
	
	//initial block
	initial begin
		mem[0] = 16'b1000000011111110;
		mem[1] = 16'b1000100111101101;
		mem[2] = 16'b0010001000100000;
		mem[3] = 16'b1000001100000001;
		mem[4] = 16'b1000010000000001;
		mem[5] = 16'b0000001101110000;
		mem[6] = 16'b1100000000000101;
		mem[7] = 0;
		mem[8] = 0;
		
		O_DATA = 16'b0000000000000000;
	end
	
	//RAM operations
	always@(negedge I_CLK) begin
		
		if(I_WE) begin
			mem[I_ADDR[15:0]] <= I_DATA;
		end
		O_DATA <= mem[I_ADDR[15:0]];
	
	end

endmodule