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

assign stall = 1'b0;
assign flush = 1'b0;




// IF/ID outputs
wire [15:0] pc_id, inst_id;

//IDEX outputs

wire        id_ex_regfile_write;
wire        id_ex_ret_en;
wire [15:0] id_ex_rs1_data;
wire [15:0] id_ex_rs2_data;
wire [15:0] id_ex_pc;
wire [2:0]  id_ex_rd_regfile;
wire [7:0]  id_ex_alu_imm;
wire [7:0]  id_ex_adr_imm;
wire [2:0]  id_ex_alu_op;

wire [10:0] id_ex_branch_imm;

wire        id_ex_halt;
wire        id_ex_branch_en;
wire        id_ex_write_data;
wire        id_ex_read_data;
wire        id_ex_s1;
wire        id_ex_s2;
wire        id_ex_s3;
wire        id_ex_s4;
wire        id_ex_s5;
wire        id_ex_push_en;
wire        id_ex_pop_en;
wire        id_ex_push_pop_sel;


// ex_mem outputs
wire        ex_mem_s2;
wire [7:0]  ex_mem_sp_next;
wire        ex_mem_push_en;
wire        ex_mem_pop_en;
wire        ex_mem_regfile_write;
wire        ex_mem_ret_en;
wire        ex_mem_write_data;
wire        ex_mem_read_data;

wire [15:0] ex_mem_alu_result;
wire [2:0]  ex_mem_rd_regfile;
wire [7:0]  ex_mem_data_mem_address;
wire [15:0] ex_mem_dm_wr_data;

//mem_wb outputs

wire [15:0] mem_wb_reg_wb;
wire [2:0]  mem_wb_rd_regfile;
wire        mem_wb_regfile_write;


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
wire        ex_mem_halt;
wire        mem_wb_halt;

wire stall,flush;
wire branch_taken;


assign branch_taken = id_ex_branch_en & zero;

// IF STAGE

pc pc0(
    .clk(clk),
    .rst(rst),
    .jump_en(jump_en | ex_mem_ret_en),
    .branch_en(branch_taken),
    .halt(halt),
    .jump_addr(jump_addr_final),
    .branch_addr(id_ex_branch_imm),
    .pc_out(pc_out)
);
mux2x1 mux_jump_src(
    .in0({5'b0, jump_pc}),
    .in1(mem_data),
    .sel(ex_mem_ret_en),
    .out(jump_addr_final)
);

instruction_mem im0(
    .addr(pc_out),
    .inst(inst)
);

if_id_reg if_id0(
    .clk(clk),
    .rst(rst),
    .stall(stall),
    .pc_in(pc_out),
    .inst_in(inst),
    .pc_out(pc_id),
    .inst_out(inst_id),
    .flush(jump_en | branch_taken | ex_mem_ret_en),
    .halt(halt)
);

// ID STAGE


control_unit cu0(
    .adress_control(inst_id),
    
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




id_ex_reg id_ex_pipeline (
    .clk(clk),
    .rst(rst),
    .stall(stall),
    .flush(branch_taken | ex_mem_ret_en),

    // Inputs from ID stage
    .pc_in(pc_id),
    .regfile_write_in(regfile_write),
    .ret_en_in(ret_en),
    .rs1_data_in(rs1_data),
    .rs2_data_in(rs2_data),
    .rd_regfile_in(rd_regfile),
    .alu_imm_in(alu_imm),
    .adr_imm_in(adr_imm),
    .alu_op_in(alu_op),
    
    .branch_imm_in(branch_imm),
    
    .halt_in(halt),
    .branch_en_in(branch_en),
    .write_data_in(write_data),
    .read_data_in(read_data),
    .s1_in(s1),
    .s2_in(s2),
    .s3_in(s3),
    .s4_in(s4),
    .s5_in(s5),
    .push_en_in(push_en),
    .pop_en_in(pop_en),
    .push_pop_sel_in(push_pop_sel),

    // Outputs to EX stage
    .regfile_write_out(id_ex_regfile_write),
    .ret_en_out(id_ex_ret_en),
    .rs1_data_out(id_ex_rs1_data),
    .rs2_data_out(id_ex_rs2_data),
    .pc_out(id_ex_pc),
    .rd_regfile_out(id_ex_rd_regfile),
    .alu_imm_out(id_ex_alu_imm),
    .adr_imm_out(id_ex_adr_imm),
    .alu_op_out(id_ex_alu_op),
    
    .branch_imm_out(id_ex_branch_imm),
    
    
    .branch_en_out(id_ex_branch_en),
    .write_data_out(id_ex_write_data),
    .read_data_out(id_ex_read_data),
    .s1_out(id_ex_s1),
    .s2_out(id_ex_s2),
    .s3_out(id_ex_s3),
    .s4_out(id_ex_s4),
    .s5_out(id_ex_s5),
    .push_en_out(id_ex_push_en),
    .pop_en_out(id_ex_pop_en),
    .push_pop_sel_out(id_ex_push_pop_sel)
);




branch_adder b0(
    .pc_out(id_ex_pc),
    .branch_addr(branch_addr),
    .imm(id_ex_branch_imm)
);




reg_file rf0(
    .clk(clk),
    .rst(rst),
    .reg_write(mem_wb_regfile_write),
    .rs1_addr(rs1_regfile),
    .rs2_addr(rs2_regfile),
    .rd_addr(mem_wb_rd_regfile),
    .wr_data(mem_wb_reg_wb),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);

alu alu0(
    .a(id_ex_rs1_data),
    .b(alu_b),
    .alu_op(id_ex_alu_op),
    .result(alu_result),
    .zero(zero)
);
mux2x1 mux_s3(
    .in0({8'b0, id_ex_alu_imm}),
    .in1(id_ex_rs2_data),
    .sel(id_ex_s3),
    .out(alu_b)
);


ex_mem ex_mem_pipeline(
    .clk(clk),
    .rst(rst),
    .flush(ex_mem_ret_en),

    // Control
    .s2_in(id_ex_s2),
    
    .push_en_in(id_ex_push_en),
    .pop_en_in(id_ex_pop_en),
    .regfile_write_in(id_ex_regfile_write),
    .ret_en_in(id_ex_ret_en),
    .write_data_in(id_ex_write_data),
    .read_data_in(id_ex_read_data),

    // Data
    .sp_next_in(sp_next),
    .alu_result_in(alu_result),
    .rd_regfile_in(id_ex_rd_regfile),
    .data_mem_address_in(data_mem_addr),
    .dm_wr_data_in(dm_wr_data),

    // Outputs
    .s2_out(ex_mem_s2),
    .sp_next_out(ex_mem_sp_next),
    .push_en_out(ex_mem_push_en),
    .pop_en_out(ex_mem_pop_en),
    .regfile_write_out(ex_mem_regfile_write),
    .ret_en_out(ex_mem_ret_en),
    
    .write_data_out(ex_mem_write_data),
    .read_data_out(ex_mem_read_data),

    .alu_result_out(ex_mem_alu_result),
    .rd_regfile_out(ex_mem_rd_regfile),
    .data_mem_address_out(ex_mem_data_mem_address),
    .dm_wr_data_out(ex_mem_dm_wr_data)
);


data_mem dm0(
    .addrr_data(ex_mem_data_mem_address),
    .wr_data(ex_mem_dm_wr_data),
    .wr_en(ex_mem_write_data),
    .read_en(ex_mem_read_data),
    .data(mem_data)
);

mux2x1 mux_s4(
    .in0(stack_addr),
    .in1(id_ex_adr_imm),
    .sel(id_ex_s4),
    .out(data_mem_addr)
);

add_sub sp_adder0(
    .in1(sp_out),
    .in2(8'd1),
    .aos(id_ex_push_en),
    .out(sp_next)
);

mem_wb mem_wb_pipeline(
    .clk(clk),
    .rst(rst),

    .reg_wb_in(wb_data),
    .rd_regfile_in(ex_mem_rd_regfile),
    .regfile_write_in(ex_mem_regfile_write),
    

    .reg_wb_out(mem_wb_reg_wb),
    .rd_regfile_out(mem_wb_rd_regfile),
    .regfile_write_out(mem_wb_regfile_write)
    
);



call_addr call0(
    .pc(id_ex_pc),
    .pc_next(pc_next)
)
;

mux_4x1 mux_s1(
    .in0(id_ex_rs2_data),
    .in1(alu_result),
    .in2(pc_next),
    .in3(id_ex_rs1_data),
    .s1(id_ex_s1),
    .s2(id_ex_s5),
    .out(dm_wr_data)
);

mux2x1 mux_s2(
    .in0(ex_mem_alu_result),
    .in1(mem_data),
    .sel(ex_mem_s2),
    .out(wb_data)
);





mux2x1 mux_pushpop(
    .in0(sp_out),
    .in1(sp_next),
    .sel(id_ex_push_pop_sel),
    .out(stack_addr)
);


stack_pointer sp0(
    .clk(clk),
    .rst(rst),
    .in(ex_mem_sp_next),
    .wr_en(ex_mem_push_en || ex_mem_pop_en),
    .out(sp_out)
);






endmodule