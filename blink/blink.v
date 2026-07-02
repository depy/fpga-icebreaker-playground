// Blink an LED on the iCEBreaker (iCE40UP5K).
// 12 MHz clock -> counter -> top bit drives the LED.

module blink (
    input  wire clk,      // 12 MHz oscillator
    output wire led        // active-low green LED (LEDG_N)
);
    reg [23:0] counter = 0;

    always @(posedge clk)
        counter <= counter + 1'b1;

    // ~12e6 / 2^24 ≈ 0.7 Hz toggle. Active-low LED, so invert.
    assign led = ~counter[23];
endmodule
