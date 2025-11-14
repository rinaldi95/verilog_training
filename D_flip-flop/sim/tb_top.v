`timescale 1ns/1ps
module tb_top;
	reg clock;
	reg reset;
	reg D;
	wire Q;
	wire Q_not;
	

	top dut(
		.clock(clock),
		.reset(reset),
		.D(D),
		.Q(Q),
		.Q_not(Q_not)
		);

		
	always #5 clock=~clock;

	initial begin
		clock =0;
		D=0;
		reset=1;
		#10 reset=0;
		#20 D=1;
		#40 D=0;
		#70 D=1;
		#20 $finish;
	end

	initial begin
		$dumpfile("build/waves.vcd"); 
		$dumpvars(1, tb_top); 
	end

endmodule
