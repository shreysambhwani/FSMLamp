`timescale 1ns / 1ps
/**
 *
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor,
 * RegFile and Memory elements together.
 *
 * This file will be used to generate the bitstream to upload to the FPGA.
 * We have provided a sibling file, Wrapper_tb.v so that you can test your processor's functionality.
 *
 * We will be using our own separate Wrapper_tb.v to test your code. You are allowed to make changes to the Wrapper files
 * for your own individual testing, but we expect your final processor.v and memory modules to work with the
 * provided Wrapper interface.
 *
 * Refer to Lab 5 documents for detailed instructions on how to interface
 * with the memory elements. Each imem and dmem modules will take 12-bit
 * addresses and will allow for storing of 32-bit values at each address.
 * Each memory module should receive a single clock. At which edges, is
 * purely a design choice (and thereby up to you).
 *
 * You must change line 36 to add the memory file of the test you created using the assembler
 * For example, you would add sample inside of the quotes on line 38 after assembling sample.s
 *
 **/

module Wrapper (clock, reset, button, reg3Val1, reg3Val2,regVal3,hasReachedEight,configData);
	input clock, reset,button,hasReachedEight;
	output reg3Val1, reg3Val2;
	output[7:0] regVal3,configData;

	wire rwe, mwe;
	wire[4:0] rd, rs1, rs2;
	wire[31:0] instAddr, instData,
		rData, regA, regB,
		memAddr, memDataIn, memDataOut;
    wire[3:0] cAddr;
	wire[7:0] cmemData;
	wire[31:0] out3;

    assign reg3Val1 = RegisterFile.out3[1];
    assign reg3Val2 = RegisterFile.out3[0];
    assign regVal3 = RegisterFile.out3[7:0];
    
    assign configData = cmemData;
    assign cAddr = regVal3[3:0];
    
	// ADD YOUR MEMORY FILE HERE
	localparam INSTR_FILE = "C:/Users/msj24/Desktop/instruction/finalProject";
	localparam INSTR_FILE1 = "C:/Users/msj24/Desktop/instruction/configMem";
    //C:/Users/msj24/Desktop/finalProject
	// Main Processing Unit
	processor CPU(.clock(clock), .reset(reset),

		// ROM
		.address_imem(instAddr), .q_imem(instData),


		// Regfile
		.ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2),
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB),

		// RAM
		.wren(mwe), .address_dmem(memAddr),
		.data(memDataIn), .q_dmem(memDataOut));

	// Instruction Memory (ROM)
	ROM #(.MEMFILE({INSTR_FILE, ".mem"}))
	InstMem(.clk(clock),
		.addr(instAddr[11:0]),
		.dataOut(instData));

	//ConfigMem
	ConfigMem #(.MEMFILE({INSTR_FILE1, ".mem"}))
	 configMem(.clk(clock),
		.addr1(cAddr[3:0]),
		.dataOut1(cmemData));

	// Register File
	regfile RegisterFile(.clock(clock),
		.ctrl_writeEnable(rwe), .ctrl_reset(reset),
		.ctrl_writeReg(rd),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2),
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB), .buttonPressed(button), .hasReached(hasReachedEight));

	// Processor Memory (RAM)
	RAM ProcMem(.clk(clock),
		.wEn(mwe),
		.addr(memAddr[11:0]),
		.dataIn(memDataIn),
		.dataOut(memDataOut));

endmodule
