module pc (
    input  wire        clk,
    input  wire        rst,
    input  wire        halt,
    input  wire        jump_en,
    input  wire        branch_en,
    input  wire [15:0] jump_addr,
    input  wire [15:0] branch_addr,
    output reg  [15:0] pc_out
);

    always @(posedge clk) begin
        if (rst) begin
            pc_out <= 16'd0;
        end
        else if (halt) begin
            pc_out <= pc_out;
        end
        else if (jump_en) begin
            pc_out <= jump_addr;
        end
        else if (branch_en) begin
            pc_out <= branch_addr;
        end
        else begin
            pc_out <= pc_out + 1;
        end
    end

endmodule