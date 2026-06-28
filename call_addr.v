module call_addr (
    input [15:0]pc,
    output [15:0]pc_next  
);


assign pc_next = pc+1;

endmodule