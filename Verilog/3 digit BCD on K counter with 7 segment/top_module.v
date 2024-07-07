module top_module (
    input wire Clock,
    input wire Reset_n,
    output wire [6:0] HEX0,
    output wire [6:0] HEX1,
    output wire [6:0] HEX2
);

    wire one_sec_pulse;
    wire [3:0] Q0, Q1, Q2;
    wire rollover;

    clock_divider u_clk_div (
        .Clock(Clock),
        .Reset_n(Reset_n),
        .one_sec_pulse(one_sec_pulse)
    );

    bcd_counter u_bcd_counter (
        .Clock(one_sec_pulse),
        .Reset_n(Reset_n),
        .Q0(Q0),
        .Q1(Q1),
        .Q2(Q2),
        .rollover(rollover)
    );

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
    input wire Clock,
    input wire Reset_n,
    output wire [3:0] Q0,
    output wire [3:0] Q1,
    output wire [3:0] Q2,
    output wire rollover
);

    wire rollover0, rollover1;

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
    input wire Clock,
    input wire Reset_n,
    output reg [3:0] Q,
    output reg rollover
);

    parameter k = 10;

    always @(posedge Clock or negedge Reset_n) begin
        if (!Reset_n) begin
            Q <= 4'd0;
            rollover <= 1'b0;
        end else if (Q == k-1) begin
            Q <= 4'd0;
            rollover <= 1'b1;
        end else begin
            Q <= Q + 1'b1;
            rollover <= 1'b0;
        end
    end
endmodule


module clock_divider (
    input wire Clock,
    input wire Reset_n,
    output reg one_sec_pulse
);

    reg [25:0] count;

    always @(posedge Clock or negedge Reset_n) begin
        if (!Reset_n) begin
            count <= 26'd0;
            one_sec_pulse <= 1'b0;
        end else if (count == 26'd49_999_999) begin
            count <= 26'd0;
            one_sec_pulse <= 1'b1;
        end else begin
            count <= count + 1'b1;
            one_sec_pulse <= 1'b0;
        end
    end
endmodule
