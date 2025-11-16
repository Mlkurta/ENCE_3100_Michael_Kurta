`default_nettype none
module stepper_28byj_fullstep (
    input  wire i_clk,
    input  wire i_step_pulse,  // one-clock pulse from NCO
    input  wire i_dir,         // 0=CCW, 1=CW
    output reg  o_A,           // to ULN2003 IN1
    output reg  o_B,           // to ULN2003 IN2
    output reg  o_C,           // to ULN2003 IN3
    output reg  o_D            // to ULN2003 IN4
);
    // 4-state full-step sequence (A,C then B,C then B,D then A,D)
    // Matches common 28BYJ-48 driver boards; swap wires if direction looks wrong.
    reg [1:0] idx;

    always @(posedge i_clk) begin
        if (i_step_pulse) begin
            idx <= i_dir ? (idx + 2'd1) : (idx - 2'd1);
        end
    end

    always @(*) begin
        case (idx)
          2'd0: {o_A,o_B,o_C,o_D} = 4'b1001; // A & D
          2'd1: {o_A,o_B,o_C,o_D} = 4'b1100; // A & B
          2'd2: {o_A,o_B,o_C,o_D} = 4'b0110; // B & C
          2'd3: {o_A,o_B,o_C,o_D} = 4'b0011; // C & D
        endcase
    end
endmodule
`default_nettype wire