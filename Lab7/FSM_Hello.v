module FSM_Hello(
    input               i_clk,
    input               i_reset,
    input       [7:0]   i_data,     // raw UART byte
    input               i_ready,    // 1-cycle strobe when i_data/i_decoded valid
    input               i_eoc,      // timer expired (3s)
    output reg          o_convert,  // 1-cycle pulse when first 'h' is seen
    output reg  [7:0]   o_hex       // what to show on 7-seg
);

    // State encoding
    localparam [2:0] S  = 3'b000,   // idle / normal: show last pressed key
                     H  = 3'b001,
                     E  = 3'b011,
                     L  = 3'b010,
                     L2 = 3'b110,
                     O  = 3'b111;

    reg [2:0] state, next_state;

    // Hold the display value we want to show
    reg [7:0] disp_q, disp_d;

    // Convenient compares for ASCII
    wire is_h = (i_data == 8'h68);  // 'h'
    wire is_e = (i_data == 8'h65);  // 'e'
    wire is_l = (i_data == 8'h6C);  // 'l'
    wire is_o = (i_data == 8'h6F);  // 'o'

    //========================
    // 1) Next-state logic
    //========================
    always @(*) begin
        next_state = state; // default: hold

        case (state)
            S:   if (i_ready && is_h) next_state = H;          // start sequence on 'h'
                 else                 next_state = S;

            H:   if (i_ready && is_e) next_state = E;          // expect 'e'
                 else                 next_state = H;

            E:   if (i_ready && is_l) next_state = L;          // expect first 'l'
                 else                 next_state = E;

            L:   if (i_ready && is_l) next_state = L2;         // expect second 'l'
                 else                 next_state = L;

            L2:  if (i_ready && is_o) next_state = O;          // expect 'o'
                 else                 next_state = L2;

            O:   if (i_eoc)           next_state = S;          // timeout returns to idle
                 else                 next_state = O;

        endcase
    end

    always @(*) begin
        disp_d = disp_q; // default hold


				// While idle (S), show last pressed key by latching on every valid byte
				if (state == S) begin
						if (i_ready) disp_d = i_data;
				end

				// On transitions into sequence states, capture the pattern once
				// S -> 
				if (state == S  && next_state == H  && i_ready) disp_d = 8'h68;
				// H -> E
				if (state == H  && next_state == E  && i_ready) disp_d = 8'h65;
				// E -> L
				if (state == E  && next_state == L  && i_ready) disp_d = 8'h6C;
				// L -> L2
				if (state == L  && next_state == L2 && i_ready) disp_d = 8'h6C;
				// L2 -> O
				if (state == L2 && next_state == O  && i_ready) disp_d = 8'h6F;

    end

    //========================
    // 3) Sequential: state, display reg, and convert pulse
    //========================
    always @(posedge i_clk) begin
        if (i_reset || i_eoc) begin
            state     <= S;
            disp_q    <= 8'h00;
            o_convert <= 1'b0;
        end else begin
            state  <= next_state;
            disp_q <= disp_d;

            // 1-cycle pulse on first 'h' (S -> H)
            o_convert <= (state == S) && (next_state == H);
        end
    end

    // Drive the output display
    always @(posedge i_clk) begin
        o_hex <= disp_q;
    end

endmodule