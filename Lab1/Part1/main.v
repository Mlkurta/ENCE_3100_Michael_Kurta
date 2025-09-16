module main(
	// Pinout assignment
	input [9:0] 	SW,
	output [9:0] 	LEDR
);



	assign LEDR[9:0] = SW[9:0];
/*
	
	mux_2_1 m0(
	.s(SW[2]),
	.x(SW[0]),
	.y(SW[1]),
	.m(LEDR[0])
	);
	
*/
endmodule
