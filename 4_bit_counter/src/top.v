module top(
	input clk,
	input rst_n,
	output [3:0] led
);

	wire [3:0] count_q;
	wire [3:0] count_d;

	genvar i;
	generate 
		for (i=0;i<4;i=i+1) begin:gen_dff
			d_ff u_dff (
				.clk (clk),
				.rst_n (rst_n),
				.d (count_d[i]),
				.q (count_q[i])
			);
		end
	endgenerate	

	assign led= count_q;
	assign count_d = count_q + 4'd1;
endmodule

module d_ff(
	input clk,
	input rst_n,
	input d,
	output reg q
);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n)
			q<=1'b0;
		else
			q<=d;
	end
endmodule 
