//Module for BEQ Datapath 
//Name: Deepta Devkota
//Roll_No: 191CS117
//Date: 27-03-2021
module Datapath_beq (new_PC, read_data_1, read_data_2, zero, ALU_result, overflow, register_1, register_2, imm, 
                 clk, RegWrite, ALUSrc, ALU_CO, old_PC);
    //inputs              
    input [5:0] register_1, register_2;
    input clk;
    input [11:0] imm;
    input [1:0] OP;
    input ALUSrc;
    input [3:0] ALU_CO;
    input RegWrite;
    input [63:0] old_PC;

    //wires
    wire reg [63:0] read_data2;
    wire reg [63:0] write_data;
    wire [63:0] imm_extend;

    //64-bit 32 registers
    reg [63:0] registers[32:0];

    //outputs
    output  zero;
    output [63:0] ALU_result;
    output overflow;
    output [63:0] read_data_1, read_data_2;
    output reg [63:0] new_PC;

    integer  i;

    //initializing the register values
    initial begin
        for(i=0;i<16;i++)
            registers[i] = i;
        for(i=16;i<32;i++)
            registers[i] = 32-i;
    end

    assign read_data_1 = registers[register_1];   //reading from register1
    assign read_data_2 = registers[register_2];   //reading from register2
    assign imm_extend = {{52{imm[11]}},imm[11:0]};    //sign extension to extend 32-bit immdeiate to 64 bits

    //instatiating ALU : Perform subtract
    ALU_64_bit alu_unit(ALU_result, zero, overflow, ALU_CO, read_data_1, read_data_2);

    always @(zero) begin
        if(zero==0)begin           
            new_PC = old_PC + imm_extend<<1;   //condition is true hence jumping to specified location
        end else begin
            new_PC = old_PC + 4;       //condition is false hence incrementing the PC
        end
    end

endmodule
