// EE 361L
// Subproject 3 FPGA Device
//  
// 
module FPGADevice(seg, clk, sw, btnC);


output [6:0] seg;
input clk;
input [1:0] sw;
input btnC; // reset

wire [15:0] imemaddr; 	// Instruction memory addr
wire [15:0] dmemaddr;	// Data memory addr
wire [15:0] dmemwdata;	// Data memory write-data
wire dmemwrite;	// Data memory write enable
wire dmemread;	// Data memory read enable
wire [15:0] aluresult;	// Output from the ALU:  for debugging
wire [15:0] aluout;		// Output from the ALUOut register:  for debugging

wire [15:0] imemrdata;	// Instruction memory read data
wire [15:0] dmemrdata;	


LEGLiteP0 comp(
	imemaddr, 	// Instruction memory addr
	dmemaddr,	// Data memory addr
	dmemwdata,	// Data memory write-data
	dmemwrite,	// Data memory write enable
	dmemread,	// Data memory read enable
	aluresult,	// Output from the ALU:  for debugging
	clk,
	imemrdata,	// Instruction memory read data
	dmemrdata,	// Data memory read data
	btnC		// Reset
	);

// Instantiation of Instruction Memory (program)

IM  instrmem(imemrdata,imemaddr);

// Instantiation of Data Memory

DMemory_IO datamemdevice(
		dmemrdata,	// read data
		seg,	// IO port connected to 7 segment display
		clk,		// clock
		dmemaddr,	// address
		dmemwdata,	// write data
		dmemwrite,	// write enable
		dmemread,	// read enable
		sw[0],		// IO port connected to sliding switch 0
		sw[1]		// IO port connected to sliding switch 1
		);



endmodule