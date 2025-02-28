module rgb_led_controller#(
    parameter CLK_FREQ = 12_000_000
) (
    input  logic clk,
    output logic red_led,
    output logic green_led,
    output logic blue_led
);
    
    localparam TOTAL_STEPS = 360;
    localparam STEP_SIZE   = 60;
    localparam CYCLES_PER_STEP = CLK_FREQ / TOTAL_STEPS;
    
    logic [$clog2(CYCLES_PER_STEP)-1:0] cycle_counter = 0;
    logic [8:0]  step_counter  = 0;  // 0 to 359
    
    // PWM values for RGB
    logic [7:0] red_value   = 8'd255;
    logic [7:0] green_value = 8'd0;
    logic [7:0] blue_value  = 8'd0;
    
    // Step counter logic
    always_ff @(posedge clk) begin
        if (cycle_counter >= CYCLES_PER_STEP - 1) begin
            cycle_counter <= 0;
            if (step_counter >= TOTAL_STEPS - 1)
                step_counter <= 0;
            else
                step_counter <= step_counter + 1;
        end 
        else begin
            cycle_counter <= cycle_counter + 1;
        end
    end
    
    always_comb begin
        case (step_counter / STEP_SIZE)
            // Segment 0: 0 to 60 degrees
            // Red = 100%, Blue = 0%, Green ramps 0% to 100%
            0: begin
                red_value   = 8'd255;
                blue_value  = 8'd0;
                green_value = ((step_counter % STEP_SIZE) * 255) / STEP_SIZE;
            end
            
            // Segment 1: 60 to 120 degrees
            // Green = 100%, Blue = 0%, Red ramps 100% down to 0%
            1: begin
                green_value = 8'd255;
                blue_value  = 8'd0;
                red_value   = 8'd255 - ((step_counter % STEP_SIZE) * 255) / STEP_SIZE;
            end
            
            // Segment 2: 120 to 180 degrees
            // Green = 100%, Red = 0%, Blue ramps 0% to 100%
            2: begin
                green_value = 8'd255;
                red_value   = 8'd0;
                blue_value  = ((step_counter % STEP_SIZE) * 255) / STEP_SIZE;
            end
            
            // Segment 3: 180 to 240 degrees
            // Blue = 100%, Red = 0%, Green ramps 100% down to 0%
            3: begin
                blue_value  = 8'd255;
                red_value   = 8'd0;
                green_value = 8'd255 - ((step_counter % STEP_SIZE) * 255) / STEP_SIZE;
            end
            
            // Segment 4: 240 to 300 degrees
            // Blue = 100%, Green = 0%, Red ramps 0% to 100%
            4: begin
                blue_value  = 8'd255;
                green_value = 8'd0;
                red_value   = ((step_counter % STEP_SIZE) * 255) / STEP_SIZE;
            end
            
            // Segment 5: 300 to 360 degrees
            // Red = 100%, Green = 0%, Blue ramps 100% down to 0%
            5: begin
                red_value   = 8'd255;
                green_value = 8'd0;
                blue_value  = 8'd255 - ((step_counter % STEP_SIZE) * 255) / STEP_SIZE;
            end
            
            default: begin
                red_value   = 8'd255;
                green_value = 8'd0;
                blue_value  = 8'd0;
            end
        endcase
    end
    
    pwm red_pwm (
        .clk(clk),
        .duty_cycle(red_value),
        .pwm_out(red_led)
    );
    
    pwm green_pwm (
        .clk(clk),
        .duty_cycle(green_value),
        .pwm_out(green_led)
    );
    
    pwm blue_pwm (
        .clk(clk),
        .duty_cycle(blue_value),
        .pwm_out(blue_led)
    );

endmodule
