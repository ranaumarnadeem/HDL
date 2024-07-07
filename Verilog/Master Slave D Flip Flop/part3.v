module master_slave_dff (
    input Clk,   
    input D,     
    output Q     // Out-ff
);

wire Qm; // Output of the master 


part3 master_latch (
    .Clk(~Clk), 
    .D(D),
    .Q(Qm)
);


part3 slave_latch (
    .Clk(Clk), 
    .D(Qm),
    .Q(Q)
);

endmodule

module part3 (
    input Clk, D,
    output Q
);

wire R, S;
wire R_g, S_g, Qa, Qb /* synthesis keep */ ;

assign R = ~D;
assign S = D;
assign R_g = R & Clk;
assign S_g = S & Clk;
assign Qa = ~(R_g | Qb);
assign Qb = ~(S_g | Qa);
assign Q = Qa;

endmodule
