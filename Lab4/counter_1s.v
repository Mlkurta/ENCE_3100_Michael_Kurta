module counter_1s(
	input 	i_clk,
	input 	i_reset,
	output 	o_flag
	);
	
	wire w_reset;
	wire w_clk;
	assign w_clk = i_clk;
	assign w_reset = i_reset;
	
	reg r_flag = 0;

	reg [24:0] q;
	
	localparam COUNTER_MAX = 25'd25000000;
	
	always@(posedge i_clk, negedge w_reset) begin
		if(!w_reset)
			q <= 25'd0;
		else begin
			if(q == 25'd25000000) begin
				q <= 0;
				r_flag <= ~r_flag;
			end
			else
				q <= q + 1'b1;
			end
		
		end
		
		assign o_flag = r_flag;

endmodule