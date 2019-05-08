// EE 361L
// testbench for FPGA device
// 
module testbench;


reg io_sw0;
reg io_sw1;
wire [6:0] io_display;

reg  clock;
reg  reset;		// Reset

// Clock
initial clock=0;
always #1 clock=~clock;


initial 
	begin
	$display("\nIO[display,switch0,switch1] Signals[clock,reset,time]");
	reset=1;
	io_sw0=1;
	io_sw1=0;
	#2
	reset=0;
	#100
	io_sw0=0;
	io_sw1=0;
	#200
	$finish;
	end


initial
	begin

	$monitor("IO[%b,%b,%b] Signals[%b,%b,%0d]",
		io_display,
		io_sw0,
		io_sw1,
		clock,
		reset,
		$time
		);
	end
//

FPGADevice fpgadev1(io_display, clock, io_sw1,io_sw0,reset);


endmodule