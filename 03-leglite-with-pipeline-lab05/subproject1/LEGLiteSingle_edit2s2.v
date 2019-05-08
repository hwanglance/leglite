// EE 361
// LEGLite Single Cycle
// 
// Obviously, it's incomplete.  Just the ports are defined.
//

module LEGLiteSingle(
	iaddr,		// Program memory address.  This is the program counter
	daddr,		// Data memory address
        dwdata,        // Data memory write output
	dwrite,		// Data memory write enable
	dread,		// Data memory read enable
	alu_out,	// Output of alu for debugging purposes
	clock,
	idata,		// Program memory output, which is the current instruction
	ddata,		// Data memory output
	reset
	);

output [15:0] iaddr;
output [15:0] daddr;	
output [15:0] dwdata;
output dwrite;
output dread;
output [15:0] alu_out;
input clock;
input [15:0] idata; // Instructions 
input [15:0] ddata;	
input reset;

wire [15:0] muxAout, muxBout, muxCout;

wire alu_zeroA;

wire reg2loc;
wire branch;
wire memread;
wire memtoreg;
wire [2:0] alu_select;
wire memwrite;
wire alusrc;
wire regwrite;

wire [15:0] rdata1;

// wire [15:0] signextA;
// assign signextA = {{9{idata[12]}}, idata[12:6]};

assign daddr = alu_out;

PCLogic PCLogicA(
    iaddr,
    clock,
    {{9{idata[12]}}, idata[12:6]},
    branch,
    alu_zeroA,
    reset
    );

MUX2 MUX2A(
    muxAout,
    {13'b0, idata[12:10]},
    {13'b0, idata[2:0]},
    reg2loc
    );

MUX2 MUX2B(
    muxBout,
    dwdata,
    {{9{idata[12]}}, idata[12:6]},
    alusrc
    );

MUX2 MUX2C(
    muxCout,
    alu_out,
    ddata,
    memtoreg
    );

RegFile RegFileA(
    rdata1,
    dwdata,
    clock,
    muxCout,
    idata[2:0],
    idata[5:3],
    muxAout[2:0],
    regwrite
    );

Control ControlA(
    reg2loc,
    branch,
    dread,
    memtoreg,
    alu_select,
    dwrite,
    alusrc,
    regwrite,
    idata[15:13]
    );

ALU ALUA(
    alu_out,
    alu_zeroA,
    rdata1,
    muxBout,
    alu_select
    );

	
	
endmodule

