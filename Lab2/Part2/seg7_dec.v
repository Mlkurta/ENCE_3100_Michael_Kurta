`default_nettype none

module seg7_dec(
	input i_m3,
	input i_m2,
	input i_m1,
	input i_m0,
	output [7:0]o_SEG
);


	assign o_SEG[0] = ~i_m3&~i_m2&~i_m1&i_m0|i_m2&~i_m1&~i_m0|i_m3&i_m2&i_m1&i_m0;
	assign o_SEG[1] = i_m2&~i_m1&i_m0|i_m2&i_m1&~i_m0|i_m3&i_m2&i_m0;
	assign o_SEG[2] = ~i_m2&i_m1&~i_m0|i_m3&i_m2&i_m1&i_m0;
	assign o_SEG[3] = ~i_m3&~i_m2&~i_m1&i_m0|i_m2&~i_m1&~i_m0|~i_m3&i_m2&i_m1&i_m0;
	assign o_SEG[4] = i_m2&~i_m1|~i_m3&i_m0|~i_m2&i_m0;
	assign o_SEG[5] = ~i_m3&~i_m2&i_m0|~i_m2&i_m1|~i_m3&i_m1&i_m0;
	assign o_SEG[6] = ~i_m3&~i_m2&~i_m1|~i_m3&i_m2&i_m1&i_m0;
	assign o_SEG[7] = 1'b1;
	

endmodule