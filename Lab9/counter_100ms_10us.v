`default_nettype none

module pulse_10us_100ms (
    input  wire clk,     // 50 MHz input clock
    input  wire rst_n,   // active-low synchronous reset
    output reg  pulse    // output pulse: 10 µs high every 100 ms
);
    // 10 µs × 50 MHz = 500 clock cycles high
    // 100 ms × 50 MHz = 5,000,000 clock cycles period
    localparam integer PULSE_CYCLES  = 500;
    localparam integer PERIOD_CYCLES = 5_000_000;

    reg [22:0] ctr = 23'd0;  // needs to count to 5e6 (< 2^23 = 8,388,608)

    always @(posedge clk) begin
        if (!rst_n)
            ctr <= 23'd0;
        else if (ctr == PERIOD_CYCLES - 1)
            ctr <= 23'd0;
        else
            ctr <= ctr + 1'd1;
    end

    // pulse is high for first 10 µs (500 cycles) of each 100 ms period
    always @(posedge clk) begin
        if (!rst_n)
            pulse <= 1'b0;
        else
            pulse <= (ctr < PULSE_CYCLES);
    end
endmodule

`default_nettype wire