module top_module (
    input [3:0] SW,
    output [6:0] HEX1,
    output [6:0] HEX0
);

    wire [3:0] V = SW;
    wire z;
    wire [3:0] A;
    wire [3:0] d0;

    // Comparator: z = 1 if V > 9
    assign z = (V[3] & (V[2] | V[1]));

    // Circuit A: A = V - 10 if V > 9
    assign A = V - 4'b1010;

    // Multiplexer: d0 = A if z == 1, else V
    assign d0 = z ? A : V;

    // d1 = 1 if V > 9, else 0
    wire [3:0] d1 = {3'b0, z};

    seg7_decoder decoder1 (.binary_in(d1), .seg_out(HEX1));
    seg7_decoder decoder0 (.binary_in(d0), .seg_out(HEX0));

endmodule

module seg7_decoder (
    input [3:0] binary_in,
    output [6:0] seg_out
);

    assign seg_out = (binary_in == 4'b0000) ? 7'b1000000 :  // 0
                     (binary_in == 4'b0001) ? 7'b1111001 :  // 1
                     (binary_in == 4'b0010) ? 7'b0100100 :  // 2
                     (binary_in == 4'b0011) ? 7'b0110000 :  // 3
                     (binary_in == 4'b0100) ? 7'b0011001 :  // 4
                     (binary_in == 4'b0101) ? 7'b0010010 :  // 5
                     (binary_in == 4'b0110) ? 7'b0000010 :  // 6
                     (binary_in == 4'b0111) ? 7'b1111000 :  // 7
                     (binary_in == 4'b1000) ? 7'b0000000 :  // 8
                     (binary_in == 4'b1001) ? 7'b0010000 :  // 9
                     7'b1111111;  // Default case for undefined inputs
endmodule
