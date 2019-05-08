// EE 361
// LEGLite
// 
// * PC and PC Control:  Program Counter and
//         the PC control logic

//--------------------------------------------------------------
// PC and PC Control
module PCLogic(
		pc,		// current pc value
		clock,	// clock input
		pctarget,	// From EXMEM pctarget
		branch,	// CBZ instruction
		alu_zero,	// zero from ALU, used in cond branch
		reset,		// reset input
		state     // Added input
		);


output [15:0] pc;
input clock;
input [15:0] pctarget;
input branch;
input alu_zero;
input reset;
input [1:0] state;

reg [15:0] pc; 
												    
// Program counter pc is updated
//   * if reset = 0 then pc = 0
//   * otherwise pc = pc +2
// What's missing is how pc is updated when a branch occurs

always @(posedge clock) // reset or state
	begin
	if (reset == 1) pc <= 0;
	else if (branch == 1 && alu_zero == 1 && state == 3) pc <= pctarget;
	else if (state == 0) pc <= pc + 2; // default
	else pc <= pc;
	end
		
endmodule
