// PWM

module pwm (
    input logic clk,
    input logic [7:0] duty_cycle,
    output logic pwm_out
);

    logic [7:0] counter = 0;
    
    always_ff @(posedge clk) begin
        counter <= counter + 1;
    end
    
    assign pwm_out = (counter < duty_cycle);

endmodule