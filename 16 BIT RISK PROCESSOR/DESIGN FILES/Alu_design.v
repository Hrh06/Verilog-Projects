//////////////////////////////////////////////////////////////////////////////////
// Created by: Haneen Haris Kormath 
// 
// Create Date: 20.11.2024 10:28:33
// Design Name: Processor Design
// Module Name: Alu_design
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
module alu(
	//inputs
	input 			I_CLK,
	input 			I_EN,
	input [4:0] 	I_ALUOP,
	input [15:0] 	I_DATAA,
	input [15:0] 	I_DATAB,
	input [7:0] 	I_IMME,
	
	//Outputs
	output [15:0] 	O_DATARESULT,
	output reg 		O_JMPBRANCH
);

	//Reg declaration
	reg [17:0] int_result;
	wire op_lsb;
	wire [3:0] opcode;
	
	//Parameter declaration
	localparam	ADD		= 0,
				SUB		= 1,
				OR		= 2,
				AND		= 3,
				XOR		= 4,
				NOT		= 5,
				LOAD	= 8,
				CMP		= 9,
				SHL		= 10,
				SHR		= 11,
				JMPA	= 12,
				JMPR	= 13;
	
	//Initial block
	initial begin
		int_result <= 0;
	end
	
	//Assigning values
	assign op_lsb = I_ALUOP[0];
	assign opcode = I_ALUOP[4:1] ;
	assign O_DATARESULT = int_result[15:0] ;
	
	//ALU operations
	always@(negedge I_CLK) begin
		
		if(I_EN) begin
			case(opcode)
				
				ADD : begin
					int_result <= (op_lsb ? ($signed(I_DATAA) + $signed(I_DATAB)) : (I_DATAA + I_DATAB) );
				end
				
				SUB : begin
					int_result <= (op_lsb ? ($signed(I_DATAA) - $signed(I_DATAB)) : (I_DATAA - I_DATAB) );
				end
				
				OR : begin
					int_result <= I_DATAA | I_DATAB;
				end
				
				AND : begin
					int_result <= I_DATAA & I_DATAB;
					O_JMPBRANCH <= 0;
				end
				
				XOR : begin
					int_result <= I_DATAA ^ I_DATAB;
					O_JMPBRANCH <= 0;
				end
				
				NOT : begin
					int_result <= ~I_DATAA;
					O_JMPBRANCH <= 0;
				end
				
				LOAD : begin
					int_result <= op_lsb ? ({I_IMME, 8'h00}) : ({8'h00, I_IMME}) ;
					O_JMPBRANCH <= 0;
				end
				
				CMP : begin
					if(op_lsb) begin
						int_result[0] <= ($signed(I_DATAA) == $signed(I_DATAB)) ? 1 : 0;
						int_result[1] <= ($signed(I_DATAA) == 0) ? 1 : 0;
						int_result[2] <= ($signed(I_DATAB) == 0) ? 1 : 0;
						int_result[3] <= ($signed(I_DATAA) > $signed(I_DATAB)) ? 1 : 0;
						int_result[4] <= ($signed(I_DATAA) < $signed(I_DATAB)) ? 1 : 0;
					end
					else begin
						int_result[0] <= (I_DATAA == I_DATAB) ? 1 : 0;
						int_result[1] <= (I_DATAA == 0) ? 1 : 0;
						int_result[2] <= (I_DATAB == 0) ? 1 : 0;
						int_result[3] <= (I_DATAA >  I_DATAB) ? 1 : 0;
						int_result[4] <= (I_DATAA <  I_DATAB) ? 1 : 0;
					end
					O_JMPBRANCH <= 0;
				end
				
				SHL : begin
					int_result <= I_DATAA << (I_DATAB[3:0]);
					O_JMPBRANCH <= 0;
				end
				
				SHR : begin
					int_result <= I_DATAA >> (I_DATAB[3:0]);
					O_JMPBRANCH <= 0;
				end
				
				JMPA : begin
					int_result <= (op_lsb ? I_DATAA : I_IMME);
					O_JMPBRANCH <= 1;
				end
				
				JMPR :begin
					int_result <= I_DATAA;
					O_JMPBRANCH <= I_DATAB[{op_lsb , I_IMME[1:0]}];
				end
			endcase	
	   end
	
	end
		
endmodule