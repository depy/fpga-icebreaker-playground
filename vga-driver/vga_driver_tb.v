`timescale 1ns / 1ps

module SB_PLL40_PAD #(
    parameter FEEDBACK_PATH = "SIMPLE",
    parameter DIVR = 4'b0000,
    parameter DIVF = 7'b0000000,
    parameter DIVQ = 3'b000,
    parameter FILTER_RANGE = 3'b000
) (
    input  PACKAGEPIN,
    output PLLOUTCORE,
    output LOCK,
    input  RESETB,
    input  BYPASS
);
    assign PLLOUTCORE = PACKAGEPIN;

    reg lock_r = 0;
    initial #100 lock_r = 1;   // lock asserts shortly after start
    assign LOCK = lock_r & RESETB;
endmodule

module vga_driver_test;
    reg clk = 0;

    wire[3:0] R;
    wire[3:0] G;
    wire[3:0] B;
    wire HS;
    wire VS;

    vga_driver uut(
        .clk(clk),
        .R(R),
        .G(G),
        .B(B),
        .HS(HS),
        .VS(VS)
    );

    always #20 clk = ~clk;

    initial begin
        $dumpfile("vga_tb.fst");
        $dumpvars(0, vga_driver_test);
    end

    initial begin
        #(40 * 800 * 525 * 2);
        $finish;
    end
endmodule
