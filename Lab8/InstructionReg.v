
`default_nettype none

module InstructionReg #
(
	parameter N = 4
)
(
	input MainClock,
	input ClearInstr,
	input LatchInstr,
	input EnableInstr,
	input [N-1:0] Data,
	input [N-1:0] Instr,
	output wire [N-1:0] ToInstr,
	output [N-1:0] IB_BUS
);

	reg [3:0]r_ToInstr, r_instr, r_data;
	
	always@(posedge MainClock) begin
		if (ClearInstr) begin
			r_instr <= 4'b0000;
			r_data <= 4'd0;
		end	
		else if (LatchInstr) begin
			r_instr <= Instr;
			r_data 	<= Data;
		end
		
	end
	
	assign ToInstr	= r_instr;
	
	assign IB_BUS  	= (EnableInstr) ? r_data : 4'bZ;
	

	
endmodule

`default_nettype wire
