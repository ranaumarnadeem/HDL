module Part2 (input Clk, D,output Q);

wire R, S;
wire R_g, S_g, Qa, Qb /* synthesis keep */ ;

assign R = ~D;       // Inverted D for R input
assign S = D;        // D input for S

assign R_g = R & Clk;
assign S_g = S & Clk;

assign Qa = ~(R_g & Qb); // NOTed both siganls here for simplification
assign Qb = ~(S_g & Qa); 

assign Q = Qa; // Output Q is Qa

endmodule
