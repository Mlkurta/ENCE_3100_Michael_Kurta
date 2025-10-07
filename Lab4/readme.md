
# Lab 4: Counters

## Part I, 8 bit counter.

This experiment demonstrates an 8-bit synchronous counter made from T-flip flops.

<img width="450" height="613" alt="4_bit_tff" src="https://github.com/user-attachments/assets/eda9d012-575e-427d-a811-0a153da486a8" />

4 bit counter


## Part II, 16 bit counter

This part takes the counter from part 1 and expands it to 16 bits. This time, the counter is supplied with a 
1 millisecond timer module. The module reduces the tic rate from the clock's 50 Mhz down to 1,000 Hz (or period
of 1 ms).

![IMG_7534](https://github.com/user-attachments/assets/cfc41cb9-841e-4af6-b649-42389da9a320)


## Part III, LPM 8-bit hex counter

Quartus has a an IP block to instantiate a counter, connect the clock, clear, and enable signals and receive a
user-configurable bit width (set to 8 bits here).

![hex_counter](https://github.com/user-attachments/assets/551298e2-78b5-456d-a01b-461edf9e42cc)

Notice that only 2 digits are used. Why do we only need 2 digits to represent a 2^8 - 1 = 255?  
This is because we normally use a base 10 numbering system, which is what we're most familiar with.

The easiest way to implement a 7-segment counter is through hexadecimal, or base 16. 
In the next experiment, we'll use a binary to Binary Coded Decimal (BCD) converter to represent
decimal numbers.
