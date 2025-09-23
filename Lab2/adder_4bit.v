
`default_nettype none

module adder_4bit(
	input 	[3:0] 	i_a,
	input 	[3:0] 	i_b,
	input 				i_cin,
	output 				o_cout,
	output 	[3:0] 	o_s
);

	wire w_fa0_co, w_fa1_co, w_fa2_co;
	
	// Combinational Logic only
	FA fa3(i_a[3], i_b[3], w_fa2_co, 	o_cout, 	o_s[3]);
	FA fa2(i_a[2], i_b[2], w_fa1_co, 	w_fa2_co, o_s[2]);
	FA fa1(i_a[1], i_b[1], w_fa0_co, 	w_fa1_co, o_s[1]);
	FA fa0(i_a[0], i_b[0], i_cin, 		w_fa0_co, o_s[0]);

endmodule
