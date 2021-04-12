module pipeline_tb();
    reg [63:0] old_PC;
    reg reset;
    reg clock;

    wire [1:0] ALUop;
    wire [63:0] ALU_result;
    wire [63:0] new_PC;

    pipeline pipeline_ins(new_PC,old_PC,reset,clock,ALUop, ALU_result);

    initial begin
        
    
        $display("Pipeline:\n");

    
        old_PC = 64'd0;
        reset = 0;
        clock = 1;
        $monitor("old_PC: %b \nnew_PC: %b \nreset: %b \nclock: %b \nALUop: %b \nALU_result: %b", old_PC,new_PC,reset,clock, ALUop, ALU_result);

    end

endmodule