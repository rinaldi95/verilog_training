module top(
	input clock,
	input reset,
	input D,
	output reg Q,
	output Q_not
	);

	always @(posedge clock or posedge reset) begin
		if (reset) begin
			Q <= 1'b0;
		end else begin
			Q <= D;
		end
	end

	assign Q_not = ~Q;
endmodule
