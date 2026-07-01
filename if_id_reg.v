module if_id_reg (
    input  wire        clk,
    input wire         flush,
    input  wire        rst,
    input  wire        stall,
    input  wire [15:0] pc_in,
    input  wire [15:0] inst_in,
    output reg  [15:0] pc_out,
    output reg  [15:0] inst_out,
    input halt
);
always @(posedge clk) begin
    if(rst) begin
        pc_out <= 16'd0;
        inst_out <= 16'd0;
    end

    else if (flush) begin
        pc_out <= 16'd0;
        inst_out <= 16'd0;
    end

    else if(stall || halt) begin
        pc_out <= pc_out;
        inst_out <= inst_out;
    end


    else begin
        pc_out <= pc_in;
        inst_out <= inst_in;
    end
end

    
endmodule