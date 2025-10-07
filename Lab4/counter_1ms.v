module counter_1ms(
	// Board I/Os
	input		i_clk,
	input 	i_resetn,
	output	reg o_led_out
);
	
	// Counter Template
	parameter DIVISOR = 50000;
	reg [15:0] r_counter;  // 2^25 = 33,554,432 > 25,000,000
	//reg led_out;

	always @(posedge i_clk)
		if(!i_resetn)
		begin
			r_counter <= 0;
			o_led_out <= 0;
		end else
		begin
			// Comparator
			if(r_counter == DIVISOR - 1)
			begin
				r_counter <= 1'b0;
				o_led_out <= 1'b1;  
			end else begin
				r_counter <= r_counter + 1;
				o_led_out <= 1'b0;
				end
		end

endmodule
