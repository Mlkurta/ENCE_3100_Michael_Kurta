`default_nettype none
module speed8_to_steps #(
    parameter integer CLK_HZ   = 50_000_000,
    parameter integer MAX_SPS  = 400          // full-speed steps/s at |speed8|=127
)(
    input  wire              i_clk,
    input  wire signed [7:0] i_speed8,   // -127..+127
    output reg               o_dir,      // 0=CCW, 1=CW (choose convention you like)
    output reg               o_step      // 1-clk pulse per step event
);
    // 32-bit NCO
    reg  [31:0] phase;
    reg         msb_d;

    // INC_UNIT = round( 2^32 * MAX_SPS / (CLK_HZ * 127) )
    localparam integer INC_UNIT =
        ( ( (64'd1 << 32) * MAX_SPS + (CLK_HZ*127/2) ) / (CLK_HZ * 127) );

    wire [7:0] mag = i_speed8[7] ? (~i_speed8 + 1'b1) : i_speed8; // abs
    wire [39:0] phase_inc_wide = mag * INC_UNIT;                   // 8b * ~10–12b const
    wire [31:0] phase_inc      = phase_inc_wide[31:0];

    always @(posedge i_clk) begin
        o_dir  <= i_speed8[7];                 // sign → direction
        phase  <= phase + phase_inc;           // accumulate phase
        msb_d  <= phase[31];
        o_step <= phase[31] ^ msb_d;           // pulse on MSB toggle
    end
endmodule
`default_nettype wire