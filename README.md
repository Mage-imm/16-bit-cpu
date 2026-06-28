# Custom 16-bit RISC CPU

A custom **16-bit single-cycle RISC-style processor** designed and implemented in **Verilog HDL**. The processor features a custom instruction set architecture (ISA), separate instruction and data memories, a dedicated hardware stack, and subroutine support through `CALL` and `RET` instructions.

## Features

* 16-bit custom RISC ISA
* Single-cycle datapath
* 8 × 16-bit register file
* Dedicated Stack Pointer (SP)
* Hardware stack with PUSH and POP instructions
* Subroutine support using CALL and RET
* Arithmetic, logical, memory and branch instructions
* Separate instruction and data memories (Harvard architecture)
* Modular Verilog design for easy extensibility

---

## Architecture

```
                 +----------------------+
                 |      Program Counter |
                 +----------+-----------+
                            |
                            v
                  Instruction Memory
                            |
                            v
                     Instruction Decode
                            |
        +-------------------+-------------------+
        |                                       |
        v                                       v
  Register File                           Control Unit
        |                                       |
        +-------------------+-------------------+
                            |
                            v
                           ALU
                            |
                     +------+------+
                     |             |
               Data Memory      Stack
                     |             |
                     +------+------+
                            |
                       Write Back
```

---

## Instruction Formats

### R-Type

```
15      11  10    8   7    5   4    2   1  0
┌────────┬─────────┬────────┬────────┬─────┐
│ opcode │   rd    │  rs1   │  rs2   │ --- │
└────────┴─────────┴────────┴────────┴─────┘
```

### I-Type

```
15      11  10    8   7              0
┌────────┬─────────┬─────────────────┐
│ opcode │   rd    │     imm8        │
└────────┴─────────┴─────────────────┘
```

### Jump / Branch

```
15      11  10                      0
┌────────┬───────────────────────────┐
│ opcode │          imm11            │
└────────┴───────────────────────────┘
```

---

## Instruction Set

| Category     | Instructions              |
| ------------ | ------------------------- |
| Arithmetic   | ADD, SUB, MUL, ADDI, SUBI |
| Logic        | AND, OR, XOR              |
| Memory       | LOAD, STORE               |
| Control Flow | JMP, BEQ                  |
| Stack        | PUSH, POP                 |
| Subroutines  | CALL, RET                 |
| System       | HLT                       |

---

## Register File

| Register | Description               |
| -------- | ------------------------- |
| R0       | Hardwired Zero            |
| R1-R6    | General Purpose Registers |
| R7       | Stack Pointer (SP)        |

---

## Memory Organization

| Memory             | Size                        |
| ------------------ | --------------------------- |
| Instruction Memory | 256 × 16 bits               |
| Data Memory        | 256 × 16 bits               |
| Stack              | Memory-based stack using SP |

Instruction memory is initialized from:

```
program.mem
```

Data memory is initialized from:

```
data.mem
```

---

## Major Modules

* Program Counter (PC)
* Instruction Memory
* Control Unit
* Register File
* Arithmetic Logic Unit (ALU)
* Data Memory
* Stack Pointer Register
* Stack Control Logic
* Branch Adder
* Multiplexers
* Top-Level CPU

---

## Development Tools

* Verilog HDL
* Icarus Verilog
* GTKWave

Run the simulation:

```bash
iverilog -o cpu_sim cpu_tb.v
vvp cpu_sim
gtkwave cpu.vcd
```

---

## Current Status

✔ Single-cycle CPU

✔ Custom ISA

✔ Arithmetic and Logical Operations

✔ Load/Store Instructions

✔ Branch and Jump Instructions

✔ Dedicated Hardware Stack

✔ PUSH / POP Instructions

✔ CALL / RET Subroutine Support

---

## Future Roadmap

* **v2** — Five-stage pipeline (IF, ID, EX, MEM, WB)
* **v3** — Hazard detection unit
* **v4** — Data forwarding / bypass network
* **v5** — Branch prediction and pipeline optimizations
* **v6** — FPGA implementation and hardware validation

---

## Project Goal

This project is being developed to gain a deep understanding of computer architecture by building a processor completely from scratch—from ISA design and datapath implementation to stack management, pipelining, and hazard handling.
