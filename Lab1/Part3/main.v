module main(
	// Pinout assignment
	input [7:0] 	SW,
	output [9:0] 	LEDR
);

wire w_m0_m2x;
wire w_m1_m2y;
wire w_m2_m3x;
	
	
	mux_2_1 m0(		// u, v mux
	.s(SW[5]),
	.x(SW[4]),
	.y(SW[3]),
	.m(w_m0_m2x)
	);
	
	mux_2_1 m1(		// w, x mux
	.s(SW[5]),
	.x(SW[2]),
	.y(SW[1]),
	.m(w_m1_m2y)
	);
	
	mux_2_1 m2(		// mux with inputs from m0 and m1
	.s(SW[6]),	
	.x(w_m0_m2x),
	.y(w_m1_m2y),
	.m(w_m2_m3x)
	);
	
	mux_2_1 m3(		// mux with inputs from m2 and y
	.s(SW[7]),
	.x(w_m2_m3x),
	.y(SW[0]),
	.m(LEDR[0])
	);
	
	
	assign LEDR[9:1] = 0;   // Drive unused LEDs low to avoid floating
	


endmodule
