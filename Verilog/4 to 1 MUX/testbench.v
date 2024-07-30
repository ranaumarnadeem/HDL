`timescale 1ns / 1ps

module Task2_tb;

    // Inputs
    reg [3:0] x;
    reg [3:0] y;
    reg s;

    // Outputs
    wire [3:0] m;
    wire [3:0] LED;


    Task2 u1 (
        .x(x), 
        .y(y), 
        .s(s), 
        .m(m), 
        .LED(LED)
    );

    initial begin
        // Initialize Inputs
        x = 4'b0000;
        y = 4'b0000;
        s = 0;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Apply test vectors
        x = 4'b1010; y = 4'b0101; s = 0; #10; // Expected m = y (0101)
        x = 4'b1010; y = 4'b0101; s = 1; #10; // Expected m = x (1010)
        x = 4'b1111; y = 4'b0000; s = 0; #10; // Expected m = y (0000)
        x = 4'b1111; y = 4'b0000; s = 1; #10; // Expected m = x (1111)
        x = 4'b0011; y = 4'b1100; s = 0; #10; // Expected m = y (1100)
        x = 4'b0011; y = 4'b1100; s = 1; #10; // Expected m = x (0011)
        
        // Finish simulation
        $finish;
    end
    
    initial begin
        $monitor("At time %t, x = %b, y = %b, s = %b, m = %b, LED = %b", $time, x, y, s, m, LED);
    end
      
endmodule
