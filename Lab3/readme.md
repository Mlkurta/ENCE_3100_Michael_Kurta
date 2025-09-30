# Lab 3

## Part 1, Gated SR Latch

<img width="434" height="273" alt="gatedsrlatchls" src="https://github.com/user-attachments/assets/bafc36e0-386a-41ad-9fef-89bb23ddbf73" />

Logisim circuit of a gated SR latch

<img width="600" height="435" alt="gatedsrlatch" src="https://github.com/user-attachments/assets/e57dec42-2d6f-4f4b-80ca-208395d16949" />

RTL view 






## Part 2, Gated D Latch

Truth table
| CLK | D | ~D | S | R | Q | ~Q |
|-----|---|----|---|---|---|----|
| 0   | X | ~X | 0 | 0 | Q | ~Q |
| 1   | 0 | 1  | 0 | 1 | 0 |  1 |
| 1   | 1 | 0  | 1 | 0 | 1 |  0 |

<img width="485" height="336" alt="D_latchls" src="https://github.com/user-attachments/assets/06becee7-ab4a-42d0-a601-ae2f5b102cbb" />

Circuit diagram in logisim. I haven't found a way to get rid of the indeterminite behavior warnings.

<img width="464" height="590" alt="D_latch" src="https://github.com/user-attachments/assets/f4e37d73-a5bc-4d10-bb4e-6d1ced0b3720" />

RTL viewer diagram.

## Part 3, Master Slave Flip Flop

This lab instantiates two of the Gated D latches above, where the Q of one D latch is the D input of another. Also the clock of the first D-latch is inverted.

<img width="506" height="205" alt="M_S_D_latch" src="https://github.com/user-attachments/assets/5f818c4a-e870-42fc-aa10-62dfc131f043" />

Logisim implementation.

<img width="513" height="512" alt="MS_FF" src="https://github.com/user-attachments/assets/ebaf183a-63e1-4447-aa6b-978d836add68" />

RTL viewer diagram.

![DFF](https://github.com/user-attachments/assets/4cb2a06b-9abc-48cf-9ceb-642c729cb9da)

I've implemented both the 50 MHz clock and the switch as the clock. I took a picture of the 50 MHz clock implementation

## Part 4, Latch / Flip Flop demonstration

When referencing the Verilog RTL, this one is the "latch_ff.v" file.
This demo lights six different LEDs (more LEDs are usually more fun), two (Q and Q') from each latch.

I didn't bother with a logisim implementation with how particulat it could be. 

<img width="472" height="446" alt="pt4 circuit" src="https://github.com/user-attachments/assets/3e09f210-9de7-4f32-a45c-7b0286170a67" />

Diagram of the latch / FF network

<img width="447" height="1115" alt="latch_ff_rtl" src="https://github.com/user-attachments/assets/d55796c9-2c65-454e-bbe3-e3e7b9cab378" />

RTL view of the latch network. Notice how it instantiated some additional Flip Flops for the respective compliment (prime) signals.

<img width="435" height="434" alt="pt4_timingh" src="https://github.com/user-attachments/assets/608bf895-1d90-464e-aa16-891be05b7a18" />

Timing Diagram. See if you can follow along with the animation :P

![Part4_1](https://github.com/user-attachments/assets/6facf6d6-5f8a-4b12-b8b0-ee6dd38869b9)

![videotogif](https://github.com/user-attachments/assets/25376360-3f3e-49bb-90f1-5a1ac7d680fb)



























