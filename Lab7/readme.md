# Lab 7, UART Word detector

In this lab, we use a PC, a DE10-Lite FPGA board, and a UART-TTL converter to provide keyboard inputs to the dev board.

What this device does is it will display whatever letter you type on the keyboard on the 7 segment display (most of them).
When the letter 'h' is pressed, it enters it's first state 'h' after the start state. (See state diagram below).


<img width="500" height="607" alt="lfsr_parallel" src="https://github.com/user-attachments/assets/4ad8cfb5-a035-4939-90a0-1c76bc60b363" />

When the letter 'h' is illuminated, a 3 second timer is activated via one_shot pulse from the FSM_Hello module. ALso, as opposed to the first ('s') state, no other input will be displayed unless the next letter in 
the sequence is pressed ('e'). The same sequence happends with every new letter in the sequence. Note there are two 'l's and it can be tricky to ensure one press of the l key doesn't traverse through both 
('l' and 'l2') states. When the one shot timer sends a signal to the FSM_Hello module, the display resets and reverts back to the 's' state. This is similar to something on an ATM. If you walk away for a while, the 
machine should, for security purposes, assume the customer has left inadvertently and lockout / reset the process.

Lastly, the machine can be reset using one of the slide switches.

## Block Diagram

<img width="500" height="607" alt="lfsr_parallel" src="https://github.com/user-attachments/assets/2a5dfaf4-1701-455d-bca6-edf73b3339f8" />

This project is a challenge in mixing synchronous with asynchronous logic, and at least for me, timing of the data ready signal.

## Async Receiver 
This module uses a clock, but detects the UART input asynchronously. It passes its own data and ready signals to a Char synchronizer.

## Char synchronizer
This module synchronizes the data and ready signals so the FSM_Hello module is also synchronized. I tried omitting this module, but it didn't work.
However, at the time it was likely due to other errors. It also forwards the data to the 8 LEDs on the dev board. The display was helpful for
debugging the operation since you can validate what letters were pressed, (via ASCII table / binary conversion).

## FSM Hello
This module is the Finite State Machine (FSM) module of the project. It has states S, H, E, L, L2, and O. It reads every character that enters,
and determines the next course of action. As said above, when it enters the 'H' state, it begins a 3 second timer to finish typing hello. When
the module receives an end of conversion signal (timer end) OR the slide switch #9 is placed high, it resets to the S state.

## 3 Second Timer
This detects a rising edge (not just '1') of the timer_start signal from FSM_Hello, it begins counting to 150,000,000.
It counts to 50 million in a second, returns the timer_end signal upon completion.

## Async Transmitter
This module outputs a serial signal (instead of parallel lanes) to the UART to USB converter. If you're using a serial terminal like tera term or
RealTerm, you can see the letters output on the terminal, since its configured in a "loopback" way (UART TX to FPGA RX and vise versa).

## Char to 7 segment
This is a module which re-routes the signals to the 7 segment format using combinational logic. A seven segment display needs to be displayed a 
certain way, and the normal binary values for 'digits' are not compatible.

![operation](https://github.com/user-attachments/assets/a69128be-1065-4bc7-8429-fe06aed06f15)
