`include "alu.v"
`include "control_unit.v"
`include "data_mem.v"
`include "instruction_mem.v"
`include "pc.v"
`include "reg_file.v"
`include "mux.v"
`include "branch_adder.v"

module cpu (
    input clk,rst
);

wire zero;
wire [15:0] branch_addr,pc_out,inst,rs1_data,rs2_data,alu_result,mem_data;
wire [10:0] jump_pc;
wire [10:0] branch_imm;

wire        regfile_write;
wire [2:0]  rs1_regfile;
wire [2:0]  rs2_regfile;
wire [2:0]  rd_regfile;
wire [7:0]  alu_imm;
wire [7:0]  adr_imm;
wire [2:0]  alu_op;
wire        jump_en;
wire        halt;
wire        branch_en;
wire        write_data;
wire        read_data;
wire        s1,s2,s3;
wire [15:0] dm_wr_data, wb_data, alu_b;

pc pc0(
    .clk(clk),
    .rst(rst),
    .halt(halt),
    .jump_en(jump_en),
    .branch_en(branch_en),
    .jump_addr({5'b0, jump_pc}),
    .branch_addr(branch_addr),
    .pc_out(pc_out)
);

branch_adder b0(
    .pc_out(pc_out),
    .branch_addr(branch_addr),
    .imm({{5{branch_imm[10]}}, branch_imm})
);

instruction_mem im0(
    .addr(pc_out),
    .inst(inst)
);

control_unit cu0(
    .adress_control(inst),
    .zero(zero),
    .regfile_write(regfile_write),
    .rs1_regfile(rs1_regfile),
    .rs2_regfile(rs2_regfile),
    .rd_regfile(rd_regfile),
    .alu_imm(alu_imm),
    .adr_imm(adr_imm),
    .alu_op(alu_op),
    .jump_en(jump_en),
    .halt(halt),
    .branch_en(branch_en),
    .write_data(write_data),
    .read_data(read_data),
    .s1(s1),
    .s2(s2),
    .s3(s3),
    .branch_imm(branch_imm),
    .jump_pc(jump_pc)
);

reg_file rf0(
    .clk(clk),
    .rst(rst),
    .reg_write(regfile_write),
    .rs1_addr(rs1_regfile),
    .rs2_addr(rs2_regfile),
    .rd_addr(rd_regfile),
    .wr_data(wb_data),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);

alu alu0(
    .a(rs1_data),
    .b(alu_b),
    .alu_op(alu_op),
    .result(alu_result),
    .zero(zero)
);

data_mem dm0(
    .addrr_data(adr_imm),
    .wr_data(dm_wr_data),
    .wr_en(write_data),
    .read_en(read_data),
    .data(mem_data)
);

mux2x1 mux_s1(
    .in0(rs2_data),
    .in1(alu_result),
    .sel(s1),
    .out(dm_wr_data)
);

mux2x1 mux_s2(
    .in0(alu_result),
    .in1(mem_data),
    .sel(s2),
    .out(wb_data)
);

mux2x1 mux_s3(
    .in0({8'b0, alu_imm}),
    .in1(rs2_data),
    .sel(s3),
    .out(alu_b)
);

endmodule