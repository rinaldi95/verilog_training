module top(input clk, input rst_n, output reg [3:0] led);
	always @(posedge clk or negedge rst_n)
		if (!rst_n)
			led<=0;
		else
			led<=led+1;
endmodule
