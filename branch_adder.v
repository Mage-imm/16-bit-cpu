module branch_adder (
    input  wire [15:0] pc_out,
    input  wire [10:0]  imm,
    output wire [15:0] branch_addr
);

    assign branch_addr = pc_out + {{5{imm[7]}}, imm};

endmodule