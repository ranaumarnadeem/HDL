
## Top Module Explanation

The top module defines the main functionality of the 8-bit adder/subtractor. It includes inputs for the 8-bit binary numbers, a clock, a reset, and a control signal for determining whether to add or subtract. The outputs include the 8-bit result, carry, overflow, and 7-segment display segments.

### Register and Wire Declarations

- **A and S Registers:** `A` and `S` are 8-bit registers used to store the operand and the sum/difference respectively.
- **Result Wire:** `result` is a 9-bit wire that holds the output of the addition or subtraction operation, including the carry bit.
- **Carry and Overflow Wires:** `carry` and `overflow` are wires used for detecting carry-out and overflow conditions.

### Add/Subtract Operation

- **Add/Sub Operation:** The actual operation (addition or subtraction) is determined by the `add_sub` signal. If `add_sub` is high, subtraction is performed; otherwise, addition is performed. The result of the operation, along with the carry bit, is stored in `result`.
- **Overflow Detection:** Overflow is detected by comparing the signs of the operands and the result.

### Clock and Reset Handling

- **Reset Condition:** On the negative edge of the reset (`KEY0`), all registers and outputs are reset to zero.
- **Clock Condition:** On the positive edge of the clock (`KEY1`), the result, carry, and overflow are updated based on the performed operation.

### 7-Segment Display Decoder Instances

- **Display Instances:** Four instances of the `hex_display` module convert the 4-bit binary inputs (from the result) into 7-segment display outputs. Each instance corresponds to a different 4-bit segment of the result, displaying them on the HEX displays.

## 7-Segment Display Decoder Module Explanation

The `hex_display` module converts a 4-bit binary number into a 7-segment display pattern. 

### Conversion Logic

- **Case Statement:** The module uses a `case` statement to map each 4-bit binary number to its corresponding 7-segment display pattern. This allows the 4-bit binary input to be visually represented on the 7-segment display.

### Segment Patterns

- **Digit Mapping:** The segment patterns for the digits 0-9 and A-F are defined within the `case` statement, enabling the display of hexadecimal digits on the 7-segment display.
