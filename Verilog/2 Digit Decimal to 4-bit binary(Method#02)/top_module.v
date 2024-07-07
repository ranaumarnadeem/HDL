module top_module (
    input [3:0] SW0, SW1,
    input SW8,
    output [6:0] HEX5, HEX3,
    output [6:0] HEX1, HEX0,
    output [9:0] LEDR
);

    wire [3:0] A = SW0;
    wire [3:0] B = SW1;
    wire cin = SW8;
    wire [4:0] T0;
    reg [3:0] S0;
    reg c1;

    assign T0 = A + B + cin;

    always @(*) begin
        if (T0 > 5'd9) begin
            S0 = T0 - 4'd10;
            c1 = 1;
        end else begin
            S0 = T0;
            c1 = 0;
        end
    end

    assign LEDR[9] = (A > 4'd9) | (B > 4'd9);
    assign LEDR[4:0] = {c1, S0};

    seg7_decoder decoder_A (.binary_in(A), .seg_out(HEX5));
    seg7_decoder decoder_B (.binary_in(B), .seg_out(HEX3));
    seg7_decoder decoder_S1 (.binary_in({3'b0, c1}), .seg_out(HEX1));
    seg7_decoder decoder_S0 (.binary_in(S0), .seg_out(HEX0));

endmodule

module seg7_decoder (
    input [3:0] binary_in,
    output [6:0] seg_out
);

    assign seg_out = (binary_in == 4'b0000) ? 7'b1000000 :  
                     (binary_in == 4'b0001) ? 7'b1111001 :  
                     (binary_in == 4'b0010) ? 7'b0100100 :  
                     (binary_in == 4'b0011) ? 7'b0110000 :  
                     (binary_in == 4'b0100) ? 7'b0011001 :  
                     (binary_in == 4'b0101) ? 7'b0010010 :  
                     (binary_in == 4'b0110) ? 7'b0000010 :  
                     (binary_in == 4'b0111) ? 7'b1111000 :  
                     (binary_in == 4'b1000) ? 7'b0000000 :  
                     (binary_in == 4'b1001) ? 7'b0010000 :  
                     7'b1111111;  
endmodule
