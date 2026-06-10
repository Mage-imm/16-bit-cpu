module data_mem (
    input [15:0] addrr_data,
    input[15:0] wr_data,
    input wr_en,
    input read_en,
    output reg [15:0] data
);
    reg [15:0] registers [0:255];

    always @(*) begin
        if(!wr_en && !read_en) begin //write enable = 0
            registers[addrr_data[7:0]] = wr_data;
        end
        else if(read_en ) begin
            data = registers[addrr_data];
        end
        else begin
            data = 16'd0;
        end
    end



    
endmodule