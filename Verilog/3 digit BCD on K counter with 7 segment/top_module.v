module top_module (
    input wire Clock,        // Clock signal input
    input wire Reset_n,      // Active-low reset signal
    output wire [6:0] HEX0,  // 7-segment display for the least significant digit
    output wire [6:0] HEX1,  // 7-segment display for the middle digit
    output wire [6:0] HEX2   // 7-segment display for the most significant digit
);

    wire one_sec_pulse;      // Pulse signal with a period of one second
    wire [3:0] Q0, Q1, Q2;   // BCD digits
    wire rollover;           // Rollover signal for the counters

    // Instance of clock_divider to generate one-second pulse
    clock_divider u_clk_div (
        .Clock(Clock),
        .Reset_n(Reset_n),
        .one_sec_pulse(one_sec_pulse)
    );

    // Instance of bcd_counter to count seconds in BCD format
    bcd_counter u_bcd_counter (
        .Clock(one_sec_pulse),
        .Reset_n(Reset_n),
        .Q0(Q0),
        .Q1(Q1),
        .Q2(Q2),
        .rollover(rollover)
    );

    // Instances of bcd_to_7segment to drive the 7-segment displays
    bcd_to_7segment u0 (
        .BCD(Q0),
        .SEG(HEX0)
    );

    bcd_to_7segment u1 (
        .BCD(Q1),
        .SEG(HEX1)
    );

    bcd_to_7segment u2 (
        .BCD(Q2),
        .SEG(HEX2)
    );
endmodule

module bcd_counter (
    input wire Clock,        // Clock signal input
    input wire Reset_n,      // Active-low reset signal
    output wire [3:0] Q0,    // Least significant BCD digit
    output wire [3:0] Q1,    // Middle BCD digit
    output wire [3:0] Q2,    // Most significant BCD digit
    output wire rollover     // Rollover signal for the counters
);

    wire rollover0, rollover1; // Rollover signals for each BCD digit

    // Instances of mod10_counter for each BCD digit
    mod10_counter u0 (
        .Clock(Clock),
        .Reset_n(Reset_n),
        .Q(Q0),
        .rollover(rollover0)
    );

    mod10_counter u1 (
        .Clock(rollover0),
        .Reset_n(Reset_n),
        .Q(Q1),
        .rollover(rollover1)
    );

    mod10_counter u2 (
        .Clock(rollover1),
        .Reset_n(Reset_n),
        .Q(Q2),
        .rollover(rollover)
    );
endmodule

module mod10_counter (
    input wire Clock,        // Clock signal input
    input wire Reset_n,      // Active-low reset signal
    output reg [3:0] Q,      // BCD digit output
    output reg rollover      // Rollover signal output
);

    parameter k = 10;        // Parameter for the modulus value

    always @(posedge Clock or negedge Reset_n) begin
        if (!Reset_n) begin
            Q <= 4'd0;       // Reset the counter to 0
            rollover <= 1'b0;// Reset the rollover signal
        end else if (Q == k-1) begin
            Q <= 4'd0;       // Reset the counter to 0 when it reaches k-1
            rollover <= 1'b1;// Set the rollover signal
        end else begin
            Q <= Q + 1'b1;   // Increment the counter
            rollover <= 1'b0;// Clear the rollover signal
        end
    end
endmodule

module clock_divider (
    input wire Clock,        // Clock signal input
    input wire Reset_n,      // Active-low reset signal
    output reg one_sec_pulse // One-second pulse signal output
);

    reg [25:0] count;        // Counter to divide the clock

    always @(posedge Clock or negedge Reset_n) begin
        if (!Reset_n) begin
            count <= 26'd0;    // Reset the counter
            one_sec_pulse <= 1'b0; // Clear the one-second pulse signal
        end else if (count == 26'd49_999_999) begin
            count <= 26'd0;    // Reset the counter when it reaches 49,999,999
            one_sec_pulse <= 1'b1; // Set the one-second pulse signal
        end else begin
            count <= count + 1'b1; // Increment the counter
            one_sec_pulse <= 1'b0; // Clear the one-second pulse signal
        end
    end
endmodule

module bcd_to_7segment (
    input [3:0] BCD,         // BCD digit input
    output reg [6:0] SEG     // 7-segment display output
);

    always @(*) begin
        case (BCD)
            4'b0000: SEG = 7'b1000000; // 0
            4'b0001: SEG = 7'b1111001; // 1
            4'b0010: SEG = 7'b0100100; // 2
            4'b0011: SEG = 7'b0110000; // 3
            4'b0100: SEG = 7'b0011001; // 4
            4'b0101: SEG = 7'b0010010; // 5
            4'b0110: SEG = 7'b0000010; // 6
            4'b0111: SEG = 7'b1111000; // 7
            4'b1000: SEG = 7'b0000000; // 8
            4'b1001: SEG = 7'b0010000; // 9
            default: SEG = 7'b1111111; // Error
        endcase
    end
endmodule
