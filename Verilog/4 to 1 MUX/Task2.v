module Task2(
    input [3:0] x,    // 4-bit input x
    input [3:0] y,    // 4-bit input y
    input s,          // 1-bit input select signal
    output [3:0] m,   // 4-bit output m
    output [3:0] LED  // 4-bit output LED
);

    // Multiplexer logic: select x if s is 1, otherwise select y
    assign m = (s) ? x : y;

    // Set all LEDs to 0
    assign LED = 4'b0000;

endmodule
