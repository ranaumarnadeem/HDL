module top_module (
    input wire Clock,
    input wire Reset_n,
    output reg [7:0] Q,
    output reg rollover
);

    parameter k = 20;
    parameter n = 8;

    always @(posedge Clock or negedge Reset_n) begin
        if (!Reset_n) begin
            Q <= 8'd0;
            rollover <= 1'b0;
        end else if (Q == k-1) begin
            Q <= 8'd0;
            rollover <= 1'b1;
        end else begin
            Q <= Q + 1'b1;
            rollover <= 1'b0;
        end
    end

endmodule
