module top_module (
    input [3:0] a,
    input [3:0] b,
    output [7:0] product
);
    wire [3:0] p0, p1, p2, p3;
    wire [7:0] sum1, sum2, sum3;

    assign p0 = a & {4{b[0]}};
    assign p1 = a & {4{b[1]}};
    assign p2 = a & {4{b[2]}};
    assign p3 = a & {4{b[3]}};

    assign sum1 = {p1, 1'b0} + {4'b0, p0};
    assign sum2 = {p2, 2'b0} + sum1;
    assign sum3 = {p3, 3'b0} + sum2;

    assign product = sum3;
endmodule
