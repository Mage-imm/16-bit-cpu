module alu (
    input  wire signed [15:0] a,
    input  wire signed [15:0] b,
    input  wire        [2:0]  alu_op,
    output reg  signed [15:0] result,
    output wire               zero
);

    always @(*) begin
        case (alu_op)
            3'b000: result = a + b;
            3'b001: result = a - b;
            3'b010: result = a * b;
            3'b011: result = a & b;
            3'b100: result = a | b;
            3'b101: result = a ^ b;
            default: result = 16'd0;
        endcase
    end

    assign zero = (result == 16'd0);

endmodule