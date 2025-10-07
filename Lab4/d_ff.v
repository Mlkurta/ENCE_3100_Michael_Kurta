module d_ff(
input 			i_clk,
input				i_D,
output reg	o_Qa,
output reg	o_Qb
);

	
	always@(posedge i_clk) begin
		o_Qa <= i_D;
		o_Qb <= !i_D;
		
	end

endmodule