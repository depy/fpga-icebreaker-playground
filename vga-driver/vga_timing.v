`timescale 1ns / 1ps

module vga_timing (
    input wire clk,
    input wire reset,
    output wire HS,
    output wire VS,
    output wire dataEnable,
    output reg[9:0] x,
    output reg[9:0] y
);

    localparam HTOTAL = 800;
    localparam HACTIVE = 640;
    localparam HFPORCH = 16;
    localparam HSYNC = 96;
    // localparam HBPORCH = 48;

    localparam VTOTAL = 525;
    localparam VACTIVE = 480;
    localparam VFPORCH = 10;
    localparam VSYNC = 2;
    // localparam VBPORCH = 25;

    assign dataEnable = (x < HACTIVE) && (y < VACTIVE);
    assign HS = !(x >= HACTIVE + HFPORCH && x < HACTIVE + HFPORCH + HSYNC);
    assign VS = !(y >= VACTIVE + VFPORCH && y < VACTIVE + VFPORCH + VSYNC);

    always @(posedge clk) begin
        if(reset) begin
            x <= 0;
            y <= 0;
        end else begin
            if(x == HTOTAL-1) begin
                x <= 0;
                if(y == VTOTAL-1) begin
                    y <= 0;
                end else begin
                    y <= y + 1;
                end
            end else x <= x + 1;
        end
    end
endmodule
