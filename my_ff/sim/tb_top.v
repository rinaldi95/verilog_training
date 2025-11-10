`timescale 1ns/1ps

module tb_top;
	reg clk = 0;
	reg reset_n = 0;
	reg d = 0;
	wire q;
	wire q_bar;

	always #5 clk = ~clk;

	top dut(
		.clk(clk),
		.reset_n(reset_n),
		.d(d),
		.q(q),
		.q_bar(q_bar)
	);

	task drive_and_expect(input logic next_d, input int idle_cycles, input int skew_ns);
		begin
			repeat (idle_cycles) @(posedge clk);
			@(negedge clk);
			#(skew_ns);
			d = next_d;
			@(posedge clk);
			#1;
			if (q !== next_d || q_bar !== ~next_d) begin
				$display("Mismatch: d=%0b q=%0b q_bar=%0b", next_d, q, q_bar);
				$fatal;
			end
		end
	endtask

	initial begin
		$dumpfile("build/waves.vcd");
		$dumpvars(0, tb_top.clk, tb_top.reset_n, tb_top.d, tb_top.q, tb_top.q_bar);

		repeat (2) @(posedge clk);
		reset_n = 1;
		@(posedge clk);

		drive_and_expect(1'b1, 0, 1);
		drive_and_expect(1'b0, 1, 2);
		drive_and_expect(1'b1, 0, 4);
		drive_and_expect(1'b0, 2, 1);
		drive_and_expect(1'b1, 1, 3);
		drive_and_expect(1'b0, 0, 0);
		drive_and_expect(1'b1, 3, 2);
		drive_and_expect(1'b0, 0, 4);

		$display("TEST PASS");
		$finish;
	end
endmodule
