module fsm #(
    parameter ONE_SEC = 12_000_000    // 12M cycles = 1 second
)(
    input logic clk,
    output logic red,
    output logic green,
    output logic blue
);

    // Define states for each color
    typedef enum logic [2:0] {
        RED     = 3'b100,  // Red ON
        YELLOW  = 3'b110,  // Red + Green ON
        GREEN   = 3'b010,  // Green ON
        CYAN    = 3'b011,  // Green + Blue ON
        BLUE    = 3'b001,  // Blue ON
        MAGENTA = 3'b101   // Red + Blue ON
    } state_t;

    state_t current_state = RED;
    state_t next_state;

    logic [$clog2(ONE_SEC) - 1:0] count = 0;

    // State transition every 1 second
    always_ff @(posedge clk) begin
        if (count == ONE_SEC - 1) begin
            count <= 0;
            current_state <= next_state;
        end else begin
            count <= count + 1;
        end
    end

    // Define next state logic
    always_comb begin
        case (current_state)
            RED:     next_state = YELLOW;
            YELLOW:  next_state = GREEN;
            GREEN:   next_state = CYAN;
            CYAN:    next_state = BLUE;
            BLUE:    next_state = MAGENTA;
            MAGENTA: next_state = RED;
            default: next_state = RED;
        endcase
    end

    // Define RGB output values
    always_comb begin
        {red, green, blue} = current_state;
    end

endmodule
