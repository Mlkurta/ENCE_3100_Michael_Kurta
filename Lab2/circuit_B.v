
`default_nettype none

module circuit_B(
	input 				i_z,
	output	[7:0]		o_seg
);
	
	
	assign o_seg[7] 	= 1'b1;
	assign o_seg[6]		= 1'b1;
	assign o_seg[5]		= i_z;
	assign o_seg[4]		= i_z;
	assign o_seg[3]		= i_z;
	assign o_seg[2]		= 1'b0;
	assign o_seg[1]		= 1'b0;
	assign o_seg[0]		= i_z;
	

endmodule
