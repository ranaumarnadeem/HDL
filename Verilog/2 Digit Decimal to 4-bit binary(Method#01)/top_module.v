module top_module (
    input [3:0] SW0, SW1, // X and Y inputs
    input SW8, // carry-in
    output [6:0] HEX5, HEX3, // 7-segment displays for inputs X and Y
    output [6:0] HEX1, HEX0, // 7-segment displays for result S1S0
    output [9:0] LEDR // LEDs for sum and carry-out, and error indication
);

    wire [3:0] X = SW0;
    wire [3:0] Y = SW1;
    wire cin = SW8;
    wire [4:0] sum; // 5-bit sum
    wire [3:0] S1, S0; // BCD digits for the sum
    wire c1, c2;
    
    // Check if inputs are valid BCD digits
    wire invalid_X = (X > 4'd9);
    wire invalid_Y = (Y > 4'd9);
    
    // 4-bit adder
    assign {c1, sum[3:0]} = X + Y + cin;
    
    // Handle the case where sum > 9
    assign c2 = (sum > 5'd9);
    assign sum[4] = c1 | c2;
    
    wire [3:0] adjusted_sum = c2 ? (sum - 5'd10) : sum;
    
    // Determine BCD digits for the sum
    assign S1 = sum[4];
    assign S0 = adjusted_sum;
    
    // Disp input X 
    seg7_decoder decoder_X (.binary_in(X), .seg_out(HEX5));
    // Disp input Y
    seg7_decoder decoder_Y (.binary_in(Y), .seg_out(HEX3));
    // Display sum digit s1
    seg7_decoder decoder_S1 (.binary_in(S1), .seg_out(HEX1));
    // Display sum digit s0 
    seg7_decoder decoder_S0 (.binary_in(S0), .seg_out(HEX0));
    
    // Error check for X and Y
    assign LEDR[9] = invalid_X | invalid_Y;
    
    assign LEDR[4:0] = sum;
    
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
                     7'b1111111;  
endmodule
