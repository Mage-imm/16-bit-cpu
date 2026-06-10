# Custom 16-bit RISC CPU

A custom 16-bit single-cycle RISC-style CPU implemented in Verilog.

## Architecture

```
PC → Instruction Memory → Control Unit
                               │
                    ┌──────────┴──────────┐
                 Register File           ALU
                    │                     │
                    └──────────┬──────────┘
                               │
                          Data Memory
                               │
                          Write Back
```

## ISA

### Instruction Format

R-type:
```
15      11  10    8   7    5   4    2   1  0
┌────────┬─────────┬────────┬────────┬─────┐
│ opcode │   rd    │  rs1   │  rs2   │ --- │
└────────┴─────────┴────────┴────────┴─────┘
  5-bit     3-bit    3-bit    3-bit   2-bit
```

I-type:
```
15      11  10    8   7              0
┌────────┬─────────┬─────────────────┐
│ opcode │   rd    │     imm8        │
└────────┴─────────┴─────────────────┘
  5-bit     3-bit        8-bit
```

JMP/BEQ:
```
15      11  10                      0
┌────────┬───────────────────────────┐
│ opcode │          imm11            │
└────────┴───────────────────────────┘
  5-bit              11-bit
```

### Instruction Set

| Mnemonic | Opcode  | Format | Operation              |
|----------|---------|--------|------------------------|
| ADD      | 00000   | R      | rd = rs1 + rs2         |
| SUB      | 00001   | R      | rd = rs1 - rs2         |
| MUL      | 00010   | R      | rd = rs1 * rs2         |
| AND      | 00011   | R      | rd = rs1 & rs2         |
| OR       | 00100   | R      | rd = rs1 \| rs2        |
| XOR      | 00101   | R      | rd = rs1 ^ rs2         |
| ADDI     | 10000   | I      | rd = rd + imm8         |
| SUBI     | 10001   | I      | rd = rd - imm8         |
| LOAD     | 10010   | I      | rd = MEM[imm8]         |
| STORE    | 10011   | I      | MEM[imm8] = rs1        |
| JMP      | 10111   | J      | PC = imm11             |
| BEQ      | 11000   | J      | if rs1==0: PC+=imm11   |
| HLT      | 11111   | -      | Halt execution         |

## Registers

| Register | Purpose         |
|----------|-----------------|
| R0       | Hardwired zero  |
| R1 - R6  | General purpose |
| R7       | Reserved (SP)   |

## Modules

| Module          | Description                          |
|-----------------|--------------------------------------|
| pc              | 16-bit program counter               |
| inst_mem        | 256x16 instruction memory            |
| reg_file        | 8x16 register file, R0 hardwired 0   |
| alu             | ADD SUB MUL AND OR XOR               |
| data_mem        | 256x16 data memory                   |
| control_unit    | Instruction decode, control signals  |
| branch_adder    | PC-relative branch target compute    |
| mux2x1          | 16-bit 2-to-1 multiplexer            |
| cpu             | Top level integration                |

## Control Signals

| Signal        | Description                           |
|---------------|---------------------------------------|
| regfile_write | Write enable for register file        |
| alu_op[2:0]   | ALU operation select                  |
| write_data    | Data memory write enable (active low) |
| read_data     | Data memory read enable (active low)  |
| branch_en     | Enable PC branch                      |
| jump_en       | Enable PC jump                        |
| halt          | Freeze PC                             |
| s1            | Mux: data mem input select            |
| s2            | Mux: regfile writeback select         |
| s3            | Mux: ALU input B select               |

## Memory

| Memory          | Size      | Addressing |
|-----------------|-----------|------------|
| Instruction Mem | 256 x 16b | Word       |
| Data Memory     | 256 x 16b | Word       |

Both memories are initialized from files:
- `program.mem` — binary instruction program
- `data.mem`    — initial data memory contents

## Toolchain

- Simulator : Icarus Verilog
- Waveforms : GTKWave

## How To Run

```bash
iverilog -o cpu_sim cpu_tb.v
vvp cpu_sim
gtkwave cpu.vcd
```

## Upgrade Roadmap

```
v1 (current) → Single cycle CPU
v2           → Stack, PUSH, POP, CALL, RET
v3           → 5-stage pipeline (IF ID EX MEM WB)
v4           → Hazard detection and forwarding
v5           → FPGA synthesis
```
