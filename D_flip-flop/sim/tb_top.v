`timescale 1ns/1ps
module tb_top;
	reg clk;
	reg reset;
	reg d;
	wire q;
	wire q_not;

	top dut (
		.clk(clk),
		.reset(reset),
		.d(d),
		.q(q),
		.q_not(q_not)
	);

	initial begin
		clk =0;
		$dumpfile("build/waves.vcd");
		$dumpvars(0, tb_top);
		forever #5 clk = ~clk;
	end

	initial begin 
		reset =0;
		d=0;
		#10 reset=1;
		#20 d=1;
		#20 d=0;
		#20 d=1;
		#100 $finish;
	end

	initial begin
		$monitor("Time=%0t | clk=%b reset=%b d=%b | q=%b q_not=%b", $time,clk, reset, d, q, q_not);
	end
endmodule
