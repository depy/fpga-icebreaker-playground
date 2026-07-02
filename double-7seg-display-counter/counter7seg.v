module counter7seg #(
    parameter CLK_DIV_MAX = 5999999
) (
    input  wire CLK,
    output wire seg_sel,
    output reg [6:0] seg
);
    reg [24:0] clk_div = 0;
    reg [7:0] counter = 0;
    wire [3:0] digitL = counter[3:0];
    wire [3:0] digitH = counter[7:4];


    reg [16:0] refresh = 0;

    always @(posedge CLK) begin
    refresh <= refresh + 1'b1;
    clk_div <= clk_div + 1'b1;
    if (clk_div == CLK_DIV_MAX) begin
        clk_div <= 1'b0;
            counter <= counter + 1'b1;
    end
    end

    assign seg_sel = refresh[16];
    wire [3:0] active = seg_sel ? digitL : digitH;

    seg7decoder dec (
    .value (active),
    .seg (seg)
    );

endmodule

module seg7decoder(
    input wire [3:0] value,
    output reg [6:0] seg);

    always @(*) begin
        case(value)
            4'h0: seg = ~7'b0111111;
            4'h1: seg = ~7'b0000110;
            4'h2: seg = ~7'b1011011;
            4'h3: seg = ~7'b1001111;
            4'h4: seg = ~7'b1100110;
            4'h5: seg = ~7'b1101101;
            4'h6: seg = ~7'b1111101;
            4'h7: seg = ~7'b0000111;
            4'h8: seg = ~7'b1111111;
            4'h9: seg = ~7'b1101111;
            4'hA: seg = ~7'b1110111;
            4'hB: seg = ~7'b1111100;
            4'hC: seg = ~7'b0111001;
            4'hD: seg = ~7'b1011110;
            4'hE: seg = ~7'b1111001;
            4'hF: seg = ~7'b1110001;
            default: seg = ~7'b0000000;
        endcase
    end
endmodule
