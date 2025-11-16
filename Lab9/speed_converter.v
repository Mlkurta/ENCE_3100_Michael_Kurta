module speed_converter(
	input  wire        				i_clk,
	input  wire        				i_range_valid,   // 1-clk strobe when range_cm is new/final
	input  wire [10:0] 				i_range_cm,      // 0..2047 cm (you’ll clamp below)
	output reg  signed [7:0] 	o_speed8   // -127..+127 (neg=CCW, pos=CW)
);
    // Bands
    localparam [10:0] R_NEAR = 11'd10;
    localparam [10:0] R_MID  = 11'd55;
    localparam [10:0] R_FAR  = 11'd100;

    // Clamp helper (inline)
    function [10:0] clamp_10_100 (input [10:0] r);
        begin
            if (r < R_NEAR)      clamp_10_100 = R_NEAR;
            else if (r > R_FAR)  clamp_10_100 = R_FAR;
            else                 clamp_10_100 = r;
        end
    endfunction

    // We map linearly to ±127 using constant divides by 45.
    // Tools implement constant divides efficiently (mult/shift).
    always @(posedge i_clk) begin
        if (i_range_valid) begin
            reg [10:0] r;
            r = clamp_10_100(i_range_cm);

            if (r <= R_NEAR) begin
                o_speed8 <= -8'sd127;
            end else if (r < R_MID) begin
                // CCW side: scale 10→55 cm to 127→0
                // mag = 127 * (55 - r) / 45
                o_speed8 <= -$signed( (127 * (R_MID - r)) / 45 );
            end else if (r == R_MID) begin
                o_speed8 <= 8'sd0;
            end else if (r < R_FAR) begin
                // CW side: scale 55→100 cm to 0→127
                o_speed8 <=  $signed( (127 * (r - R_MID)) / 45 );
            end else begin
                o_speed8 <= 8'sd127;
            end
        end
    end
endmodule
`default_nettype wire