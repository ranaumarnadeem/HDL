module top_module (
    input [3:0] a,
    input [3:0] b,input ci,
    output [3:0] sum
);

 wire [3:0] co;

    fulladder fa0 (.a(a[0]), .b(b[0]), .ci(1'b0), .s(sum[0]), .co(co[0]));
    fulladder fa1 (.a(a[1]), .b(b[1]), .ci(co[0]), .s(sum[1]), .co(co[1]));
    fulladder fa2 (.a(a[2]), .b(b[2]), .ci(co[1]), .s(sum[2]), .co(co[2]));
    fulladder fa3 (.a(a[3]), .b(b[3]), .ci(co[2]), .s(sum[3]), .co(co[3]));

endmodule

module fulladder (a,b,ci,s,co) ;

input a,b,ci;
output wire s;

output co;

wire norout1;

assign norout1= ~(a|b);

assign s= ~(s|ci);

mux(b,ci,norout1,co); // norout1 is signal for 2-1 MUX

endmodule


module mux (input in1,input in2,input sig,output reg out); //in1=b and in2=ci

    always @(*) begin
        if (sig)
            out = in2; 
        else
            out = in1; 
    end

endmodule


