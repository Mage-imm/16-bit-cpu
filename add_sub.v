module add_sub (
 input [7:0] in1,in2,
 output  reg [7:0] out,
 input aos
 );

always @(*) begin
    if(aos == 1'b0) begin
        out = in1 + in2;
    end
    else begin
        out = in1-in2;
    end
    
end


endmodule