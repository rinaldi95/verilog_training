module sr_latch_nand(
	input s_n,
	input r_n,
	output q,
	output q_bar
);
	wire q_int;
	wire q_bar_int;

	nand (q_int, s_n, q_bar_int);
	nand (q_bar_int, r_n, q_int);

	assign q = q_int;
	assign q_bar = q_bar_int;
endmodule

module d_latch_nand(
	input d,
	input enable,
	input reset_n,
	output q,
	output q_bar
);
	wire s_n;
	wire r_n;

	assign s_n = ~(d & enable & reset_n);
	assign r_n = ~( (~d & enable & reset_n) | (~reset_n));

	sr_latch_nand u_latch(
		.s_n(s_n),
		.r_n(r_n),
		.q(q),
		.q_bar(q_bar)
	);
endmodule

module top(
	input clk,
	input reset_n,
	input d,
	output q,
	output q_bar
);
	wire master_q;
	wire master_q_bar;

	d_latch_nand master(
		.d(d),
		.enable(~clk),
		.reset_n(reset_n),
		.q(master_q),
		.q_bar(master_q_bar)
	);

	d_latch_nand slave(
		.d(master_q),
		.enable(clk),
		.reset_n(reset_n),
		.q(q),
		.q_bar(q_bar)
	);
endmodule
