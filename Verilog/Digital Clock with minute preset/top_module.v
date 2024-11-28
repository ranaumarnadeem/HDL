module top_module (
    input CLOCK_50,          
    input [7:0] SW,          
    input KEY0,              // Stop/Start
    input KEY1,              // Preset
    output [6:0] HEX0,       // Hundredths of a second (ones)
    output [6:0] HEX1,       // Hundredths of a second (tens)
    output [6:0] HEX2,       // Seconds (ones)
    output [6:0] HEX3,       // Seconds (tens)
    output [6:0] HEX4,       // Minutes (ones)
    output [6:0] HEX5        // Minutes (tens)
);

reg [19:0] clk_div;
reg clk_100Hz;
reg [6:0] hundredths;
reg [5:0] seconds;
reg [5:0] minutes;
reg running;

// Clock divider to generate 100 Hz clock
always @(posedge CLOCK_50) begin
    if (clk_div == 20'd499999) begin
        clk_div <= 20'd0;
        clk_100Hz <= ~clk_100Hz;
    end else begin
        clk_div <= clk_div + 1;
    end
end

// start/stop logic
always @(posedge CLOCK_50) begin
    if (~KEY0) begin
        running <= 0;
    end else begin
        running <= 1;
    end
end

// Hundredths of a second counter and preset logic for minutes
always @(posedge clk_100Hz or negedge KEY1) begin
    if (~KEY1) begin
        // Preset minutes
        minutes <= SW[5:0];
    end else if (running) begin
        // Increment counters
        if (hundredths == 7'd99) begin
            hundredths <= 7'd0;
            if (seconds == 6'd59) begin
                seconds <= 6'd0;
                if (minutes == 6'd59) begin
                    minutes <= 6'd0;
                end else begin
                    minutes <= minutes + 1;
                end
            end else begin
                seconds <= seconds + 1;
            end
        end else begin
            hundredths <= hundredths + 1;
        end
    end
end

// 7-segment display conversion
function [6:0] seg7;
    input [3:0] digit;
    case (digit)
        4'h0: seg7 = 7'b1000000;
        4'h1: seg7 = 7'b1111001;
        4'h2: seg7 = 7'b0100100;
        4'h3: seg7 = 7'b0110000;
        4'h4: seg7 = 7'b0011001;
        4'h5: seg7 = 7'b0010010;
        4'h6: seg7 = 7'b0000010;
        4'h7: seg7 = 7'b1111000;
        4'h8: seg7 = 7'b0000000;
        4'h9: seg7 = 7'b0010000;
        default: seg7 = 7'b1111111; // Blank display for invalid input
    endcase
endfunction

assign HEX0 = seg7(hundredths % 10);
assign HEX1 = seg7(hundredths / 10);
assign HEX2 = seg7(seconds % 10);
assign HEX3 = seg7(seconds / 10);
assign HEX4 = seg7(minutes % 10);
assign HEX5 = seg7(minutes / 10);

endmodule
