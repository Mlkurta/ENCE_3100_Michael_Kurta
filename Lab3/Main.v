`default_nettype none
module main(
	// Pinout assignment
	input MAX10_CLK1_50,
	input [9:0] SW,
	output[9:0] LEDR
);


	// Part 1
	// gated_rs_latch(input Clk,input R, input S,output Q);
	// gated_rs_latch rs0(SW[0], SW[2], SW[1], LEDR[0]);
	
	
	// Part 2
	// gated_d_latch(input clk, input D, output Qa, output Qb);
	// gated_d_latch gd0(SW[0], SW[1], LEDR[1], LEDR[0]);
	
	
	// Part 3
	// gated_d_latch(input clk, input D, output Qa, output Qb);
	// wire w_Qm, w_clk;
	
	// gated_d_latch gd0(w_clk, SW[1], w_Qm, );
	// gated_d_latch gd1(SW[0], w_Qm, LEDR[1], LEDR[0]);
	
	// assign w_clk = ~SW[0];
	
	
	// Part 4
	//latch_ff(input clk,input D,	output Qa,	output Qan,	output Qb, output Qbn, output Qc,	output Qcn);
	latch_ff  ff0(SW[0], SW[1],	LEDR[5],	LEDR[4],	LEDR[3], LEDR[2], LEDR[1],	LEDR[0]);
		
	
endmodule

