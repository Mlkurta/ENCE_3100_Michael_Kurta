module d_ff(
input 			clk,
input				D,
output 			Qa,
output 			Qb
);

	wire w_Qm, w_clk;
	
	gated_d_latch gd0(w_clk, D, w_Qm, );
	gated_d_latch gd1(clk, w_Qm, Qa, Qb);
	
	assign w_clk = ~clk;



endmodule