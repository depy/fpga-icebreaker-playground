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

    pll pll_instance(
        .clock_in(clk),
        .clock_out(pllClk),
        .locked(pllLocked)
    );

    reg[1:0] resetSync = 2'b11;
    wire reset = resetSync[1];

    always @(posedge pllClk or negedge pllLocked) begin
        if(!pllLocked)
            resetSync <= 2'b11;            
        else
            resetSync <= {resetSync[0], 1'b0};
    end

    vga vga_instance(
        .clk(pllClk),
        .reset(reset),
        .R(R),
        .G(G),
        .B(B),
        .HS(HS),
        .VS(VS)
    );
endmodule


