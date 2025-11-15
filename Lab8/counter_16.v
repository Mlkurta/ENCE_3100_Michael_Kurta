`default_nettype none

module counter_16(
	input					i_clk,
	input					i_enable,
	input 				i_clear,
	output reg [3:0]	o_counter

);

	always@(posedge i_clk)begin
	
		if(i_clear)
			o_counter <= 4'b0000;
		
		else if (i_enable)
			o_counter <= o_counter + 1;
			
	end

endmodule

`default_nettype wire