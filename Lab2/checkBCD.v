
`default_nettype none

module checkBCD(
	input  [3:0] i_a,
	input  [3:0] i_b,
	output o_error
);

	// Combinational Logic only
	wire [3:0] w_sum;
	wire w_cout;
	
	adder_4bit ad4_0(i_a[3:0], i_b[3:0], 0, w_cout, w_sum[3:0]);
	
	assign o_error = w_cout | (w_sum[3] & w_sum[2]) | (w_sum[3] & w_sum[1]);
	
endmodule
