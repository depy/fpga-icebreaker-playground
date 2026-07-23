`timescale 1ns / 1ps

module pixel_gen (
    input wire clk,
    input wire reset,
    input wire dataEnable,
    input wire[9:0] x,
    input wire[9:0] y,
    output reg[3:0] R,
    output reg[3:0] G,
    output reg[3:0] B
);

    always @(posedge clk) begin
        if(reset || !dataEnable) begin
            R <= 4'b0000;
            G <= 4'b0000;
            B <= 4'b0000;
        end else begin
            if(x < 320) begin
                if(y < 240) begin
                    R <= 4'b1111;
                    G <= 4'b0000;
                    B <= 4'b0000;
                end else begin
                    R <= 4'b0000;
                    G <= 4'b1111;
                    B <= 4'b0000;
                end
            end else begin
                if(y < 240) begin
                    R <= 4'b0000;
                    G <= 4'b0000;
                    B <= 4'b1111;
                end else begin
                    R <= 4'b0000;
                    G <= 4'b1111;
                    B <= 4'b1111;
                end
            end
        end
    end

endmodule
