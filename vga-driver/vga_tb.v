`timescale 1ns / 1ps

module vga_test;
    reg clk = 0;
    reg reset = 1;
    wire[3:0] R;
    wire[3:0] G;
    wire[3:0] B;
    wire HS;
    wire VS;

    vga uut(
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
        $dumpvars(0, vga_test);
    end

    initial begin
        reset = 1;
        #200 reset = 0;
        #(40 * 800 * 525 * 2);
        $finish;
    end
endmodule
