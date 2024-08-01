module top_module (
    input wire [7:0] SW,       
    input wire KEY0,           
    input wire KEY1,           //clock input
    input wire add_sub,        // Control signal for add/subtract
    output reg [7:0] LEDR,     // sum
    output reg LEDR8,          // carry 
    output reg LEDR9,          // overflow 
    output wire [6:0] HEX3,    
    output wire [6:0] HEX2,  
    output wire [6:0] HEX1,   
    output wire [6:0] HEX0     
);

    reg [7:0] A;                
    reg [7:0] S;                
    wire [8:0] result;         
    wire carry;                 
    wire overflow;             

    // Add/Subtract operation
    assign {carry, result} = add_sub ? {1'b0, S} - {1'b0, SW} : {1'b0, S} + {1'b0, SW};
    assign overflow = add_sub ? ((S[7] != SW[7]) && (result[7] != S[7])) : ((S[7] == SW[7]) && (result[7] != S[7]));

    
    always @(posedge KEY1 or negedge KEY0) begin
        if (!KEY0) begin
            S <= 8'b0;
            LEDR <= 8'b0;
            LEDR8 <= 1'b0;
            LEDR9 <= 1'b0;
        end else begin
            S <= result[7:0];
            LEDR <= result[7:0];
            LEDR8 <= carry;
            LEDR9 <= overflow;
        end
    end

    
    hex_display hex3_inst(.hex_digit(S[7:4]), .segments(HEX3));
    hex_display hex2_inst(.hex_digit(S[3:0]), .segments(HEX2));
    hex_display hex1_inst(.hex_digit(S[7:4]), .segments(HEX1));
    hex_display hex0_inst(.hex_digit(S[3:0]), .segments(HEX0));

endmodule


module hex_display (
    input wire [3:0] hex_digit,
    output reg [6:0] segments
);
    always @(*) begin
        case (hex_digit)
            4'h0: segments = 7'b1000000;
            4'h1: segments = 7'b1111001;
            4'h2: segments = 7'b0100100;
            4'h3: segments = 7'b0110000;
            4'h4: segments = 7'b0011001;
            4'h5: segments = 7'b0010010;
            4'h6: segments = 7'b0000010;
            4'h7: segments = 7'b1111000;
            4'h8: segments = 7'b0000000;
            4'h9: segments = 7'b0010000;
            4'hA: segments = 7'b0001000;
            4'hB: segments = 7'b0000011;
            4'hC: segments = 7'b1000110;
            4'hD: segments = 7'b0100001;
            4'hE: segments = 7'b0000110;
            4'hF: segments = 7'b0001110;
            default: segments = 7'b1111111;
        endcase
    end
endmodule
