module ring_counter (
    input wire clk,     
    input wire rst_n,     // Active-low
    output reg [3:0] q    
);

   
    initial begin
        q = 4'b1000;     
    end

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b1000; // Reset for iniitial state
        end else begin
            // rotates bits to left
            q <= {q[2:0], q[3]};
        end
    end

endmodule
