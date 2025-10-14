# Lab 5: Adders, Subtractors and Multipliers

## Part I: Adder Circuit

This circuit is an 8-bit accumulator. This is an adder with registers to keep the value(s), and the value increments by what the switches are set to, with every button press.
It can be thought of as an integrator.

<img width="698" height="989" alt="image" src="https://github.com/user-attachments/assets/cf33af6b-9024-4d37-ad17-97ca1ca4b374" />

RTL diagram of accumulator circuit.

<img width="734" height="744" alt="image" src="https://github.com/user-attachments/assets/680dd0e0-3621-459a-8919-ff7278dc11ba" />

From the diagram, it's simply an adder with the inputs and outputs being saved in a register. 


On the board, you set the switches for how much you want to add.  It takes two presses of the 'clock' to compute the addition, but additional presses accumulate the added value.
It continues to add with every button press until it overflows (> 255). 


## Part II: Subtractor Circuit

The subtractor circuit works identically to the adder, just with an added function.

<img width="738" height="880" alt="image" src="https://github.com/user-attachments/assets/c0165eaa-9f0d-43f7-a94c-19552f8ec89f" />

Looking at the RTL view, is there are two adders instantiated, one designed to subtract B from A if i_addsub is a '1'. So really both the addition
and subtraction are computed every time either reg_A or reg_B changes + a rising edge, it's that the multiplexer determines which value is passed on and saved in the register.


## Part II: 
