
`default_nettype none

module multiplier_8x8(
	input 	[7:0] i_A,
	input 	[7:0] i_B,
	output 	[15:0] o_P,
	output 			o_Overflow
);

	// First Stage of Adders
	
	wire  w_co1,	w_co2,	w_co3,	w_co4,
				w_co5, 	w_co6,	w_co7; 
				
	wire [7:0] w_sb1; // bits 1 to 8
	
	
	wire [6:0] w_ab0;
	wire [7:0] w_ab1;
	
	assign o_P[0] 	= i_A[0] & i_B[0];
	assign w_ab0[0] = i_A[1] & i_B[0];
	assign w_ab0[1] = i_A[2] & i_B[0];
	assign w_ab0[2] = i_A[3] & i_B[0];
	assign w_ab0[3] = i_A[4] & i_B[0];
	assign w_ab0[4] = i_A[5] & i_B[0];
	assign w_ab0[5] = i_A[6] & i_B[0];
	assign w_ab0[6] = i_A[7] & i_B[0];
	
	
	assign w_ab1 = i_A & {8{i_B[1]}};
	
	adder_nbit #(.N(8)) an0 (	.i_A({1'b0, w_ab0}), 
														.i_B(w_ab1),
														.i_cin(0),
														.o_sum(w_sb1), 
														.o_cout(w_co1));
	
														
	// Second Stage of Adders	
	
	wire [7:0] w_ab2;
	
	wire [7:0] w_sb2; 	// bits 2 to 9
	
	assign w_ab2 = i_A & {8{i_B[2]}};
	
	adder_nbit #(.N(8)) an1 (	.i_A({w_co1, w_sb1[7:1]}), 
														.i_B(w_ab2),
														.i_cin(0),
														.o_sum(w_sb2), 
														.o_cout(w_co2));
	
	
	// Third Stage of Adders
	
	wire [7:0] w_ab3;
	
	wire [7:0] w_sb3; 	// bits 3 to 10
	
	assign w_ab3 = i_A & {8{i_B[3]}};
	
	adder_nbit #(.N(8)) an2 (	.i_A({w_co2, w_sb2[7:1]}), 
														.i_B(w_ab3),
														.i_cin(0),
														.o_sum(w_sb3), 
														.o_cout(w_co3));
	

	
	// Fourth Stage of Adders
	
	wire [7:0] w_ab4;
	
	wire [7:0] w_sb4;  	// bits 4 to 11
	
	assign w_ab4 = i_A & {8{i_B[4]}};
	
	adder_nbit #(.N(8)) an3 (	.i_A({w_co3, w_sb3[7:1]}), 
														.i_B(w_ab4),
														.i_cin(0),
														.o_sum(w_sb4), 
														.o_cout(w_co4));
	
	// 5th Stage of Adders
	
	wire [7:0] w_ab5;
	
	wire [7:0] w_sb5;		// bits 5 to 12
	
	assign w_ab5 = i_A & {8{i_B[5]}};
	
	adder_nbit #(.N(8)) an4 (	.i_A({w_co4, w_sb4[7:1]}), 
														.i_B(w_ab5),
														.i_cin(0),
														.o_sum(w_sb5), 
														.o_cout(w_co5));
		
	// 6th Stage of Adders
	
	wire [7:0] w_ab6;
	
	wire [7:0] w_sb6;		// bits 6 to 13
	
	assign w_ab6 = i_A & {8{i_B[6]}};
	
	adder_nbit #(.N(8)) an5 (	.i_A({w_co5, w_sb5[7:1]}), 
														.i_B(w_ab6),
														.i_cin(0),
														.o_sum(w_sb6), 
														.o_cout(w_co6));
		
	// 7th Stage of Adders

	wire [7:0] w_ab7;
	
	assign w_ab7 = i_A & {8{i_B[7]}};

	adder_nbit #(.N(8)) an6 (	.i_A({w_co6, w_sb6[7:1]}), 
														.i_B(w_ab7),
														.i_cin(0),
														.o_sum(o_P[14:7]), 
														.o_cout(o_P[15])
													);
														

	assign o_P[1] = w_sb1[0];
	assign o_P[2] = w_sb2[0];
	assign o_P[3] = w_sb3[0];
	assign o_P[4] = w_sb4[0];
	assign o_P[5] = w_sb5[0];
	assign o_P[6] = w_sb6[0];
	
endmodule

`default_nettype wire
