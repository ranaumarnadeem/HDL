

The Johnson counter is a type of ring counter where the complement of the last bit is fed back into the first bit. 
#### Module Definition
The `johnson_counter` module is designed with the following inputs and outputs:
- **Inputs:**
  - `clk`: The clock signal that drives the counter.
  - `rst_n`: An active-low reset signal, meaning the counter resets when this signal is low.
- **Output:**
  - `q`: A 4-bit register that holds the current state of the counter.

#### Always Block
The counter's behavior is defined inside an `always` block, which is triggered on the rising edge of the clock (`posedge clk`) or the falling edge of the reset signal (`negedge rst_n`). The behavior can be broken down into two main conditions:

1. **Reset Condition (`if (!rst_n)`):**
   - When the reset signal (`rst_n`) is low, the counter is reset to `0000`. This is the initial state of the Johnson counter.

2. **Normal Operation (`else`):**
   - On each rising edge of the clock, the bits of the register `q` are shifted to the left by one position. The inverted value of the least significant bit (`q[0]`) is fed back into the most significant bit (`q[3]`).
   - This shifting and feedback mechanism creates the Johnson counter sequence, which cycles through a unique set of states. For a 4-bit Johnson counter, the sequence will be:
     - `0000`
     - `1000`
     - `1100`
     - `1110`
     - `1111`
     - `0111`
     - `0011`
     - `0001`
     - And then it repeats.

#### Key Points
- **Clock Triggering:** The counter changes its state on the rising edge of the clock signal.
- **Active-Low Reset:** The counter resets to `0000` when the reset signal is low.
- **Johnson Counter Sequence:** The counter produces a unique sequence of states that can be useful in various digital logic applications, such as in shift registers or frequency dividers.
