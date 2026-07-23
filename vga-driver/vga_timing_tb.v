`timescale 1ns / 1ps

module vga_timing_test;
    reg clk = 0;
    reg reset = 1;
    wire[9:0] x;
    wire[9:0] y;
    wire dataEnable;
    wire HS;
    wire VS;

    vga_timing uut(
        .clk(clk),
        .reset(reset),
        .HS(HS),
        .VS(VS),
        .dataEnable(dataEnable),
        .x(x),
        .y(y)
    );

    always #20 clk = ~clk;

    initial begin
        $dumpfile("vga_timing_tb.fst");
        $dumpvars(0, vga_timing_test);
    end

    initial begin
        reset = 1;
        #200 reset = 0;
        #(40 * 800 * 525 * 2);
        $finish;
    end
endmodule
