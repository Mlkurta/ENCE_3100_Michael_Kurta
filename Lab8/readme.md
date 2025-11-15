
# Lab 8, Simple Microprocessor

![VideoToGif_GIF (1)](https://github.com/user-attachments/assets/0f11235a-b077-4070-a3a3-1f114c227fbb)



<img width="834" height="1243" alt="image" src="https://github.com/user-attachments/assets/b388c463-bcdb-4a41-84e4-41c905e5b9ed" />

## RTL View

<img width="2234" height="1243" alt="image" src="https://github.com/user-attachments/assets/106def44-4c82-4795-8c6a-4129d37a6d1d" />

## Accumulator A
<img width="1019" height="870" alt="image" src="https://github.com/user-attachments/assets/788cadbc-6604-4e63-97cb-724c1cdc8ad0" />

The 'A' Accumulator is a register that will receive numerical data to pass to the Arithmetic unit and then accumulate the total through the IB_BUS It also outputs this result on the IB_BUS via a tri-state buffer. The tri-state buffer allows multiple modules to push information onto the bus as needed, and then go to a high impedence, or high-Z state when not to avoid bus conflits. There is a AluA output which displays the accumulator's current value. The control unit determines when the module is both enabled and latched.

## Accumulator B
<img width="1022" height="871" alt="image" src="https://github.com/user-attachments/assets/da39bb10-45a9-4cfa-87c1-409a94c3bf90" />

The 'B' Accumulator is nearly identical to Accumulator A. It is a register which holds the value of the last input and adds any new incoming inputs. The control unit determines when the module is both enabled and latched.

## Arithmetic Logic Unit (ALU)
<img width="1014" height="756" alt="image" src="https://github.com/user-attachments/assets/e6781fd1-1a36-4f35-a118-170706998e76" />

The ALU performs addition and subtraction via the use of the inputs from Accumulators A and B. There is a 1-bit signal input "add_sub" which dictates whether the ALU will add (A+B) or subtract (A-B). When the system is not performing calculations, it goes to a high-z state to allow other modules to contibute to the bus.

## Input Register
<img width="817" height="865" alt="image" src="https://github.com/user-attachments/assets/a5f030a6-efac-4dfd-b45b-e3257303b32c" />

The in register allows the user to enter data to be added or subtracted via the switches on the board. It recieves the data by reading the slide switches, and outputs this data onto the IB_BUS.

## Output Register
<img width="810" height="882" alt="image" src="https://github.com/user-attachments/assets/b3e57930-3418-4267-8f69-399598d412d2" />

## Instruction Register
<img width="1028" height="889" alt="image" src="https://github.com/user-attachments/assets/9dfd4150-ba40-4c6d-a691-a777d36523a4" />

| Instruction | Code |
|-------------|------|
|    NOP      | 0000 |
|    ADD      | 0001 |
|    SUB      | 0010 |
|    OUT      | 0011 |
|    IN       | 0100 |
|    LDA      | 0101 |

The instruction register is an intermidiary module between the ROM and the Finite State Machine. While the FSM decides how to operate the Accumulators, ALU and bus, the Instruction register parses what must be done from the ROM and outputs the action to the FSM.

Commands: 

NOP - Do nothing

ADD - Add the contents of accumulator A to the contents of the variable to be summed.

SUB - Sutract contents of accumulator A from the data given as the parameter.

OUT - The contents of accumulator A is stored to the output port.

IN  - THe content of the input port is transferred to Accumulator A

LDA - (Load A) - The accumulator A is loaded with the value given as the parameter.

## Program Memory (ROM)
<img width="896" height="1220" alt="image" src="https://github.com/user-attachments/assets/e1872940-e694-4ec7-907c-8818d0dca17a" />

The program memory stores all of the instructions for the processor. In the real world, this could be a bootloader, or startup sequence, or user controlled actions.

## Program Counter
<img width="1060" height="526" alt="image" src="https://github.com/user-attachments/assets/060ed9ef-ef5d-4582-ba6b-d8e14ffa1683" />

The program counter synchronizes what memory addresses are read from the ROM. Since instructions are not completed in one clock cycle, it must count to allow a delay before updating it's output to tell the ROM to go to the next instruction.

## Finiste State Machine (FSM) Controller
<img width="904" height="1107" alt="image" src="https://github.com/user-attachments/assets/40347d4b-0c8c-4139-967a-7d6010cb319c" />

The FSM Controller is the 'smart' module of this system. It directs the actions of the other submodules, such that the modules can properly coordinate when they contribute to the bus or go to a high-z state. This allows error-free data
travel between modules. Every action takes four clock cycles, and thus four phases. These phases make up the four different states of the controller.
