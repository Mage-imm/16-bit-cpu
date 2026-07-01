module id_ex_reg (
    input clk,rst,stall,flush,
    input [15:0]pc_in,

    input        regfile_write_in,
    input        ret_en_in,
    input [15:0]  rs1_data_in,
    input [15:0]  rs2_data_in,
    input [2:0]  rd_regfile_in,
    input [7:0]  alu_imm_in,
    input [7:0]  adr_imm_in,
    input [2:0]  alu_op_in,
    input [10:0] branch_imm_in,
    input        halt_in,
    input        branch_en_in,
    input        write_data_in,
    input        read_data_in,
    input        s1_in,s2_in,s3_in,s4_in,s5_in,
    input        push_en_in,
    input        pop_en_in,
    input        push_pop_sel_in,

    output reg        regfile_write_out,
    output reg        ret_en_out,
    output reg [15:0] rs1_data_out,
    output reg [15:0] pc_out,
    output reg [15:0] rs2_data_out,
    output reg [2:0]  rd_regfile_out,
    output reg [7:0]  alu_imm_out,
    output reg [7:0]  adr_imm_out,
    output reg [2:0]  alu_op_out,
    output reg [10:0] branch_imm_out,
    output reg        branch_en_out,
    output reg        write_data_out,
    output reg        read_data_out,
    output reg        s1_out,s2_out,s3_out,s4_out,s5_out,
    output reg        push_en_out,
    output reg        pop_en_out,
    output reg        push_pop_sel_out
);

always @(posedge clk) begin
    if (rst) begin
        regfile_write_out <= 1'b0;
        branch_en_out     <= 1'b0;
        write_data_out    <= 1'b1;
        read_data_out     <= 1'b0;
        s1_out            <= 1'b0;
        s2_out            <= 1'b0;
        s3_out            <= 1'b0;
        s4_out            <= 1'b0;
        s5_out            <= 1'b0;
        alu_op_out        <= 3'b000;
        rs1_data_out      <= 16'd0;
        rs2_data_out      <= 16'd0;
        rd_regfile_out    <= 3'b0;
        adr_imm_out       <= 8'b0;
        alu_imm_out       <= 8'b0;
        branch_imm_out    <= 11'b0;
        push_en_out       <= 1'b0;
        pop_en_out        <= 1'b0;
        push_pop_sel_out  <= 1'b0;
        ret_en_out        <= 1'b0;
        pc_out            <= 16'd0;
    end
    else if (halt_in) begin
        regfile_write_out <= regfile_write_out;
        branch_en_out     <= branch_en_out;
        write_data_out    <= write_data_out;
        read_data_out     <= read_data_out;
        s1_out            <= s1_out;
        s2_out            <= s2_out;
        s3_out            <= s3_out;
        s4_out            <= s4_out;
        s5_out            <= s5_out;
        alu_op_out        <= alu_op_out;
        rs1_data_out      <= rs1_data_out;
        rs2_data_out      <= rs2_data_out;
        rd_regfile_out    <= rd_regfile_out;
        adr_imm_out       <= adr_imm_out;
        alu_imm_out       <= alu_imm_out;
        branch_imm_out    <= branch_imm_out;
        push_en_out       <= push_en_out;
        pop_en_out        <= pop_en_out;
        push_pop_sel_out  <= push_pop_sel_out;
        ret_en_out        <= ret_en_out;
        pc_out            <= pc_out;
    end
    else if (flush) begin
        regfile_write_out <= 1'b0;
        branch_en_out     <= 1'b0;
        write_data_out    <= 1'b1;
        read_data_out     <= 1'b0;
        s1_out            <= 1'b0;
        s2_out            <= 1'b0;
        s3_out            <= 1'b0;
        s4_out            <= 1'b0;
        s5_out            <= 1'b0;
        alu_op_out        <= 3'b000;
        rs1_data_out      <= 16'd0;
        rs2_data_out      <= 16'd0;
        rd_regfile_out    <= 3'b0;
        adr_imm_out       <= 8'b0;
        alu_imm_out       <= 8'b0;
        branch_imm_out    <= 11'b0;
        push_en_out       <= 1'b0;
        pop_en_out        <= 1'b0;
        push_pop_sel_out  <= 1'b0;
        ret_en_out        <= 1'b0;
        pc_out            <= 16'd0;
    end
    else if (stall) begin
        regfile_write_out <= 1'b0;
        branch_en_out     <= 1'b0;
        write_data_out    <= 1'b1;
        read_data_out     <= 1'b0;
        s1_out            <= 1'b0;
        s2_out            <= 1'b0;
        s3_out            <= 1'b0;
        s4_out            <= 1'b0;
        s5_out            <= 1'b0;
        alu_op_out        <= 3'b000;
        rs1_data_out      <= 16'd0;
        rs2_data_out      <= 16'd0;
        rd_regfile_out    <= 3'b0;
        adr_imm_out       <= 8'b0;
        alu_imm_out       <= 8'b0;
        branch_imm_out    <= 11'b0;
        push_en_out       <= 1'b0;
        pop_en_out        <= 1'b0;
        push_pop_sel_out  <= 1'b0;
        ret_en_out        <= 1'b0;
        pc_out            <= 16'd0;
    end
    else begin
        regfile_write_out <= regfile_write_in;
        branch_en_out     <= branch_en_in;
        write_data_out    <= write_data_in;
        read_data_out     <= read_data_in;
        s1_out            <= s1_in;
        s2_out            <= s2_in;
        s3_out            <= s3_in;
        s4_out            <= s4_in;
        s5_out            <= s5_in;
        alu_op_out        <= alu_op_in;
        rs1_data_out      <= rs1_data_in;
        rs2_data_out      <= rs2_data_in;
        rd_regfile_out    <= rd_regfile_in;
        adr_imm_out       <= adr_imm_in;
        alu_imm_out       <= alu_imm_in;
        branch_imm_out    <= branch_imm_in;
        push_en_out       <= push_en_in;
        pop_en_out        <= pop_en_in;
        push_pop_sel_out  <= push_pop_sel_in;
        ret_en_out        <= ret_en_in;
        pc_out            <= pc_in;
    end
end

endmodule