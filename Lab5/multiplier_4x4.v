
`default_nettype none

module multiplier_4x4(
	input 	[3:0] i_A,
	input 	[3:0] i_B,
	output 	[7:0] o_P,
	output 			o_Overflow
);


	
	wire  [3:0] w_ab0;
	wire  [3:0] w_ab1;
	
	assign w_ab0 	= i_A & {4{i_B[0]}};
	assign w_ab1 	= i_A & {4{i_B[1]}};
	assign o_P[0] = w_ab0[0];
				
	
	// First Stage of Adders
	//(parameter N = 4 default width) ([N-1:0] 	i_A, input 	[N-1:0]	i_B,	input	i_cin, output	[N-1:0]	o_sum, output	o_cout);
	
	wire w_co1, w_co2, w_co3, w_co4;
	
	wire w_s21, w_s31, w_s41;
	
	adder_nbit #(.N(1)) an0 (	.i_A(w_ab0[1]), 
														.i_B(w_ab1[0]),
														.i_cin(0),
														.o_sum(o_P[1]), 
														.o_cout(w_co1));
														
	adder_nbit #(.N(1)) an1 (	.i_A(w_ab0[2]), 
														.i_B(w_ab1[1]),
														.i_cin(w_co1),
														.o_sum(w_s21), 
														.o_cout(w_co2));
														
	adder_nbit #(.N(1)) an2 (	.i_A(w_ab0[3]), 
														.i_B(w_ab1[2]),
														.i_cin(w_co2),
														.o_sum(w_s31), 
														.o_cout(w_co3));
														
	adder_nbit #(.N(1)) an3 (	.i_A(1'b0), 
														.i_B(w_ab1[3]),
														.i_cin(w_co3),
														.o_sum(w_s41), 
														.o_cout(w_co4));
														
														
														
	// Second Stage of Adders
	
	wire w_co5, w_co6, w_co7, w_co8;
	
	wire w_s32, w_s42, w_s52;
	
	wire  [3:0] w_ab2;
	assign w_ab2 	= i_A & {4{i_B[2]}};
	
	adder_nbit #(.N(1)) an4 (	.i_A(w_s21), 
														.i_B(w_ab2[0]),
														.i_cin(0),
														.o_sum(o_P[2]), 
														.o_cout(w_co5));
														
	adder_nbit #(.N(1)) an5 (	.i_A(w_s31), 
														.i_B(w_ab2[2]),
														.i_cin(w_co5),
														.o_sum(w_s32), 
														.o_cout(w_co6));	
		
	adder_nbit #(.N(1)) an6 (	.i_A(w_s41), 
														.i_B(w_ab2[1]),
														.i_cin(w_co6),
														.o_sum(w_s42), 
														.o_cout(w_co7));
														
	adder_nbit #(.N(1)) an7 (	.i_A(w_co4), 
														.i_B(w_ab2[3]),
														.i_cin(w_co7),
														.o_sum(w_s52), 
														.o_cout(w_co8));													
														

	
	// Third Stage of Adders
	
	wire w_co9, w_co10, w_co11, w_co12;
	wire  [3:0] w_ab3;
	assign w_ab3 	= i_A & {4{i_B[3]}};
	
	adder_nbit #(.N(1)) an8 (	.i_A(w_s32), 
														.i_B(w_ab3[0]),
														.i_cin(0),
														.o_sum(o_P[3]), 
														.o_cout(w_co9));
														
	adder_nbit #(.N(1)) an9 (	.i_A(w_s42), 
														.i_B(w_ab3[1]),
														.i_cin(w_co9),
														.o_sum(o_P[4]), 
														.o_cout(w_co10));	
		
	adder_nbit #(.N(1)) an10 (	.i_A(w_s52), 
														.i_B(w_ab3[2]),
														.i_cin(w_co10),
														.o_sum(o_P[5]), 
														.o_cout(w_co11));
														
	adder_nbit #(.N(1)) an11 (	.i_A(w_co8), 
														.i_B(w_ab3[3]),
														.i_cin(w_co11),
														.o_sum(o_P[6]), 
														.o_cout(o_P[7]));	
	
	assign o_Overflow = o_P[7];

endmodule

`default_nettype wire
