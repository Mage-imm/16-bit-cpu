`include "cpu.v"

module cpu_tb;

    reg clk;
    reg rst;

    cpu uut(
        .clk(clk),
        .rst(rst)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu_tb);
    end

    initial begin
        rst = 1;
        #10;
        rst = 0;
        // your program runs here, just let the clock run
        #500;
        $finish;
    end

endmodule