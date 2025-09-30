`default_nettype none
module gated_d_latch(
	// Pinout assignment
	input 				clk,
	input 				D, 
	output  			Qa, 
	output 				Qb
);

	wire w_R_g, w_S_g, w_Qa, w_Qb/* synthesis keep */;
	
	assign w_R_g 	= !(clk & !D);
	assign w_S_g 	= !(clk & D);
	assign Qa 		= !(w_S_g & w_Qb);
	assign Qb 		= !(w_R_g & w_Qa);
	assign w_Qa		= Qa;
	assign w_Qb 	= Qb;
	
endmodule