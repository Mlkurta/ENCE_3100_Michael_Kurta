`default_nettype none
module ma5_range(
    input  wire        clk,
    input  wire        rst_n,          // active-low sync reset
    input  wire        w_range_dv,     // 1-clk strobe: new sample valid
    input  wire [10:0] i_range_cm,     // 11-bit sample (0..2047)

    output reg         o_avg_valid,    // pulses when o_avg updates
    output reg  [10:0] o_avg_cm        // 5-point moving average (11-bit)
);
    // Last 5 samples (circular buffer)
    reg [10:0] buffer [0:4];
    reg [2:0]  wr_idx;                 // 0..4
    reg [2:0]  fill_cnt;               // 0..5

    // Running sum: max = 5 * 2047 = 10235 -> needs 14 bits
    reg [13:0] sum;

    integer k;
    always @(posedge clk) begin
        if (!rst_n) begin
            for (k=0; k<5; k=k+1) buffer[k] <= 11'd0;
            wr_idx      <= 3'd0;
            fill_cnt    <= 3'd0;
            sum         <= 14'd0;
            o_avg_cm    <= 11'd0;
            o_avg_valid <= 1'b0;
        end else begin
            o_avg_valid <= 1'b0;

            if (w_range_dv) begin
                // running-sum update: sum <- sum + new - oldest
                sum            <= sum + i_range_cm - buffer[wr_idx];
                buffer[wr_idx]    <= i_range_cm;
                wr_idx         <= (wr_idx == 3'd4) ? 3'd0 : wr_idx + 3'd1;
                if (fill_cnt != 3'd5) fill_cnt <= fill_cnt + 3'd1;

                // compute average once window is full
                if (fill_cnt == 3'd5) begin
                    // Divide-by-5 as multiply + shift with rounding:
                    // avg ≈ (sum * 52429 + 2^17) >> 18  (since 52429/2^18 ≈ 1/5)
                    reg [31:0] prod;
                    prod       = (sum * 17'd52429) + 32'd131072; // +2^17
                    o_avg_cm   <= prod[31:18];                   // >> 18
                    o_avg_valid <= 1'b1;
                end
            end
        end
    end
endmodule
`default_nettype wire