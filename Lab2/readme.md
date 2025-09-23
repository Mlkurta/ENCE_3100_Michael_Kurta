
## Part II: Four Bit 2-digit BCD display

![4bit_2digit](https://github.com/user-attachments/assets/f99ad875-e907-484e-b634-bbe7bd48c5e2)


## Part III: Four Bit Ripple Carry Adder

In this next experiment, we will use the LEDs above switches 0-3 to indicate 4-bit binary.

<img width="700" height="647" alt="part3LStt" src="https://github.com/user-attachments/assets/c761fa33-f4aa-4fe8-91c4-f5b5827bcd1a" />

Logisim circuit with truth table for a 1-bit full adder.  If we connect the carry out of the first bit to the carry in of the second, and so on, we now have a 4-bit ripply-carry adder.


<img width="504" height="225" alt="4bit_FA_diag" src="https://github.com/user-attachments/assets/627aa530-933d-4cb3-95be-73dce46ebb01" />




<img width="889" height="721" alt="4bitFAls" src="https://github.com/user-attachments/assets/5f207b04-f41a-4771-8557-828d7ab4cba5" />




![FA0](https://github.com/user-attachments/assets/86b19fb1-87fd-4f1a-b10a-e4919a4e58c4)

To test the full adder, switches a0 and a1 are '1' (rightmost switches) as well as b2, which sums to 7.


![FA1](https://github.com/user-attachments/assets/83bb8e77-5dff-4e5d-a76f-96a93e379031)

When the carry in switch is flipped to a '1', the carry signal propogates and LED 3 is lit.


## Part IV: Four Bit adder with 2-digit BCD 
In this experiment, modification of the Circuit_A logic is required, such that the maximum value displayed is 19. This information comes from the four bit sum and the carry out from the adder.


<img width="1000" height="908" alt="7BCDLs" src="https://github.com/user-attachments/assets/c1634caa-17f7-4879-a2ef-51d1191bec3b" />


