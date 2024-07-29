module top_module (
    input [3:0] a,
    input [3:0] b,
    output [7:0] product
);
    wire [3:0] pp [3:0];  // Partial products
    wire [7:0] sum1, sum2, sum3, carry1, carry2, carry3;

    // Generate partial products
    genvar i, j;
    generate
        for (i = 0; i < 4; i = i + 1) begin: gen_pp
            for (j = 0; j < 4; j = j + 1) begin: gen_pp_bits
                assign pp[i][j] = a[i] & b[j];
            end
        end
    endgenerate

    // First layer of reduction
    assign sum1[0] = pp[0][0];
    assign {carry1[0], sum1[1]} = pp[0][1] + pp[1][0];
    assign {carry1[1], sum1[2]} = pp[0][2] + pp[1][1] + pp[2][0];
    assign {carry1[2], sum1[3]} = pp[0][3] + pp[1][2] + pp[2][1] + pp[3][0];
    assign {carry1[3], sum1[4]} = pp[1][3] + pp[2][2] + pp[3][1];
    assign {carry1[4], sum1[5]} = pp[2][3] + pp[3][2];
    assign sum1[6] = pp[3][3];
    assign carry1[5] = 0;

    // Second layer of reduction
    assign sum2[0] = sum1[0];
    assign {carry2[0], sum2[1]} = sum1[1] + carry1[0];
    assign {carry2[1], sum2[2]} = sum1[2] + carry1[1] + carry1[0];
    assign {carry2[2], sum2[3]} = sum1[3] + carry1[2] + carry1[1];
    assign {carry2[3], sum2[4]} = sum1[4] + carry1[3] + carry1[2];
    assign {carry2[4], sum2[5]} = sum1[5] + carry1[4] + carry1[3];
    assign {carry2[5], sum2[6]} = sum1[6] + carry1[4];
    assign sum2[7] = carry1[5];

    // Third layer of reduction
    assign sum3[0] = sum2[0];
    assign {carry3[0], sum3[1]} = sum2[1] + carry2[0];
    assign {carry3[1], sum3[2]} = sum2[2] + carry2[1] + carry2[0];
    assign {carry3[2], sum3[3]} = sum2[3] + carry2[2] + carry2[1];
    assign {carry3[3], sum3[4]} = sum2[4] + carry2[3] + carry2[2];
    assign {carry3[4], sum3[5]} = sum2[5] + carry2[4] + carry2[3];
    assign {carry3[5], sum3[6]} = sum2[6] + carry2[5];
    assign sum3[7] = carry2[4];

    // Final product
    assign product = sum3;

endmodule
