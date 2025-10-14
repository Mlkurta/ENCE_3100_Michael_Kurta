module accumulator_8bit(
	input 	[7:0] i_A,
	input 			i_clk,
	input				i_rst,
	output 			o_overflow,
	output 	[7:0] o_S
);

	wire [7:0] w_A;
	wire [7:0] w_S;
	//wire [7:0] w_B;
	wire w_overflow;
	
	//assign w_B = o_S;


	// 8bit Register
	reg_nbit #(.N(8)) REG_A

(
	.i_R(i_A),
	.i_clk(i_clk),
	.i_rst(i_rst),
	.o_Q(w_A)
);

	// 8bit ALU
	/*
	alu_8bit(
	
	.i_cin(1'b0),
	.i_A(w_A),
	.i_B(o_S),
	.o_sum(w_S),
	.o_overflow(w_overflow)

);*/

assign {w_overflow, w_S} = w_A + o_S;

	// 1bit Register
	reg_nbit #(.N(1)) REG_B

(
	.i_R(w_overflow),
	.i_clk(i_clk),
	.i_rst(i_rst),
	.o_Q(o_overflow)
);
	
	// 8bit Register
	reg_nbit #(.N(8)) REG_C

(
	.i_R(w_S),
	.i_clk(i_clk),
	.i_rst(i_rst),
	.o_Q(o_S)
);
	
endmodule
