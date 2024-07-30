## 4-bit Adder Implementation

This is a 4-bit adder using a chain of full adders, where each full adder is responsible for adding individual bits of two 4-bit numbers along with a carry-in. The resulting sum and carry-out are computed and output.

### Top Module

The `top_module` is the primary module, which accepts two 4-bit inputs (`a` and `b`) and a carry-in (`ci`). It outputs a 4-bit sum. The module instantiates four `fulladder` modules, each responsible for calculating one bit of the sum and carry-out. The full adders are connected in a chain, where each full adder's carry-out is fed as the carry-in to the next higher bit's full adder.

### Full Adder Module

The `fulladder` module performs the addition of three inputs: two data bits (`a` and `b`) and a carry-in (`ci`). It calculates the sum and carry-out. The `fulladder` uses a `mux` module to determine the sum based on the carry-in and the `norout1` signal, which is derived from a NOR operation on the input bits.

### Mux Module

The `mux` module is a 2-to-1 multiplexer that selects between two inputs based on a control signal. In this case, it selects between the `b` input and the `ci` input based on the `sig` signal, which is derived from the `norout1` output of the `fulladder`.

## Connect with Me

For more detailed explanations and insights into digital design topics, you can refer to my Medium and Substack posts. Feel free to connect with me on LinkedIn or GitHub for any questions or suggestions.

- **Substack:** [Multipliers in Digital Logic](https://open.substack.com/pub/ranaumarnadeem/p/multipliers-in-digital-logic?r=475grk&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)
- **Medium:** [Multipliers](https://medium.com/@ranaumarnadeem/multipliers-4b7d903d2079)
- **LinkedIn:** [Rana Umar Nadeem](https://www.linkedin.com/in/rana-umar-nadeem-3ba178297)
- **GitHub:** [ranaumarnadeem/HDL](https://github.com/ranaumarnadeem/HDL)
