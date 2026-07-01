module mem_wb (
    // --- INPUTS ---
    input               clk, 
    input               rst,
    
    
    // Data Signals (Only what the Register File needs)
    input [15:0]        reg_wb_in,
    input [2:0]         rd_regfile_in,
    
    // Control Signals (Only what the Register File needs)
    input               regfile_write_in,
    // --- OUTPUTS ---
    output reg [15:0]   reg_wb_out,
    output reg [2:0]    rd_regfile_out,
    
    
    output reg          regfile_write_out
);

    always @(posedge clk) begin
        if (rst) begin
            // 1. GLOBAL RESET: Clear everything to 0
            reg_wb_out          <= 16'b0;
            rd_regfile_out      <= 3'b0;
            
            regfile_write_out   <= 1'b0;
         
        end
    
            
         else begin
            // 2. NORMAL OPERATION: Pass inputs to outputs
            reg_wb_out          <= reg_wb_in;
            rd_regfile_out      <= rd_regfile_in;
            
            regfile_write_out   <= regfile_write_in;
            
           
        end
    end

endmodule