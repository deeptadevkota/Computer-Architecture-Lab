// Datapath for Load/Store 
//Name: Deepta Devkota
//Roll_No: 191CS117
//Date: 27-03-2021
module Datapath_ld_sd (read_data_1, read_data_2, zero, ALU_result, overflow, register_1, register_2, offset, 
                 clk, RegWrite, ALUSrc, ALU_CO, MemWrite, MemRead, MemReg);
    //input
    input [5:0] register_1, register_2;
    input clk;
    input [11:0] offset;
    input ALUSrc;
    input [3:0] ALU_CO;
    input RegWrite;
    input MemWrite;
    input MemRead;
    input MemReg;

    //wire
    wire reg [63:0] offset_extend;
    wire reg [63:0] write_data;

    //64-bit 32 registers and data memory
    reg [63:0] registers[32:0];
    reg [63:0] memory[32:0];

    //output
    output  zero;
    output [63:0] ALU_result;
    output overflow;
    output [63:0] read_data_1, read_data_2;

    integer  i;

    //initializing registers and data memory
    initial begin
        for(i=0;i<32;i++) 
            registers[i] = i;
        for(i=0;i<32;i++)
            memory[i] = i;
    end

    assign read_data_1 = registers[register_1];       //read register1 value
    assign read_data_2 = registers[register_2];       //read register2 value
    assign offset_extend = {{52{offset[11]}},offset[11:0]};     //extend 32-bit offset to 64 bits

    //Instantiating ALU: adding offset
    ALU_64_bit alu_unit(ALU_result, zero, overflow, ALU_CO, read_data_1, offset_extend);
    
    always@(RegWrite, ALU_result, read_data_2) begin
        if(RegWrite) begin
            registers[register_2] = memory[ALU_result];   //load from memory onto register
        end else begin
            memory[ALU_result] = memory[read_data_2];     //store into memory
        end
    end

    

endmodule
