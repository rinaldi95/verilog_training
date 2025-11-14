`timescale 1ns/1ps

module tb_top;
	reg clk = 0;
	reg rst_n = 0;
	wire [3:0] led;

	always #5 clk=~clk;

	top dut (
		.clk (clk),
		.rst_n (rst_n),
		.led (led)
	);

	initial begin
		$dumpfile( "build/waves.vcd");
		$dumpvars(0,tb_top.clk, tb_top.rst_n, tb_top.led);

		repeat (2) @(posedge clk);
		rst_n=1'b1;
	
		check_value(4'd0,"after reset");

		repeat (5) @(posedge clk);
		check_value(4'd5, "after five increments");

		repeat(10) @(posedge clk);
		check_value(4'd15,"near wrap");

		@(posedge clk);
		check_value(4'd0,"wrap around");

		$display("test pass");
		$finish;
	end

	task check_value(input[3:0] expected, input [63:0] label);
		if (led!== expected) begin
			$fatal(1,"mismatch %0s:expected %0d got %0d at %0t",
				label, expected, led, $time);
			end
	endtask
endmodule
	
