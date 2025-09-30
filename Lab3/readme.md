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

![rs](https://github.com/user-attachments/assets/bf487fe9-b35f-4101-8dac-4a48fbc3bff1)


## Part 3, Master Slave Flip Flop

This lab instantiates two of the Gated D latches above, where the Q of one D latch is the D input of another. Also the clock of the first D-latch is inverted.

<img width="513" height="512" alt="MS_FF" src="https://github.com/user-attachments/assets/ebaf183a-63e1-4447-aa6b-978d836add68" />












