
# Lab 4: Counters

## Part I, 8 bit counter.

This experiment demonstrates an 8-bit synchronous counter made from T-flip flops.

<img width="750" height="550" alt="8_bit_tff" src="https://github.com/user-attachments/assets/0167b9f6-673e-4100-9e65-69af22cb9d62" />

8 bit counter made from T-flip flops.

A T-Flip Flop is a particular type of flip flop where every time a clock is triggered (rising edge in this case), it will toggle its output if both T and enable (and clr)
are all a logic '1'. It's created by using a D-flip flop and an AND gate per bit. Each T input after the first bit is ANDed with the previous output.


## Part II, 16 bit counter

This part takes the counter from part 1 and expands it to 16 bits. This time, the counter is supplied with a 
1 millisecond timer module. The module reduces the tic rate from the clock's 50 Mhz down to 1,000 Hz (or period
of 1 ms). The 1 ms timer module outputs 

The easiest way to implement a 7-segment counter is through hexadecimal, or base 16. 
In the next experiment, we'll use a binary to Binary Coded Decimal (BCD) converter to represent
decimal numbers.


<img width="450" height="613" alt="img_7534" src="https://github.com/user-attachments/assets/cfc41cb9-841e-4af6-b649-42389da9a320" />

The device counts very fast, and overflows in around a minute with 4 hex digits -16 bits, max unsigned value of 2^16 - 1 = 65,535 (hex FFFF).
The device counts to 60,000 in one minute.


## Part III, LPM 8-bit hex counter

Quartus has a an IP block to instantiate a counter, connect the clock, clear, and enable signals and receive a
user-configurable bit width (set to 8 bits here).

<img width="450" height="613" alt="hex_counter" src="https://github.com/user-attachments/assets/551298e2-78b5-456d-a01b-461edf9e42cc" />

Notice that only 2 digits are used. Why do we only need 2 digits to represent a 2^8 - 1 = 255?  
This is because we normally use a base 10 numbering system, which is what we're most familiar with.

The easiest way to implement a 7-segment counter is through hexadecimal, or base 16. 
In the next experiment, we'll use a binary to Binary Coded Decimal (BCD) converter to represent
decimal numbers.

## Part IV, 8-bit BCD Counter

If we want to make a digital clock just like any that you're familiar with, we'll have to create a BCD converter. 
It's not just as easy as modifying the seg7decoder.v file to say any number greater than 10 is still the ones digit
number. This is because in hex, the carry out comes after 15 (F) instead of 10.  
The double dabble algorithm is one such tool (ref. bin_to_bcd_3dig.v) - this uses bit-shifting and adding to convert to
a base 10 number.

<img width="702" height="418" alt="functional diag" src="https://github.com/user-attachments/assets/04a492ed-0dda-43c7-bd56-34a234818ee2" />

Block diagram of the BCD counter circuit.


<img width="450" height="613" alt="hex_counter" src="https://github.com/user-attachments/assets/8e967b24-0512-4abc-962f-5fcf726c21af" />

Now the device correctly counts to 255 before overflowing back to 0. 
