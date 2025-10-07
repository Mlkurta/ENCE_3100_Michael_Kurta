// 8-bit binary to BCD (hundreds, tens, ones) using Double Dabble
// Verilog-2001, fully combinational/synthesizable
module bin8_to_bcd_3dig (
    input      [7:0] bin,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
);
    integer i;
    reg [19:0] shift; // {hundreds[19:16], tens[15:12], ones[11:8], bin_work[7:0]}

    always @* begin
        // pack BCD nibbles (zeroed) above the 8-bit binary
        shift = {12'd0, bin};

        // perform 8 iterations: add-3 to any BCD nibble >=5, then left-shift 1
        for (i = 0; i < 8; i = i + 1) begin
            // hundreds nibble
            if (shift[19:16] >= 5)
                shift[19:16] = shift[19:16] + 4'd3;
            // tens nibble
            if (shift[15:12] >= 5)
                shift[15:12] = shift[15:12] + 4'd3;
            // ones nibble
            if (shift[11:8] >= 5)
                shift[11:8] = shift[11:8] + 4'd3;

            // shift the whole register left by 1 (MSB of bin moves into ones, etc.)
            shift = shift << 1;
        end

        // extract the BCD digits
        hundreds = shift[19:16];
        tens     = shift[15:12];
        ones     = shift[11:8];
    end
endmodule