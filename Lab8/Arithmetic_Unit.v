
`default_nettype none

module Arithmetic_Unit #
(
	parameter N = 4
)
(
	input EnableALU,
	input AddSub,
	input [N-1:0] A,
	input [N-1:0] B,
	output reg Carry,
	output reg [N-1:0] IB_ALU
);

	always@(*) begin
	
		if(EnableALU)
			if(AddSub)	begin
				{Carry, IB_ALU} = B - A;
			
			end else 
				{Carry, IB_ALU} = B + A;
				
		else
			{Carry, IB_ALU} = {N{1'bz}};
			
	end	
				
			
	
	
endmodule

`default_nettype wire
