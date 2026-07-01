`include "cpu.v"

module cpu_tb;

    reg clk;
    reg rst;
    integer i;
    integer cycle;

    cpu uut(
        .clk(clk),
        .rst(rst)
    );

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk;

    // VCD Dump
    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu_tb);
    end

    // Reset
    initial begin
        rst = 1;
        cycle = 0;

        #10;
        rst = 0;
    end

    // Monitor CPU every clock
    initial begin
        @(negedge rst);

        repeat (15) begin
            @(posedge clk);

            $display("\n==================================================");
            $display("Cycle %0d", cycle);
            $display("PC           = %h", uut.pc_out);
            $display("Instruction  = %h", uut.inst);

            $display("\nRegisters:");
            for(i = 0; i < 8; i = i + 1)
                $display("R%0d = %h", i, uut.rf0.registers[i]);

            $display("\nPipeline:");
            $display("IF/ID  PC     = %h", uut.pc_id);
            $display("IF/ID  INST   = %h", uut.inst_id);

            $display("ID/EX  PC     = %h", uut.id_ex_pc);
            $display("ALU Result    = %h", uut.alu_result);
            $display("MEM ALU       = %h", uut.ex_mem_alu_result);
            $display("WB Data       = %h", uut.wb_data);

            $display("\nMemory:");
            $display("SP            = %h", uut.sp_out);
            $display("Stack Addr    = %h", uut.stack_addr);

            cycle = cycle + 1;
        end

        $finish;
    end

endmodule