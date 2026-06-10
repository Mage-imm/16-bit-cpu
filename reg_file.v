
module reg_file (
    input  wire        clk,
    input  wire        rst,
    input  wire        reg_write,
    input  wire [2:0]  rs1_addr,
    input  wire [2:0]  rs2_addr,
    input  wire [2:0]  rd_addr,
    input  wire [15:0] wr_data,
    output wire [15:0] rs1_data,
    output wire [15:0] rs2_data
);

    reg [15:0] registers [0:7];
    integer i;

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1)
                registers[i] <= 16'd0;
        end
        else if (reg_write && rd_addr != 3'd0) begin
            registers[rd_addr] <= wr_data;
        end
        else begin
            registers[0] <= 16'd0;
        end
    end

    assign rs1_data = registers[rs1_addr];
    assign rs2_data = registers[rs2_addr];

endmodule