// EE 361L
// Subproject 3 FPGA Device
//  
// 
module FPGADevice(io_display, clock, io_sw1,io_sw0,reset);


output [6:0] io_display;
input clock;
input io_sw0;
input io_sw1;
input reset;

wire [15:0] imemaddr; 	// Instruction memory addr
wire [15:0] dmemaddr;	// Data memory addr
wire [15:0] dmemwdata;	// Data memory write-data
wire dmemwrite;	// Data memory write enable
wire dmemread;	// Data memory read enable
wire [15:0] aluresult;	// Output from the ALU:  for debugging
wire [15:0] aluout;		// Output from the ALUOut register:  for debugging

wire [16:0] imemrdata;	// Instruction memory read data
wire [15:0] dmemrdata;	

	
PMIPSL0 comp(
	imemaddr, 	// Instruction memory addr
	dmemaddr,	// Data memory addr
	dmemwdata,	// Data memory write-data
	dmemwrite,	// Data memory write enable
	dmemread,	// Data memory read enable
	aluresult,	// Output from the ALU:  for debugging
	clock,
	imemrdata,	// Instruction memory read data
	dmemrdata,	// Data memory read data
	reset		// Reset
	);

// Instantiation of Instruction Memory (program)

IM  instrmem(imemrdata,imemaddr);

// Instantiation of Data Memory

DMemory_IO datamemdevice(
		dmemrdata,	// read data
		io_display,	// IO port connected to 7 segment display
		clock,		// clock
		dmemaddr,	// address
		dmemwdata,	// write data
		dmemwrite,	// write enable
		dmemread,	// read enable
		io_sw0,		// IO port connected to sliding switch 0
		io_sw1		// IO port connected to sliding switch 1
		);



endmodule