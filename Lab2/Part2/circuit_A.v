
`default_nettype none

module circuit_A(
	input 	i_v2,
	input 	i_v1,
	input 	i_v0,
	output 	o_a0,
	output 	o_a1,
	output 	o_a2
);

	assign o_a0 = i_v0;
	assign o_a1 = ~i_v1;
	assign o_a2 = i_v1 & i_v2;

endmodule
