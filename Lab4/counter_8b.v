
module counter_8b(
	input 			i_clk, 
	input 			i_enable,
	input 			i_clear,
	output 			[7:0] o_Q
);


	wire [6:0] w_and;

	//t_FF(input T,input clk,input clr,output Qa);
	t_FF tf0(i_enable, i_clk, i_clear, o_Q[0]);
	
	t_FF tf1(w_and[0], i_clk, i_clear, o_Q[1]);
	
	t_FF tf2(w_and[1], i_clk, i_clear, o_Q[2]);
	
	t_FF tf3(w_and[2], i_clk, i_clear, o_Q[3]);
	
	t_FF tf4(w_and[3], i_clk, i_clear, o_Q[4]);
	
	t_FF tf5(w_and[4], i_clk, i_clear, o_Q[5]);
	
	t_FF tf6(w_and[5], i_clk, i_clear, o_Q[6]);
	
	t_FF tf7(w_and[6], i_clk, i_clear, o_Q[7]);
	
	assign w_and[0] = o_Q[0] & i_enable;
	assign w_and[1] = o_Q[1] & w_and[0];
	assign w_and[2] = o_Q[2] & w_and[1];
	assign w_and[3] = o_Q[3] & w_and[2];
	assign w_and[4] = o_Q[4] & w_and[3];
	assign w_and[5] = o_Q[5] & w_and[4];
	assign w_and[6] = o_Q[6] & w_and[5];
	
	

endmodule