`default_nettype none
module latch_ff(
	// Pinout assignment
	input clk,
	input D,
	output Qa,
	output Qan,
	output Qb,
	output Qbn,
	output Qc,
	output Qcn
);

	reg r_Qb, r_Qbn, r_Qc, r_Qcn;

	always@(posedge clk) begin
		r_Qb	<= 	D;
		r_Qbn <= 	~D;
	
	end
	
	always@(negedge clk) begin
		r_Qc 	<= 	D;
		r_Qcn	<=	~D;
	
	end
	
	assign Qa 	= D & clk;
	assign Qan 	= ~Qa;
	assign Qb 	= r_Qb;
	assign Qbn  = r_Qbn;
	assign Qc		= r_Qc;
	assign Qcn 	= r_Qcn;

	
	
endmodule