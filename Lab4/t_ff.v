
module t_FF(
	input 			i_T,
	input 			i_clk,
	input 			i_clr,
	output reg	o_Qa

);
	
	
	wire w_d, w_Qa, w_Qb;
	
	//d_ff(input clk,input D, output Qa, output Qb);
	d_ff ff0(i_clk,w_d, w_Qa, w_Qb);
	
	assign w_d = (i_T & ~w_Qa) | (!i_T & w_Qa);
	
	always@(posedge i_clk) begin
		
		if(!i_clr) begin
			o_Qa <= 1'b0;
			
		end else if(i_T) begin
			o_Qa <= ~o_Qa;
		end else begin
			o_Qa <= w_Qa;
		
		end
	end
	

endmodule