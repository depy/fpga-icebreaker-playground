module vga (
    input wire clk,
    input wire reset,
    output reg[3:0] R,
    output reg[3:0] G,
    output reg[3:0] B,
    output reg HS = 1'b1,
    output reg VS = 1'b1
);

    localparam HTOTAL = 800;
    localparam HACTIVE = 640;
    localparam HBLANK = 144;
    localparam HFPORCH = 8;
    localparam HSYNC = 96;
    localparam HBPORCH = 48;

    localparam VTOTAL = 525;
    localparam VACTIVE = 480;
    localparam VBLANK = 29;
    localparam VFPORCH = 2;
    localparam VSYNC = 2;
    localparam VBPORCH = 25;

    reg[10:0] hCounter = 0;
    reg[10:0] vCounter = 0;
    wire dataEnable;

    assign dataEnable = (hCounter < HACTIVE) && (vCounter < VACTIVE);

    always @(posedge clk) begin
        if(reset) begin
            hCounter = 0;
            vCounter = 0;
            HS <= 1'b1;
            VS <= 1'b1;
        end else begin
        if(dataEnable) begin
                if(hCounter < 320) begin
                    if(vCounter < 240) begin
                        R <= 4'b1111;
                        G <= 4'b0000;
                        B <= 4'b0000;
                    end else begin
                        R <= 4'b0000;
                        G <= 4'b1111;
                        B <= 4'b0000;
                    end
                end else begin
                    if(vCounter < 240) begin
                        R <= 4'b0000;
                        G <= 4'b0000;
                        B <= 4'b1111;
                    end else begin
                        R <= 4'b0000;
                        G <= 4'b1111;
                        B <= 4'b1111;
                    end
                end
            end else begin
                        R <= 4'b0000;
                        G <= 4'b0000;
                        B <= 4'b0000;
            end

            if(hCounter >= HTOTAL-HSYNC-HBPORCH && hCounter < HTOTAL-HBPORCH) HS <= 0;
            else HS <= 1;

            if(vCounter >= VTOTAL-VSYNC-VBPORCH && vCounter < VTOTAL-VBPORCH) VS <= 0;
            else VS <= 1;

            if(hCounter == HTOTAL-1) begin
                hCounter <= 0;
                if(vCounter == VTOTAL-1) begin
                    vCounter <= 0;
                end else begin
                    vCounter <= vCounter + 1;
                end
            end else hCounter <= hCounter + 1;
        end
    end
endmodule
