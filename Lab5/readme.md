# Lab 5: Adders, Subtractors and Multipliers

## Part I: Adder Circuit

This circuit is an 8-bit accumulator. This is an adder with registers to keep the value(s), and the value increments by what the switches are set to, with every button press.
It can be thought of as an integrator.

<img width="698" height="989" alt="image" src="https://github.com/user-attachments/assets/cf33af6b-9024-4d37-ad17-97ca1ca4b374" />

RTL diagram of accumulator circuit.

<img width="734" height="744" alt="image" src="https://github.com/user-attachments/assets/680dd0e0-3621-459a-8919-ff7278dc11ba" />

From the diagram, it's simply an adder with the inputs and outputs being saved in a register. 


On the board, the switches can be set to detemine how much to add.  It takes two presses of the 'clock' to compute the addition, but additional presses accumulate the added value.
It continues to add with every button press until it overflows (> 255). 


## Part II: Subtractor Circuit

The subtractor circuit works identically to the adder, just with an added function.

<img width="738" height="880" alt="image" src="https://github.com/user-attachments/assets/c0165eaa-9f0d-43f7-a94c-19552f8ec89f" />

Looking at the RTL view, is there are two adders instantiated, one designed to subtract B from A if i_addsub is a '1'. So really both the addition
and subtraction are computed at the same time. The multiplexer looks at the i_addsub signal and determines which value to output.


## Part III: Multiplier Circuit (1 bit adders)

The multiplier circuit works by use of an array multiplier, which uses several levels of cascading adders.

<img width="1438" height="752" alt="image" src="https://github.com/user-attachments/assets/231aae93-ec75-41cc-b220-748edb057c9c" />

<img width="738" height="752" alt="image" src="https://github.com/user-attachments/assets/6c1d8ed3-0583-460a-8133-7d94ae0ad349" />

5 x 4 = 20. 

## Part IV: Multiplier Circuit (8 bit adders)

This 8x8 multiplier works by using and array of 8-bit adders to carry out the multiplication and output a 16 bit value. The number is converted to BCD and displayed on the 7 segment decoders.

<img width="894" height="771" alt="image" src="https://github.com/user-attachments/assets/81112287-2a1a-4953-a1b6-a9d553be5fcc" />

Top module block diagram.

<img width="2217" height="939" alt="image" src="https://github.com/user-attachments/assets/bd1822b2-8a03-4084-8a74-b5b72a70d116" />

Multiplier RTL from arrayed 8 bit adders.

<img width="1117" height="939" alt="image" src="https://github.com/user-attachments/assets/dde0e0fc-fe76-460e-b4e2-a0ce9e12edf3" />





