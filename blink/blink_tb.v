`timescale 1ns/1ps
module blink_tb;
    reg clk = 0;
    wire led;

    // Shrink the counter idea by just clocking fast and watching a low bit.
    blink dut (.clk(clk), .led(led));

    always #41.667 clk = ~clk;   // 12 MHz -> period 83.33 ns

    initial begin
        $dumpfile("blink.vcd");
        $dumpvars(0, blink_tb);
        #2_000_000;               // run 2 ms of sim time
        $finish;
    end
endmodule
