module top (
    input wire clk,
    output wire[3:0] R,
    output wire[3:0] G,
    output wire[3:0] B,
    output wire HS,
    output wire VS
);

    wire pllClk;
    wire pllLocked;

    reg[1:0] resetSync = 2'b11;
    wire reset = resetSync[1];

    reg[9:0] x;
    reg[9:0] y;
    wire dataEnable;

    pll pll_instance(
        .clock_in(clk),
        .clock_out(pllClk),
        .locked(pllLocked)
    );


    always @(posedge pllClk or negedge pllLocked) begin
        if(!pllLocked)
            resetSync <= 2'b11;            
        else
            resetSync <= {resetSync[0], 1'b0};
    end

    vga_timing vga_timing_instance(
        .clk(pllClk),
        .reset(reset),
        .HS(HS),
        .VS(VS),
        .dataEnable(dataEnable),
        .x(x),
        .y(y)
    );

    pixel_gen pixel_gen_instance(
        .clk(pllClk),
        .reset(reset),
        .dataEnable(dataEnable),
        .x(x),
        .y(y),
        .R(R),
        .G(G),
        .B(B),
    );
endmodule


