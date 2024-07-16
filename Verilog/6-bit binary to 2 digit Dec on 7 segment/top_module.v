module top_module (
    input [5:0] SW,       // input
    output [6:0] HEX1,    // tens 
    output [6:0] HEX0     // ones 
);

    wire [3:0] bcd_ones;  // BCD representation of ones place
    wire [3:0] bcd_tens;  // BCD representation of tens place

    
    bin_to_bcd converter (
        .binary_in(SW),
        .bcd_ones(bcd_ones),
        .bcd_tens(bcd_tens)
    );

    // Instantiate the 7-segment decoder for tens place
    seg7_decoder decoder1 (
        .binary_in(bcd_tens),
        .seg_out(HEX1)
    );

    // Instantiate the 7-segment decoder for ones place
    seg7_decoder decoder0 (
        .binary_in(bcd_ones),
        .seg_out(HEX0)
    );

endmodule

module bin_to_bcd (
    input [5:0] binary_in,
    output reg [3:0] bcd_ones,
    output reg [3:0] bcd_tens
);
    integer i;
    reg [15:0] bcd;  // Intermediate BCD representation

    always @(*) begin
        bcd = 16'b0;           // Initialize BCD register
        bcd[5:0] = binary_in;  // Load binary input into BCD register

        // Shift-and-add-3 algorithm for BCD conversion
        for (i = 0; i < 6; i = i + 1) begin
            // Check and adjust tens place
            if (bcd[7:4] >= 5)
                bcd[7:4] = bcd[7:4] + 3;
            // Check and adjust hundreds place (not used in this case)
            if (bcd[11:8] >= 5)
                bcd[11:8] = bcd[11:8] + 3;
            // Shift left by one bit
            bcd = bcd << 1;
        end
        
        // Assign final BCD values to output registers
        bcd_ones = bcd[7:4];
        bcd_tens = bcd[11:8];
    end
endmodule

module seg7_decoder (
    input [3:0] binary_in,
    output reg [6:0] seg_out
);

    always @(*) begin
        // Convert BCD digit to 7-segment display pattern
        case (binary_in)
            4'b0000: seg_out = 7'b1000000; // Display 0
            4'b0001: seg_out = 7'b1111001; // Display 1
            4'b0010: seg_out = 7'b0100100; // Display 2
            4'b0011: seg_out = 7'b0110000; // Display 3
            4'b0100: seg_out = 7'b0011001; // Display 4
            4'b0101: seg_out = 7'b0010010; // Display 5
            4'b0110: seg_out = 7'b0000010; // Display 6
            4'b0111: seg_out = 7'b1111000; // Display 7
            4'b1000: seg_out = 7'b0000000; // Display 8
            4'b1001: seg_out = 7'b0010000; // Display 9
            default: seg_out = 7'b1111111; // Display nothing for invalid input
        endcase
    end
endmodule
