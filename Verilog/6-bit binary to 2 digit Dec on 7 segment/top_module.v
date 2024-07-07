
module top_module (
    input [5:0] SW,     
    output [6:0] HEX1,   // tens
    output [6:0] HEX0    // ones
);

    wire [3:0] bcd_ones; 
    wire [3:0] bcd_tens; 

   
    bin_to_bcd converter (.binary_in(SW),.bcd_ones(bcd_ones),.bcd_tens(bcd_tens) );

    
    seg7_decoder decoder1 (.binary_in(bcd_tens), .seg_out(HEX1) );

    
    seg7_decoder decoder0 (.binary_in(bcd_ones), .seg_out(HEX0) );

endmodule


module bin_to_bcd (input [5:0] binary_in,output reg [3:0] bcd_ones,output reg [3:0] bcd_tens 
);
    integer i;
    reg [15:0] bcd; 

    always @(*) begin
        bcd = 16'b0;         
        bcd[5:0] = binary_in; 

        
        for (i = 0; i < 6; i = i + 1) begin
           
            if (bcd[7:4] >= 5)
                bcd[7:4] = bcd[7:4] + 3;
            if (bcd[11:8] >= 5)
                bcd[11:8] = bcd[11:8] + 3;
            bcd = bcd << 1; // Shift the BCD register left by one bit
        end
        
        // final BCD values at output reg
        bcd_ones = bcd[7:4];
        bcd_tens = bcd[11:8];
    end
endmodule


module seg7_decoder (input [3:0] binary_in, output reg [6:0] seg_out );

    always @(*) begin
        
        case (binary_in)
            4'b0000: seg_out = 7'b1000000; 
            4'b0001: seg_out = 7'b1111001; 
            4'b0010: seg_out = 7'b0100100; 
            4'b0011: seg_out = 7'b0110000; 
            4'b0100: seg_out = 7'b0011001; 
            4'b0101: seg_out = 7'b0010010; 
            4'b0110: seg_out = 7'b0000010; 
            4'b0111: seg_out = 7'b1111000; 
            4'b1000: seg_out = 7'b0000000; 
            4'b1001: seg_out = 7'b0010000; 
            default: seg_out = 7'b1111111; 
        endcase
    end
endmodule
