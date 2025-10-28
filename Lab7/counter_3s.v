module counter_3s(
	input 	i_clk,
	input 	i_start,
	output 	o_flag
	);
	

	wire w_clk;
	assign w_clk = i_clk;

	
	reg r_flag = 0;
	
	wire start_s = i_start;  // use this if i_start is already synchronous

    // Rising-edge detector for start
    reg start_q;
    wire start_rise = start_s & ~start_q;

	reg [27:0] q;
	
	localparam COUNTER_MAX = 28'd150000000;
	
	always@(posedge i_clk) begin
		if(start_rise)
			q <= 28'd0;
		else begin
			if(q == 28'd150000000) begin
				q <= 0;
				r_flag <= ~r_flag;
			end
			else
				q <= q + 1'b1;
			end
		
		end
		
		assign o_flag = r_flag;

endmodule