module instruction_mem (
    input  wire [15:0] addr,
    output wire [15:0] inst
);

    reg [15:0] mem [0:255];

    initial begin
        $readmemb("program.mem", mem);
    end

    assign inst = mem[addr[7:0]];

endmodule