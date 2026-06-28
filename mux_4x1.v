module mux_4x1 (
    input[15:0] in0,in1,in2,in3,
    input s1,s2,
    output [15:0] out
);
    assign out = {s1,s2} == 2'b00 ? in0 :
             {s1,s2} == 2'b01 ? in1 :
             {s1,s2} == 2'b10 ? in2 :
                                in3;
endmodule