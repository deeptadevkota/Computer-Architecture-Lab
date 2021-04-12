
// test bench for MAIN control unit
// Name: Deepta Devkota 
//Roll_No: 191CS117
//Date: 12-04-2021

module Main_control_TB();
    reg [6:0] OP;

    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [1:0] ALUop;
    wire MemWrite;
    wire ALUsrc;
    wire RegWrite;

    Main_Control get_cu_op(Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite, OP);

    initial begin
        
        #5
        $display("output\n");

        #5
        OP = 51;
        $monitor($time, ". OP: %b Branch: %b MemRead: %b MemtoReg: %b ALUop: %b MemWrite: %b ALUsrc: %b RegWrite: %b\n",OP,Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite);

        #5
        OP = 3;
        $monitor($time, ". OP: %b Branch: %b MemRead: %b MemtoReg: %b ALUop: %b MemWrite: %b ALUsrc: %b RegWrite: %b\n",OP,Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite);

        #5
        OP = 35;
        $monitor($time, ". OP: %b Branch: %b MemRead: %b MemtoReg: %b ALUop: %b MemWrite: %b ALUsrc: %b RegWrite: %b\n",OP,Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite);

        #5
        OP = 'b1100011;
        $monitor($time, ". OP: %b Branch: %b MemRead: %b MemtoReg: %b ALUop: %b MemWrite: %b ALUsrc: %b RegWrite: %b\n",OP,Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite);

        
    end
endmodule