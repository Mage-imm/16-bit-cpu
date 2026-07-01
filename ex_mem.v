module ex_mem (
    input               clk, rst, flush,

    // Control Signals 
    input               s2_in,
    input               push_en_in,
    input               pop_en_in,
    input               regfile_write_in,
    input               ret_en_in,
    input               write_data_in,
    input               read_data_in,
   


    // Data Signals
    input [7:0]         sp_next_in,
    input [15:0]        alu_result_in, 
    input [2:0]         rd_regfile_in,
    input [7:0]         data_mem_address_in,
    input [15:0]        dm_wr_data_in,

    // --- OUTPUTS ---
    output reg          s2_out,
    output reg [7:0]         sp_next_out,
    output reg          push_en_out,
    output reg          pop_en_out,
    output reg          regfile_write_out,
    output reg          ret_en_out,
    output reg          write_data_out,
    output reg          read_data_out,
    output reg          halt_out,
    output reg [15:0]   alu_result_out,
    output reg [2:0]    rd_regfile_out,
    output reg [7:0]    data_mem_address_out,
    output reg [15:0]   dm_wr_data_out
);
always @(posedge clk) begin
    if (rst || flush) begin
        s2_out               <= 1'b0;
     
        push_en_out          <= 1'b0;
        pop_en_out           <= 1'b0;
        regfile_write_out    <= 1'b0;
        ret_en_out           <= 1'b0;
        write_data_out       <= 1'b1;
        read_data_out        <= 1'b0;
        sp_next_out          <= 8'b0;
        alu_result_out       <= 16'b0;
        rd_regfile_out       <= 3'b0;
        data_mem_address_out <= 8'b0;
        dm_wr_data_out       <= 16'b0;
    end

 

    else begin
        s2_out               <= s2_in;
      
        push_en_out          <= push_en_in;
        pop_en_out           <= pop_en_in;
        regfile_write_out    <= regfile_write_in;
        ret_en_out           <= ret_en_in;
        write_data_out       <= write_data_in;
        read_data_out        <= read_data_in;
        sp_next_out          <= sp_next_in;
        alu_result_out       <= alu_result_in;
        rd_regfile_out       <= rd_regfile_in;
        data_mem_address_out <= data_mem_address_in;
        dm_wr_data_out       <= dm_wr_data_in;
    end
end

endmodule