`include "instruction_mem.v"


module instruction_mem_tb ;
    reg [15:0] addr;
    wire [15:0] inst;

    instruction_mem uut(.addr(addr),.inst(inst));

    initial begin
        $dumpfile("ins_mem.vcd");
        $dumpvars(0, instruction_mem_tb);
    end

    initial begin
        addr = 16'd0;
        #10;
        addr = 16'd1;
        #10;
        addr = 16'd2;
        #10;
        addr = 16'd3;
        #10;
        addr = 16'd4;
        #10;
        addr = 16'd255;
        #10;
        addr = 16'd256;
        #10;
    end




endmodule