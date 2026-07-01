`include "reg_file.v"

module reg_file_tb;

    reg        clk;
    reg        rst;
    reg        reg_write;
    reg [3:0]  rs1_addr;
    reg [3:0]  rs2_addr;
    reg [3:0]  rd_addr;
    reg [15:0] wr_data;

    wire [15:0] rs1_data;
    wire [15:0] rs2_data;

    reg_file uut (
        .clk      (clk),
        .rst      (rst),
        .reg_write(reg_write),
        .rs1_addr (rs1_addr),
        .rs2_addr (rs2_addr),
        .rd_addr  (rd_addr),
        .wr_data  (wr_data),
        .rs1_data (rs1_data),
        .rs2_data (rs2_data)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("reg_file.vcd");
        $dumpvars(0, reg_file_tb);

    end

    initial begin
        rst = 1'b1;
        reg_write = 1'd0;
        rs1_addr = 4'd0;
        rs2_addr = 4'd0;
        rd_addr = 4'd0;
        wr_data = 16'd0;
        

        #10;
        rst = 1'b0;
        #10;

        reg_write = 1'b1;
        rd_addr = 4'd5;
        wr_data = 16'd42;
        rs1_addr = 4'd5;
        #10;

        $display("%0d(should be 42)",rs1_data);

        #10;

        reg_write = 1'b1;
        rd_addr = 4'd0;
        wr_data = 16'd42;
        rs2_addr = 4'd0;
        $display("%0d(should be 0)",rs2_data);
         #10;

        reg_write = 1'b0;
        rd_addr = 4'd5;
        wr_data = 16'd43;
        rs1_addr = 4'd5;

        $display("%0d(should be 42)",rs1_data);

         #10;

        reg_write = 1'b1;
        rd_addr = 4'd6;
        wr_data = 16'd10;
        rs2_addr = 4'd6;

        $display("%0d(should be 10)",rs2_data);
         #10;

      

        $display("%0d and %0d(should be 42 and 10)",rs1_data,rs2_data);

        $finish;





    end



endmodule