## Multiplier Implementations

This folder includes implementations of four types of multipliers. 

- **Array Multiplier:** Uses a straightforward approach with a grid of AND gates and adders to generate and sum partial products.
- **Carry-Save Multiplier:** Builds on this by using carry-save adders to handle intermediate sums more efficiently, reducing delay.
- **Booth Multiplier:** Employs Booth's algorithm to minimize the number of partial products and operations, making multiplication more efficient, especially for signed numbers.
- **Wallace Tree Multiplier:** Utilizes a parallel structure to accelerate the multiplication process by iteratively reducing the number of partial products through a three-step process.

To use these implementations, clone this repository and integrate the Verilog code into your digital design projects. For more detailed explanations and insights into these binary multipliers, you can refer to my Medium and Substack posts. Feel free to connect with me on LinkedIn or GitHub for any questions or suggestions.

- **Substack:** [Multipliers in Digital Logic](https://open.substack.com/pub/ranaumarnadeem/p/multipliers-in-digital-logic?r=475grk&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true)
- **Medium:** [Multipliers](https://medium.com/@ranaumarnadeem/multipliers-4b7d903d2079)

For any queries, contact me on LinkedIn: [Rana Umar Nadeem](https://www.linkedin.com/in/rana-umar-nadeem-3ba178297)
