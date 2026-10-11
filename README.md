# Custom 16-bit RISC CPU

A custom **16-bit pipelined RISC-style processor** designed and implemented in **Verilog HDL**. The processor features a custom instruction set architecture (ISA), a five-stage pipeline, separate instruction and data memories, a dedicated hardware stack, and subroutine support through `CALL` and `RET` instructions.

## Features

- 16-bit custom RISC ISA
- Five-stage instruction pipeline (IF, ID, EX, MEM, WB)
- 8 × 16-bit register file
- Dedicated Stack Pointer (SP)
- Hardware stack with PUSH and POP instructions
- Subroutine support using CALL and RET
- Arithmetic, logical, memory, and branch instructions
- Separate instruction and data memories (Harvard architecture)
- Pipeline registers between successive stages
- Modular Verilog design for extensibility

---

## Architecture

The processor uses a five-stage pipeline to overlap instruction execution and improve instruction throughput.

```text
          +----------------------+
          | Instruction Fetch    |
          |         (IF)         |
          +----------+-----------+
                     |
                IF/ID Register
                     |
          +----------v-----------+
          | Instruction Decode   |
          |         (ID)         |
          +----------+-----------+
                     |
                ID/EX Register
                     |
          +----------v-----------+
          |   Execute (EX)       |
          |      ALU             |
          +----------+-----------+
                     |
                EX/MEM Register
                     |
          +----------v-----------+
          | Memory Access (MEM)  |
          |  Data Memory / Stack |
          +----------+-----------+
                     |
                MEM/WB Register
                     |
          +----------v-----------+
          |    Write Back (WB)   |
          +----------------------+
```

### Pipeline Stages

| Stage | Description |
|---|---|
| IF — Instruction Fetch | Fetches instructions from instruction memory and updates the PC. |
| ID — Instruction Decode | Decodes instructions, reads registers, and generates control signals. |
| EX — Execute | Performs ALU operations and evaluates relevant branch conditions and targets. |
| MEM — Memory Access | Performs data-memory and stack operations. |
| WB — Write Back | Writes results back to the register file. |

Pipeline registers preserve instruction data and control signals between stages, allowing multiple instructions to be processed concurrently.

---

## Instruction Formats

### R-Type

```text
15      11  10    8   7    5   4    2   1  0
+--------+---------+--------+--------+-----+
| opcode |   rd    |  rs1   |  rs2   | --- |
+--------+---------+--------+--------+-----+
```

### I-Type

```text
15      11  10    8   7              0
+--------+---------+-----------------+
| opcode |   rd    |     imm8        |
+--------+---------+-----------------+
```

### Jump / Branch

```text
15      11  10                      0
+--------+---------------------------+
| opcode |          imm11            |
+--------+---------------------------+
```

---

## Instruction Set

| Category | Instructions |
|---|---|
| Arithmetic | ADD, SUB, MUL, ADDI, SUBI |
| Logic | AND, OR, XOR |
| Memory | LOAD, STORE |
| Control Flow | JMP, BEQ |
| Stack | PUSH, POP |
| Subroutines | CALL, RET |
| System | HLT |

---

## Register File

| Register | Description |
|---|---|
| R0 | Hardwired zero |
| R1–R7 | General-purpose registers |

---

## Memory Organization

| Memory | Size |
|---|---|
| Instruction Memory | 256 × 16 bits |
| Data Memory | 256 × 16 bits |
| Stack | Memory-based stack managed using SP |

Instruction memory is initialized from `program.mem`.

Data memory is initialized from `data.mem`.

---

## Major Modules

- Program Counter (PC)
- Instruction Memory
- Control Unit
- Register File
- Arithmetic Logic Unit (ALU)
- Data Memory
- Stack Pointer Register
- Stack Control Logic
- Branch Adder
- Multiplexers
- IF/ID Pipeline Register
- ID/EX Pipeline Register
- EX/MEM Pipeline Register
- MEM/WB Pipeline Register
- Top-Level CPU

---

## Development Tools

- Verilog HDL
- Icarus Verilog
- GTKWave

Run the simulation:

```bash
iverilog -o cpu_sim cpu_tb.v
vvp cpu_sim
gtkwave cpu.vcd
```

---

## Current Status

- ✔ Custom 16-bit RISC ISA
- ✔ Five-stage pipelined processor
- ✔ IF, ID, EX, MEM, and WB stages
- ✔ Pipeline register implementation
- ✔ Arithmetic and logical operations
- ✔ Load/store instructions
- ✔ Branch and jump instructions
- ✔ Dedicated hardware stack
- ✔ PUSH / POP instructions
- ✔ CALL / RET subroutine support

---

## Future Roadmap

- **v2** — Pipeline integration and verification
- **v3** — Hazard detection and pipeline stall logic
- **v4** — Data forwarding / bypass network
- **v5** — Branch prediction and pipeline optimizations
- **v6** — FPGA implementation and hardware validation

---

## Project Goal

This project aims to develop a deep understanding of computer architecture by building a processor from scratch—from ISA design and datapath implementation to pipelining, pipeline register design, hazard handling, and FPGA-based hardware validation.
