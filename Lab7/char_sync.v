module char_sync(
	input i_clk,
	input [7:0] i_data,
	input i_ready,
	output reg [7:0] o_data,
	output reg o_ready
);


	always @(posedge i_clk) begin
		
		if(i_ready) begin
			
			o_data <= i_data;
			o_ready <= 1'b1;
			
		end else
			o_ready <= 1'b0;
			

	end



endmodule