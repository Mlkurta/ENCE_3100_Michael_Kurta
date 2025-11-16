
`default_nettype none

module main(
	input 					MAX10_CLK1_50,
	input 	[9:0] 	SW,
	inout 	[15:0] 	ARDUINO_IO,
	output 	[9:0] 	LEDR,
	output	[7:0]		HEX0,
	output	[7:0]		HEX1,
	output	[7:0]		HEX2,
	output 	[7:0]		HEX3
);


	
	pulse_10us_100ms (
    .clk(MAX10_CLK1_50),     // 50 MHz input clock
    .rst_n(SW[9]),   // active-low synchronous reset
    .pulse(ARDUINO_IO[11])    // output pulse: 10 µs high every 100 ms
);

  

	FSM_Ranger rm(
		.i_clk(MAX10_CLK1_50),
		.i_rst_n(SW[9]),
		.i_echo(ARDUINO_IO[13]),
		.o_range_cm(w_range_cm[10:0]),
		.o_range_dv(w_range_dv)
	);
	
	ma5_range ma5(
    .clk(MAX10_CLK1_50),
    .rst_n(SW[9]),
    .w_range_dv(w_range_dv),
    .i_range_cm(w_range_cm[10:0]),
    .o_avg_valid(w_avg_dv),
    .o_avg_cm(w_avg_range[10:0])
);
	
	//assign LEDR[0] = w_range_cm[10:1];			// debug
	wire w_range_dv, w_avg_dv, w_dir, w_step;
	wire [10:0] w_range_cm;
	wire [15:0] w_range_16b;
	wire [10:0] w_avg_range;
	wire [7:0] 	w_speed8;
	assign w_range_16b = {5'b0, w_range_cm};
	
	wire [3:0] w_thousands, w_hundreds, w_tens, w_ones;
	
	bin16_to_bcd binbcd(
    .bin(w_range_16b),    					// 0..65535
    .bcd_ten_thousands(),    				// 0..6
    .bcd_thousands(w_thousands),    // 0..9
    .bcd_hundreds(w_hundreds),      // 0..9
    .bcd_tens(w_tens),             	// 0..9
    .bcd_ones(w_ones)              	// 0..9
	);
	
		speed_converter spc1(
		.i_clk(MAX10_CLK1_50),
		.i_range_valid(w_avg_dv),
		.i_range_cm(w_avg_range[10:0]),
		.o_speed8(w_speed8)
	);
	
	assign LEDR[7:0] = w_speed8;
	
	speed8_to_steps s2stp(
    .i_clk(MAX10_CLK1_50),
    .i_speed8(w_speed8),   	
    .o_dir(w_dir),      	
    .o_step(w_step)      	
	);
	
	stepper_28byj_fullstep step(
    .i_clk(MAX10_CLK1_50),
    .i_step_pulse(w_step),  				// one-clock pulse from NCO
    .i_dir(w_dir),         					// 0=CCW, 1=CW
    .o_A(ARDUINO_IO[10]),           // to ULN2003 IN1
    .o_B(ARDUINO_IO[9]),            // to ULN2003 IN2
    .o_C(ARDUINO_IO[8]),            // to ULN2003 IN3
    .o_D(ARDUINO_IO[7])             // to ULN2003 IN4
);
	
		seg7Decoder thou(
		.i_bin(w_thousands),
		.o_HEX(HEX3)
	);
	
	seg7Decoder hund(
		.i_bin(w_hundreds),
		.o_HEX(HEX2)
	);
	
	seg7Decoder tens(
		.i_bin(w_tens),
		.o_HEX(HEX1)
	);

	seg7Decoder ones(
		.i_bin(w_ones),
		.o_HEX(HEX0)
	);
	

endmodule
