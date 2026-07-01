    `include "pc.v"

    module pc_tb;

        reg    clk;
        reg        rst;
        reg        halt;
        reg        jump_en;
        reg        branch_en;
        reg [15:0] jump_addr;
        reg [15:0] branch_addr;
        wire [15:0] pc_out;

        pc uut(.clk(clk),.rst(rst),.halt(halt),.jump_en(jump_en),.branch_en(branch_en),.jump_addr(jump_addr),.branch_addr(branch_addr),.pc_out(pc_out));
    

        initial clk = 0;
        always #5 clk = ~clk;
        initial begin
            
            $dumpfile("pc.vcd");
            $dumpvars(0, pc_tb);
        end

        initial begin
rst       = 1;
        halt      = 0;
        jump_en   = 0;
        branch_en = 0;
        jump_addr  = 16'd0;
        branch_addr = 16'd0;

        // ── test 1: reset ──────────────────
        $display("TEST 1: Reset");
        rst = 1;
        @(posedge clk); #1;
        $display("  PC after reset = %0d (expected 0)", pc_out);

        // ── test 2: normal increment ───────
        $display("TEST 2: Normal increment");
        rst = 0;
        repeat(5) begin
            @(posedge clk); #1;
            $display("  PC = %0d", pc_out);
        end

        // ── test 3: jump ───────────────────
        $display("TEST 3: Jump to 50");
        jump_addr = 16'd50;
        jump_en   = 1;
        @(posedge clk); #1;
        $display("  PC after jump = %0d (expected 50)", pc_out);
        jump_en = 0;

        // ── test 4: branch ─────────────────
        $display("TEST 4: Branch to 20");
        branch_addr = 16'd20;
        branch_en   = 1;
        @(posedge clk); #1;
        $display("  PC after branch = %0d (expected 20)", pc_out);
        branch_en = 0;

        // ── test 5: halt ───────────────────
        $display("TEST 5: Halt");
        halt = 1;
        repeat(3) begin
            @(posedge clk); #1;
            $display("  PC while halted = %0d (should not change)", pc_out);
        end
        halt = 0;

        $display("All tests done");
        end




    endmodule