`include "alu.v"

module alu_tb;

    reg  [15:0] a;
    reg  [15:0] b;
    reg  [2:0]  alu_op;

    wire [15:0] result;
    wire        zero;

    alu uut (
        .a      (a),
        .b      (b),
        .alu_op (alu_op),
        .result (result),
        .zero   (zero)
    );

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);
    end

    initial begin
        a = 16'd10;
        b = 16'd11;

        #10;
        alu_op = 3'b000;
        #10;
        $display("ADD      a=%0d b=%0d result=%0d (expected 21) zero=%0b", a, b, result, zero);

        alu_op = 3'b001;
        #10;
        $display("SUB      a=%0d b=%0d result=%0d (expected -1) zero=%0b", a, b, result, zero);

        alu_op = 3'b010;
        #10;
        $display("MUL      a=%0d b=%0d result=%0d (expected 110) zero=%0b", a, b, result, zero);

        alu_op = 3'b011;
        #10;
        $display("AND      a=%0d b=%0d result=%0d (expected 10) zero=%0b", a, b, result, zero);

        alu_op = 3'b100;
        #10;
        $display("OR       a=%0d b=%0d result=%0d (expected 11) zero=%0b", a, b, result, zero);

        a = 16'd0;
        b = 16'd0;
        alu_op = 3'b000;
        #10;
        $display("ZERO     a=%0d b=%0d result=%0d (expected 0)  zero=%0b (expected 1)", a, b, result, zero);

        $finish;
    end

endmodule