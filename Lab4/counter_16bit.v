module counter_16bit(
	input 		i_clk,
	input 		i_clear,
	output 		[15:0] o_Q
);


	reg [15:0] r_Q = 16'h0;
	
	always@(posedge i_clk) begin
		if(!i_clear)
			r_Q <= 16'd0;
		else
			r_Q <= r_Q + 1;
			
	end

	assign o_Q = r_Q;

	endmodule