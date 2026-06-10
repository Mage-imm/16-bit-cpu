module mux2x1 (
    input  wire [15:0] in0,
    input  wire [15:0] in1,
    input  wire        sel,
    output wire [15:0] out
);

    assign out = sel ? in1 : in0;

endmodule