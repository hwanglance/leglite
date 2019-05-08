

// LEGLiteP0
//
// This is empty, so you have to fill it up with parts
// and the controller such as
// * registers between pipeline stages, e.g., IF/ID register
// * ALU
// * multiplexers
// * register file
// * Instruction memory
// * controller
//
// Note that you can get most of these parts from Parts.V
// Remember that RegFile is synchronized with negative clock
//    edge, e.g., always @(negedge clock)
//
// In the code below, comments show where to put each stage
//    and the registers between stages.


module LEGLiteP0(
	imemaddr, 	// Instruction memory addr
	dmemaddr,	// Data memory addr
	dmemwdata,	// Data memory write-data
    dmemwrite,    // Data memory write enable
    dmemread,    // Data memory read enable
	aluresult,	// Output from the ALU:  for debugging
	clock,
	imemrdata,	// Instruction memory read data
	dmemrdata,	// Data memory read data
	reset		// Reset
	);

output [15:0] imemaddr;
output [15:0] dmemaddr;
output [15:0] dmemwdata;
output dmemwrite;	
output dmemread;	
output [15:0] aluresult;	
input clock;
input [15:0] imemrdata;	
input [15:0] dmemrdata;
input reset; 

//------- IF/ID register ----------
reg [15:0] IFIDpc;
reg [15:0] IFIDinstr;
//------- ID stage ----------------
wire [15:0] muxAout;

wire [15:0] rrdata1;
wire [15:0] rrdata2;

wire reg2loc;
wire branch;
wire memread;
wire memtoreg;
wire [2:0] alu_select;
wire memwrite;
wire alusrc;
wire regwrite;
//------- ID/EX register ----------
reg IDEXregwrite;
reg IDEXmemtoreg;

reg IDEXbranch;
reg IDEXmemread;
reg IDEXmemwrite;

reg [2:0] IDEXaluselect;
reg IDEXalusrc;

reg [15:0] IDEXpc;
reg [15:0] IDEXrrdata1;
reg [15:0] IDEXrrdata2;
reg [15:0] IDEXsignext;
reg [2:0] IDEXrwaddr;
//------- EX stage ----------------
wire [15:0] pctarget;
wire [15:0] muxBout;
wire aluzero;
//------- EX/MEM register ----------
reg EXMEMregwrite;
reg EXMEMmemtoreg;

reg EXMEMbranch;
reg EXMEMmemread;
reg EXMEMmemwrite;

reg [15:0] EXMEMpctarget;
reg EXMEMaluzero;
reg [15:0] EXMEMaluresult;
reg [15:0] EXMEMrrdata2;
reg [2:0] EXMEMrwaddr;
//------- MEM/WB pipeline register ----
reg MEMWBregwrite;
reg MEMWBmemtoreg;

reg [15:0] MEMWBdrdata;
reg [15:0] MEMWBaluresult;
reg [2:0] MEMWBrwaddr;
//------- WB Stage ------------------
wire [15:0] muxCout;



//------- IF stage ----------------

reg [1:0] state;

always @(posedge clock)
    begin
    if (reset == 1)
        state <= 0;
    else if (state >= 3)
        state <= 0;
    else
        state <= state + 1;
    end

PCLogic PCLogicA(
	imemaddr,		// current pc value
	clock,	// clock input
	EXMEMpctarget,	// from sign extend circuit
	EXMEMbranch,	// CBZ instruction
	EXMEMaluzero,	// zero from ALU, used in cond branch
	reset,		// reset input
	state
    );

//------- IF/ID register ----------
// To implement this register, you must declare
// register variables, e.g.,
always @(posedge clock)
    begin
    IFIDpc <= imemaddr;
    IFIDinstr <= imemrdata;
    end

//------- ID stage ----------------

MUX2 MUX2A(
    muxAout,
    {13'b0, IFIDinstr[12:10]},
    {13'b0, IFIDinstr[2:0]},
    reg2loc
    );

RegFile RegFileA(
    rrdata1,
    rrdata2,
    clock,
    muxCout,
    MEMWBrwaddr,
    IFIDinstr[5:3],
    muxAout[2:0],
    MEMWBregwrite
    );

Control ControlA(
    reg2loc,
    branch,
    memread,   // From output CHANGED
    memtoreg,
    alu_select,
    memwrite,  // From output CHANGED
    alusrc,
    regwrite,
    IFIDinstr[15:13],
    state
    );

//------- ID/EX register ----------

always @(posedge clock)
    begin
    IDEXregwrite <= regwrite;
    IDEXmemtoreg <= memtoreg;
    
    IDEXbranch <= branch;
    IDEXmemread <= memread; // CHANGED
    IDEXmemwrite <= memwrite; // CHANGED
    
    IDEXaluselect <= alu_select;
    IDEXalusrc <= alusrc;
    
    IDEXpc <= IFIDpc;
    IDEXrrdata1 <= rrdata1;
    IDEXrrdata2 <= rrdata2;
    IDEXsignext <= {{9{IFIDinstr[12]}}, IFIDinstr[12:6]};
    IDEXrwaddr <= IFIDinstr[2:0];
    end

//------- EX stage ----------------

assign pctarget = (IDEXpc + (IDEXsignext << 1));

MUX2 MUX2B(
    muxBout,
    IDEXrrdata2,
    IDEXsignext,
    IDEXalusrc
    );

ALU ALUA(
    aluresult,  // From output
    aluzero,
    IDEXrrdata1,
    muxBout,
    IDEXaluselect
    );

//------- EX/MEM register ----------

always @(posedge clock)
    begin
    EXMEMregwrite <= IDEXregwrite;
    EXMEMmemtoreg <= IDEXmemtoreg;
    
    EXMEMbranch <= IDEXbranch;
    EXMEMmemread <= IDEXmemread;
    EXMEMmemwrite <= IDEXmemwrite;
    
    EXMEMpctarget <= pctarget;
    EXMEMaluzero <= aluzero;
    EXMEMaluresult <= aluresult;
    EXMEMrrdata2 <= IDEXrrdata2;
    EXMEMrwaddr <= IDEXrwaddr;
    end

//------- MEM Stage ----------------

assign dmemaddr = EXMEMaluresult;
assign dmemwdata = EXMEMrrdata2;
assign dmemwrite = EXMEMmemwrite;
assign dmemread = EXMEMmemread;


//------- MEM/WB pipeline register ----

always @(posedge clock)
    begin
    MEMWBregwrite <= EXMEMregwrite;
    MEMWBmemtoreg <= EXMEMmemtoreg;
    
    MEMWBdrdata <= dmemrdata;
    MEMWBaluresult <= EXMEMaluresult;
    MEMWBrwaddr <= EXMEMrwaddr;
    end

//------- WB Stage ------------------

MUX2 MUX2C(
    muxCout,
    MEMWBaluresult,
    MEMWBdrdata,
    MEMWBmemtoreg
    );

endmodule
