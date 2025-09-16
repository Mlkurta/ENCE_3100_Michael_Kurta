module main(
	// Pinout assignment
	input [8:0] 	SW,
	output [9:0] 	LEDR
);


	
	
	mux_2_1 m0(
	.s(SW[8]),
	.x(SW[0]),
	.y(SW[1]),
	.m(LEDR[0])
	);
	
	mux_2_1 m1(
	.s(SW[8]),
	.x(SW[2]),
	.y(SW[3]),
	.m(LEDR[1])
	);
	
	mux_2_1 m2(
	.s(SW[8]),
	.x(SW[4]),
	.y(SW[5]),
	.m(LEDR[2])
	);
	
	mux_2_1 m3(
	.s(SW[8]),
	.x(SW[6]),
	.y(SW[7]),
	.m(LEDR[3])
	);
 
	assign LEDR[9:4] = 0;
	


endmodule
