
# Lab 8, Simple Microprocessor

## Block Diagram


## RTL View

<img width="2234" height="1243" alt="image" src="https://github.com/user-attachments/assets/106def44-4c82-4795-8c6a-4129d37a6d1d" />

## Accumulator A
The 'A' Accumulator is a register that will receive numerical data to pass to the Arithmetic unit and then accumulate the total through the IB_BUS It also outputs this result on the IB_BUS via a tri-state buffer. The tri-state buffer allows multiple modules to push information onto the bus as needed, and then go to a high impedence, or high-Z state when not to avoid bus conflits. There is a AluA output which displays the accumulator's current value. The control unit determines when the module is both enabled and latched.

## Accumulator B
The 'B' Accumulator is nearly identical to Accumulator A. It is a register which holds the value of the last input and adds any new incoming inputs. The control unit determines when the module is both enabled and latched.

## Arithmetic Logic Unit (ALU)
The ALU performs addition and subtraction via the use of the inputs from Accumulators A and B. There is a 1-bit signal input "add_sub" which dictates whether the ALU will add (A+B) or subtract (A-B). When the system is not performing calculations, it goes to a high-z state.

## Input Register
The in register allows the user to enter data to be added or subtracted via the switches on the board. It recieves the data by reading the slide switches, and outputs this data onto the IB_BUS.

## Output Register

## Instruction Register
The instruction register is an intermidiary module between the ROM and the Finite State Machine. While the FSM decides how to operate the Accumulators, ALU and bus, the Instruction register parses what must be done from the ROM and outputs the action to the FSM.

## Program Memory (ROM)
The program memory stores all of the instructions for the processor. In the real world, this could be a bootloader, or startup sequence, or user controlled actions.

## Program Counter
The program counter synchronizes what memory addresses are read from the ROM. Since instructions are not completed in one clock cycle, it must count to allow a delay before updating it's output to tell the ROM to go to the next instruction.

## Finiste State Machine (FSM) Controller
The FSM Controller is the 'smart' module of this system. 
