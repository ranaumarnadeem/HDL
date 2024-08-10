module johnson_counter (
    input wire clk,       
    input wire rst_n,      
    output reg [3:0] q     
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b0000;  
        
		  end else begin
		  
            q <= {~q[0], q[3:1]};  // Shift left and feedback inverted bit
        end
    end

endmodule
