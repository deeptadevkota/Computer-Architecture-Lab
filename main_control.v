module Main_Control (Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite, OP);
    input [6:0] OP;

    output reg Branch;
    output reg MemRead;
    output reg MemtoReg;
    output reg [1:0] ALUop;
    output reg MemWrite;
    output reg ALUsrc;
    output reg RegWrite;

    wire reg [2:0] f;

    assign f[2] = OP[6]; 
    assign f[1] = OP[5]; 
    assign f[0] = OP[4]; 

    always@(OP) begin

        Branch = f[2] * f[1] * (!f[0]);
        MemRead = (!f[2]) * (!f[1]) * (!f[0]);
        MemtoReg = (!f[2]) * (!f[1]) * (!f[0]);
        ALUop[0] = f[2] * f[1] * (!f[0]);
        ALUop[1] = (!f[2]) * f[1] * f[0];
        MemWrite = (!f[2]) * f[1] * (!f[0]);
        ALUsrc = (!f[2]) * (!f[0]);
        RegWrite = (!f[2]) * (f[1] * f[0] + (!f[1]) * (!f[0]));

    end
    

endmodule