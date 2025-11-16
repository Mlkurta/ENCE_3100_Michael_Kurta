
	`default_nettype none

module FSM_Ranger (
    input  wire        	i_clk,          // e.g., 50 MHz
    input  wire        	i_rst_n,        // active-low synchronous reset
    input  wire        	i_echo,         // async from HC-SR04 ECHO pin
    output reg  [10:0] 	o_range_cm,      // 11-bit distance (cm)
		output  				 		o_range_dv
);
    // ====== Parameters (keep your constants) ======
    localparam integer MIN_COUNT   = 21'd4999;   // minimum valid width in clocks
    localparam integer CYCLES_PER_CM = 11'd1457; // clocks per cm (your scaling)

    // ====== Synchronize ECHO to i_clk ======
    reg echo_ff1, echo_ff2;
    always @(posedge i_clk) begin
        if (!i_rst_n) begin
            echo_ff1 <= 1'b0;
            echo_ff2 <= 1'b0;
        end else begin
            echo_ff1 <= i_echo;
            echo_ff2 <= echo_ff1;
        end
    end
    wire echo_sync = echo_ff2;

    // ====== Edge detect (use previous synchronized sample) ======
    reg echo_sync_d;
    always @(posedge i_clk) begin
        if (!i_rst_n)
            echo_sync_d <= 1'b0;
        else
            echo_sync_d <= echo_sync;
    end

    wire rise_echo = (~echo_sync_d) &  echo_sync;
    wire fall_echo =  (echo_sync_d) & ~echo_sync;

    // ====== Measure width while ECHO is high ======
    reg [20:0] r_timeout;     // counts echo high time
    reg        measuring;     // simple 2-state FSM: IDLE/MEASURING

    always @(posedge i_clk) begin
        if (!i_rst_n) begin
            measuring  <= 1'b0;
            r_timeout  <= 21'd0;
            o_range_cm <= 11'd0;
        end else begin
            // state transitions
            if (rise_echo) begin
                measuring <= 1'b1;
                r_timeout <= 21'd0;          // start a fresh measurement
            end else if (fall_echo) begin
                measuring <= 1'b0;
                // compute distance only if width >= MIN_COUNT
                if (r_timeout > MIN_COUNT)
                    o_range_cm <= r_timeout / CYCLES_PER_CM;
                else
                    o_range_cm <= 11'd0;
            end else begin
                // stay in current state
                if (measuring) begin
                    // count only while ECHO remains high
                    r_timeout <= r_timeout + 21'd1;
                end
            end

            // Optional: watchdog if echo gets stuck high; cap counter
            if (measuring && &r_timeout) begin
                measuring  <= 1'b0;
                o_range_cm <= 11'd0;
            end
        end
    end
		
		reg r_measuring_2;
		
		always@(posedge i_clk) begin
			
			r_measuring_2 <= measuring;
			
		end
		
		assign o_range_dv = measuring & ~r_measuring_2;
		
		
		
endmodule

`default_nettype wire
