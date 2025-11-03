module top(
	input clk,
	input reset,
	input d,
	output reg q,
	output reg q_not
	);



	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			q<= 1'b0;
			q_not <= 1'b1;
		end
		else begin
			q<=d;
			q_not<=~d;
		end
	end 
endmodule
