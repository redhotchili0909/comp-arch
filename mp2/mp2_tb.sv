`timescale 1ns / 1ps
`include "top.sv"

module top_tb;

    logic clk;
    logic RGB_R;
    logic RGB_G;
    logic RGB_B;
    
    top test (
        .clk(clk),
        .RGB_R(RGB_R),
        .RGB_G(RGB_G),
        .RGB_B(RGB_B)
    );
    
    initial begin
        clk = 0;
        forever #41.667 clk = ~clk;
    end
    
    initial begin
        $dumpfile("mp2_tb.vcd");
        $dumpvars(0, top_tb);
    end
    
    initial begin
        #1_000_000_000;
        $display("Simulation complete");
        $finish;
    end
    
    initial begin
        $monitor("Time: %t, RGB_R: %b, RGB_G: %b, RGB_B: %b", 
                 $time, RGB_R, RGB_G, RGB_B);
    end

endmodule
