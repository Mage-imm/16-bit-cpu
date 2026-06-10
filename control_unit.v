module control_unit (
    input  [15:0] adress_control,
    input         zero,
    output reg        regfile_write,
    output reg [2:0]  rs1_regfile,
    output reg [2:0]  rs2_regfile,
    output reg [2:0]  rd_regfile,
    output reg [7:0]  alu_imm,
    output reg [7:0]  adr_imm,
    output reg [2:0]  alu_op,
    output reg [10:0] jump_pc,
    output reg [10:0] branch_imm,
    output reg        jump_en,
    output reg        halt,
    output reg        branch_en,
    output reg        write_data,
    output reg        read_data,
    output reg        s1,s2,s3
);

    always @(*) begin
        regfile_write = 1'b0;
        halt          = 1'b0;
        jump_en       = 1'b0;
        branch_en     = 1'b0;
        write_data    = 1'b1;
        read_data     = 1'b1;
        s1            = 1'b0;
        s2            = 1'b0;
        s3            = 1'b0;
        alu_op        = 3'b000;
        rs1_regfile   = 3'b0;
        rs2_regfile   = 3'b0;
        rd_regfile    = 3'b0;
        adr_imm       = 8'b0;
        alu_imm       = 8'b0;
        jump_pc       = 11'b0;
        branch_imm    = 11'b0;

        case(adress_control[15:11])
            5'b00000: begin // ADD
                rs1_regfile   = adress_control[2:0];
                rs2_regfile   = adress_control[5:3];
                rd_regfile    = adress_control[8:6];
                regfile_write = 1'b1;
                alu_op        = 3'b000;
                write_data    = 1'b1;
                s3            = 1'b1;
                s2            = 1'b0;
            end
            5'b00001: begin // SUB
                rs1_regfile   = adress_control[2:0];
                rs2_regfile   = adress_control[5:3];
                rd_regfile    = adress_control[8:6];
                regfile_write = 1'b1;
                alu_op        = 3'b001;
                write_data    = 1'b1;
                s3            = 1'b1;
                s2            = 1'b0;
            end
            5'b00010: begin // MUL
                rs1_regfile   = adress_control[2:0];
                rs2_regfile   = adress_control[5:3];
                rd_regfile    = adress_control[8:6];
                regfile_write = 1'b1;
                alu_op        = 3'b010;
                write_data    = 1'b1;
                s3            = 1'b1;
                s2            = 1'b0;
            end
            5'b00011: begin // AND
                rs1_regfile   = adress_control[2:0];
                rs2_regfile   = adress_control[5:3];
                rd_regfile    = adress_control[8:6];
                regfile_write = 1'b1;
                alu_op        = 3'b011;
                write_data    = 1'b1;
                s3            = 1'b1;
                s2            = 1'b0;
            end
            5'b00100: begin // OR
                rs1_regfile   = adress_control[2:0];
                rs2_regfile   = adress_control[5:3];
                rd_regfile    = adress_control[8:6];
                regfile_write = 1'b1;
                alu_op        = 3'b100;
                write_data    = 1'b1;
                s3            = 1'b1;
                s2            = 1'b0;
            end
            5'b00101: begin // XOR
                rs1_regfile   = adress_control[2:0];
                rs2_regfile   = adress_control[5:3];
                rd_regfile    = adress_control[8:6];
                regfile_write = 1'b1;
                alu_op        = 3'b101;
                write_data    = 1'b1;
                s3            = 1'b1;
                s2            = 1'b0;
            end
            5'b10000: begin // ADDI
                alu_imm       = adress_control[7:0];
                rs1_regfile   = adress_control[10:8];
                rd_regfile    = adress_control[10:8];
                regfile_write = 1'b1;
                alu_op        = 3'b000;
                write_data    = 1'b1;
                s3            = 1'b0;
                s2            = 1'b0;
            end
            5'b10001: begin // SUBI
                alu_imm       = adress_control[7:0];
                rs1_regfile   = adress_control[10:8];
                rd_regfile    = adress_control[10:8];
                regfile_write = 1'b1;
                alu_op        = 3'b001;
                write_data    = 1'b1;
                s3            = 1'b0;
                s2            = 1'b0;
            end
            5'b10010: begin // LOAD
                rd_regfile    = adress_control[10:8];
                regfile_write = 1'b1;
                adr_imm       = adress_control[7:0];
                write_data    = 1'b1;
                read_data     = 1'b0;
                s2            = 1'b1;
            end
            5'b10011: begin // STORE
                rs1_regfile   = adress_control[10:8];
                regfile_write = 1'b0;
                adr_imm       = adress_control[7:0];
                write_data    = 1'b0;
                read_data     = 1'b1;
                s1            = 1'b0;
            end
            5'b10111: begin // JMP
                jump_en       = 1'b1;
                jump_pc       = adress_control[10:0];
            end
            5'b11000: begin // BEQ
                rs1_regfile   = adress_control[10:8];
                rs2_regfile   = 3'b000;
                alu_op        = 3'b001;
                branch_en     = zero;
                branch_imm    = adress_control[10:0];
            end
            5'b11111: begin // HLT
                halt          = 1'b1;
            end
            default: begin
                regfile_write = 1'b0;
                halt          = 1'b0;
            end
        endcase
    end

endmodule