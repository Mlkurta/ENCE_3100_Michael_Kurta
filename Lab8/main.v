
`default_nettype none

module main(
	input		MAX10_CLK1_50,
	input		[1:0]		KEY,
	input		[9:0]		SW,
	inout		[35:0] 	GPIO,
	output	[9:0]		LEDR,
	output	[7:0]		HEX0,
	output	[7:0]		HEX2,
	output	[7:0]		HEX4,
	output	[7:0]		HEX5
);

	localparam N = 4;
	
	// User Wires
	// ------------------------------
	wire w_clock;
	wire w_reset = SW[8];
	
	wire [N-1:0] w_user_input = SW[3:0];
	
	wire w_carry;
	assign LEDR[9] = w_carry;
	
	wire [N-1:0] w_rOut;
	
	// DEBUG
	//assign LEDR[7:4] = w_AluA;
	
	// ------------------------------
	
	// Internal Wires
	// ------------------------------
	wire [N-1:0] w_IB_BUS;
	wire [N-1:0] w_AluA;
	wire [N-1:0] w_AluB;
	
	wire [N-1:0] w_counter;
	wire [N-1:0] w_data;
	wire [N-1:0] w_instruction;
	wire 				 w_main_reset;
	
	// ------------------------------
	
	// FSM CONTROL Wires
	// ------------------------------
	wire w_LatchA;
	wire w_EnableA;
	wire w_LatchB;
	wire w_EnableALU;
	wire w_AddSub;
	wire w_EnableIN;
	wire w_EnableOut;
	wire w_LoadInstr;
	wire w_EnableInstr;
	wire [N-1:0] w_ToInstr;
	wire w_ProgCount;
	wire w_EnableCount;
	// ------------------------------
	/*
		DeBounce db1(
    .clk(MAX10_CLK1_50), //this is a 50MHz clock provided on FPGA pin PIN_Y2
    .PB(SW[9]),  //this is the input to be debounced
    .PB_state(w_clock)  //this is the debounced switch
);*/
	
	// Accumulator A (default 4bits)
		Accumulator_A AccA(
		.MainClock(w_clock),
		.ClearA(w_reset),
		.LatchA(w_LatchA),  		// FSM CONTROL
		.EnableA(w_EnableA),  	// FSM CONTROL
		.A(w_IB_BUS[3:0]),
		.IB_BUS(w_IB_BUS[3:0]),
		.AluA(w_AluA [3:0])
	);

		counter_1s c1s(
			.i_clk(MAX10_CLK1_50),
			.i_reset(1'b0),
			.o_flag(w_clock)
		);
	
		InRegister Inreg (
		.EnableIN(w_EnableIN),
		.DataIn(w_user_input[3:0]),
		.IB_BUS(w_IB_BUS[3:0])
	);
	
	
		OutRegister oReg1(
		.MainClock(w_clock),
		.MainReset(w_reset),
		.EnableOut(w_EnableOut),
		.IB_BUS(w_IB_BUS [3:0]),
		.rOut(w_HEX0)
	);
	
		wire [3:0] w_HEX0;
	

		FSM_MicroInstr fsm0 (
		.clk(w_clock),
		.reset(w_reset),
		.IB_BUS(w_IB_BUS[3:0]),
		.LatchA(w_LatchA),
		.EnableA(w_EnableA),
		.LatchB(w_LatchB),
		.EnableALU(w_EnableALU),
		.AddSub(w_AddSub),
		.EnableIN(w_EnableIN),
		.EnableOut(w_EnableOut),
		.LoadInstr(w_LoadInstr),
		.EnableInstr(w_EnableInstr),
		.ToInstr(w_ToInstr),
		.EnableCount(w_ProgCount)
	);
		Accumulator_B accB(
		.MainClock(w_clock),
		.ClearB(w_reset),
		.LatchB(w_LatchB),
		.B(w_IB_BUS[3:0]),
		.AluB(w_AluB [3:0])
	);
	
	
									
		Arithmetic_Unit alu1(			//// Not tested
		.EnableALU(w_EnableALU),
		.AddSub(w_AddSub),
		.A(w_AluA [3:0]),
		.B(w_AluB [3:0]),
		.Carry(),
		.IB_ALU(w_IB_BUS[3:0])
	);
	
	
	wire [3:0] w_clk1s;
	
	counter_16 c16(
		.i_clk(w_clock),
		.i_enable(w_ProgCount),
		.i_clear(w_reset),
		.o_counter(w_clk1s[3:0])
	);

	// Reduce the bit-width coming fromm the counter and pad it with zeros to make 8 bit.
		wire [7:0] w_program_mem = (w_clk1s [3:0] & 8'b00000111);
	
		ROM_Nx8 rom(
		.address(w_program_mem [7:0]),
		.data(w_instr_reg8[7:0])
	);
	
	wire [7:0] w_instr_reg8;
	
	
	InstructionReg #(4) RegI 
(
	.MainClock(w_clock),
	.ClearInstr(w_reset),
	.LatchInstr(w_LoadInstr),
	.EnableInstr(w_EnableInstr),
	.Data(w_instr_reg8[3:0]),
	.Instr(w_instr_reg8[7:4]),
	.ToInstr(w_ToInstr),
	.IB_BUS(w_IB_BUS[3:0])
);

	seg7Decoder d0(
	.i_bin(w_HEX0),
	.o_HEX(HEX0)
);

	seg7Decoder d1(
	.i_bin(w_AluA [3:0]),
	.o_HEX(HEX2)
);

	seg7Decoder d2(
	.i_bin(w_AluB [3:0]),
	.o_HEX(HEX4)
);

	seg7Decoder d3(
	.i_bin(w_IB_BUS[3:0]),
	.o_HEX(HEX5)
);

	
endmodule

`default_nettype wire
