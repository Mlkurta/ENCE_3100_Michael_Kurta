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

## Async Receiver - 

