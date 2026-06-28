`include "alu.v"
`include "control_unit.v"
`include "data_mem.v"
`include "instruction_mem.v"
`include "pc.v"
`include "reg_file.v"
`include "mux.v"
`include "branch_adder.v"
`include "stack_pointer.v"
`include "add_sub.v"
`include "mux_4x1.v"
`include "call_addr.v"
`include "if_id_reg.v"
`include "id_ex_reg.v"
`include "ex_mem.v"
`include "mem_wb.v"

module cpu (
    input clk,rst
);


wire zero;
wire [15:0] branch_addr,pc_out,inst,rs1_data,rs2_data,alu_result,mem_data,pc_next;
wire [10:0] jump_pc;
wire [10:0] branch_imm;
wire [7:0]  stack_addr;

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
wire        s1,s2,s3,s4,s5;
wire [15:0] dm_wr_data, wb_data, alu_b;
wire [7:0]  sp_out;
wire [7:0]  sp_next;
wire        push_en;
wire        pop_en;
wire[7:0]   data_mem_addr;
wire        push_pop_sel;  
wire [15:0] jump_addr_final;
wire        ret_en;









pc pc0(
    .clk(clk),
    .rst(rst),
    .halt(halt),
    .jump_en(jump_en),
    .branch_en(branch_en),
    .jump_addr(jump_addr_final),
    .branch_addr(branch_addr),
    .pc_out(pc_out)
);

branch_adder b0(
    .pc_out(pc_out),
    .branch_addr(branch_addr),
    .imm(branch_imm)
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
    .s4(s4),
    .s5(s5),
    .branch_imm(branch_imm),
    .jump_pc(jump_pc),
    .push_pop_sel(push_pop_sel),
    .push_en(push_en),
    .pop_en(pop_en),
    .ret_en(ret_en)
    
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
    .addrr_data(data_mem_addr),
    .wr_data(dm_wr_data),
    .wr_en(write_data),
    .read_en(read_data),
    .data(mem_data)
);

call_addr call0(
    .pc(pc_out),
    .pc_next(pc_next)
)
;

mux_4x1 mux_s1(
    .in0(rs2_data),
    .in1(alu_result),
    .in2(pc_next),
    .in3(rs1_data),
    .s1(s1),
    .s2(s5),
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

mux2x1 mux_s4(
    .in0(stack_addr),
    .in1(adr_imm),
    .sel(s4),
    .out(data_mem_addr)
);

mux2x1 mux_pushpop(
    .in0(sp_out),
    .in1(sp_next),
    .sel(push_pop_sel),
    .out(stack_addr)
);
mux2x1 mux_jump_src(
    .in0({5'b0, jump_pc}),
    .in1(mem_data),
    .sel(ret_en),
    .out(jump_addr_final)
);

stack_pointer sp0(
    .clk(clk),
    .rst(rst),
    .in(sp_next),
    .wr_en(push_en || pop_en),
    .out(sp_out)
);

add_sub sp_adder0(
    .in1(sp_out),
    .in2(8'd1),
    .aos(push_en),
    .out(sp_next)
);




endmodule