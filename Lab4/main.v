module main(
	input 					MAX10_CLK1_50,
	input 	[9:0] 	SW,
	input 	[1:0]		KEY,
	output 	[9:0] 	LEDR,
	output	[7:0]		HEX0,
	output	[7:0]		HEX1,
	output	[7:0]		HEX2,
	output	[7:0]		HEX3,
	output	[7:0]		HEX4,
	output	[7:0]		HEX5
);

	// Part I
	//******************
	
	// First create the TFF from a DFF
	// -------------------------------
	
	// Create an 8-bit counter cascading 8 TFF
	// ---------------------------------------
	
	// Connect 2 seg7Decoders to the output of the TFF counter
	// --------------------------------------------------------
	/*
	wire [7:0] w_Q;
	wire w_enable;
	*/
	//counter_4b(input i_clk,	input	i_enable,	input	i_clear, output	o_Q);
	
	//counter_8b c0(SW[2],	SW[1], SW[0], w_Q[7:0]);
	//counter_LPM	c0(.clk_en ( SW[1] ),.clock ( w_enable ),.sclr ( SW[9] ),.q ( w_Q[7:0] ));
	
	//counter_1s(input	i_clk,input	i_reset,	output o_flag);
	//counter_1s c1(MAX10_CLK1_50, SW[0], w_enable);
	
 
	// seg7Decoder([3:0]i_bin, [7:0]o_HEX);
	/*
	seg7Decoder Ones(w_Q[3:0], HEX0);
	seg7Decoder Tens(w_Q[7:4], HEX1);
	*/
	
	//******************
	
	// Part II
	//******************

	// Connect 2 seg7Decoders to the output of the shift register
	//counter_16bit(input i_clk,	input	i_clear,	output[15:0] o_Q);
	
	//counter_1s c1(MAX10_CLK1_50, SW[0], w_enable);
	
	/*
	counter_1ms ms0(

	.i_clk(MAX10_CLK1_50),
	.i_resetn(SW[0]),
	.o_led_out(w_enable)
);
	counter_16bit c2(w_enable,	SW[0], w_Q[15:0]);
	
	wire [15:0]w_Q;

	seg7Decoder Ones(w_Q[3:0], HEX0);
	seg7Decoder Tens(w_Q[7:4], HEX1);
	seg7Decoder Hundreds(w_Q[11:8], HEX2);
	seg7Decoder Thousands(w_Q[15:12], HEX3);
	*/
	
	// --------------------------------------------------------
	
	//******************
	
	// Part III
	//******************	
	
	// Connect 2 seg7Decoders to the output of the LPM Counter
	// --------------------------------------------------------
	/*
		wire w_clk;
		wire [7:0] w_Q;
		
		assign w_clk = MAX10_CLK1_50;
		
	  counter_LPM	c0(.clk_en ( SW[1] ),.clock ( w_enable ),.sclr ( SW[9] ),.q ( w_Q ));

		counter_1s c1(w_clk, SW[0], w_enable);
		
		seg7Decoder Tens(w_Q[7:4], HEX1);
		seg7Decoder Ones(w_Q[3:0], HEX0);
		*/
		
		
	//******************
	
	// Part IV
	//******************
	
		wire w_sclk;

	// Create 1 second counter
	// -----------------------
		counter_1s c1(MAX10_CLK1_50, SW[0], w_sclk);
	
	// Connect the 1 second counter to one of the previous counters
	// ------------------------------------------------------------
		counter_8b c8_0(
		.i_clk(w_sclk), 
		.i_enable(SW[1]),
		.i_clear(SW[2]),
		.o_Q(w_Q)
	);
		wire [7:0] w_Q;
		wire [3:0] w_ones;
		wire [3:0] w_tens;
		wire [3:0] w_hundreds;
	
	bin8_to_bcd_3dig (
    .bin(w_Q),
    .hundreds(w_hundreds),
    .tens(w_tens),
    .ones(w_ones)
);
		
	// Connect the counter to one seg7Decoder
	
	seg7Decoder Ones(w_ones[3:0], HEX0);
	seg7Decoder Tens(w_tens[3:0], HEX1);
	seg7Decoder Hundreds(w_hundreds[3:0], HEX2);
	// --------------------------------------
	
	// Finally add additional logic to reset back to 0 when it reaches 9
	// -----------------------------------------------------------------

	//******************
	
	// Part V
	//******************
	//******************

endmodule


