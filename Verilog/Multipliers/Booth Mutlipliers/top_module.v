module top_module (
    input signed [3:0] multiplicand,
    input signed [3:0] multiplier,   
    output reg signed [7:0] product);
	 
    reg signed [7:0] A, S, P;
    reg [3:0] count;

    always @(multiplicand or multiplier) begin
        A = {multiplicand, 4'b0000};   
        S = {-multiplicand, 4'b0000};   
        P = {4'b0000, multiplier};      
        count = 4;                      

        while (count > 0) begin
            case (P[1:0])
                2'b01: P = P + A;        // Add A to P if last two bits are 01
                2'b10: P = P + S;        // Add S to P if last two bits are 10
                default: ;               // Do nothing if last two bits are 00 or 11
            endcase
            P = P >>> 1;                 // Arithmetic right shift P
            count = count - 1;           // Decrement count
        end

        product = P[7:0];                // Assign final product
    end
endmodule
