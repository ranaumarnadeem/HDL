# Digital Clock Project Using Verilog HDL

A digital clock is a common electronic project that displays time using digital circuits. In this example, I created a digital clock that can be preset for minutes and counts hundredths of a second, seconds, and minutes. The time is displayed on 7-segment displays.

---

## Code Explanation

### 1. Module Definition and Inputs/Outputs:

The `top_module` takes a 50 MHz clock input (`CLOCK_50`), two keys (`KEY0` for stop/start and `KEY1` for preset), and an 8-bit switch (`SW`) to preset the minutes. It outputs the time on six 7-segment displays (`HEX0` to `HEX5`).

### 2. Clock Divider:

A clock divider is used to generate a 100 Hz clock signal (`clk_100Hz`) from the 50 MHz input clock.  
The divider counts up to `20'd499999` (which equals 0.01 seconds) to create the 100 Hz clock.

### 3. Control Logic:

The clock can be started or stopped using `KEY0`. When `KEY0` is pressed, the clock stops. Otherwise, it runs.

### 4. Counters and Preset Logic:

- The hundredths of a second, seconds, and minutes are counted using separate counters.
- `KEY1` is used to preset the minutes from the `SW` input.
- The counters increment accordingly, resetting to zero and carrying over when they reach their limits (99 for hundredths of a second, 59 for seconds and minutes).

### 5. 7-Segment Display Conversion:

A function `seg7` is used to convert a 4-bit binary number to its corresponding 7-segment display pattern.  
The time values are divided into digits and sent to the 7-segment displays.

---

## Keywords

- Verilog HDL,Digital Clock,7-Segment Display,Clock Divider,FPGA Projects,DE1 SOC Board,Digital Electronics,Embedded Systems,Hardware Design,RTL Design, IC Testability,Computer Architecture
