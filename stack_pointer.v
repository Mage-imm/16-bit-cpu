    module stack_pointer (
        input rst,
        input clk,
        input [7:0] in,
        input wr_en,
        output reg [7:0] out

    );

    always @(posedge clk) begin
        if(rst) begin
            out <= 8'd255;

        end
        else if(wr_en) begin
            out <= in;
        end

        else begin
            out <= out;
        end
        
        
    end


        
    endmodule