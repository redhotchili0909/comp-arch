`include "memory.sv"

// MP3 top level module - Sine Wave Generator

module top(
    input logic     clk, 
    output logic    _9b,    // D0
    output logic    _6a,    // D1
    output logic    _4a,    // D2
    output logic    _2a,    // D3
    output logic    _0a,    // D4
    output logic    _5a,    // D5
    output logic    _3b,    // D6
    output logic    _49a,   // D7
    output logic    _45a,   // D8
    output logic    _48b    // D9
);
    // 9 bits for 512 positions of the sine wave
    logic [8:0] counter = 0;
    
    logic [6:0] mem_address;
    logic [9:0] mem_data;
    logic [9:0] output_data;
    
    always_ff @(posedge clk) begin
        counter <= counter + 1;
    end
    
    always_ff @(posedge clk) begin        
        case (counter[8:7])
            2'b00: mem_address <= counter[6:0];                  // Quarter 1
            2'b01: mem_address <= 7'd127 - counter[6:0];         // Quarter 2
            2'b10: mem_address <= counter[6:0];                  // Quarter 3
            2'b11: mem_address <= 7'd127 - counter[6:0];         // Quarter 4
        endcase
    end
    
    memory #(
        .INIT_FILE      ("quarter_sine.txt")
    ) sine_mem (
        .clk            (clk), 
        .read_address   (mem_address), 
        .read_data      (mem_data)
    );
    
    always_ff @(posedge clk) begin
        case (counter[8:7])
            2'b00: output_data <= mem_data;                     // Quarter 1: Same
            2'b01: output_data <= mem_data;                     // Quarter 2: Same
            2'b10: output_data <= 10'd1023 - mem_data;          // Quarter 3: Invert
            2'b11: output_data <= 10'd1023 - mem_data;          // Quarter 4: Invert
        endcase
    end
    
    assign {_48b, _45a, _49a, _3b, _5a, _0a, _2a, _4a, _6a, _9b} = output_data;
endmodule