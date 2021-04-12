//Module for Datapath for R-type/ I-type
//Name: Deepta Devkota
//Roll_No: 191CS117
//Date: 27-03-2021
module Datapath_R_I (read_data_1, read_data2, zero, ALU_result, overflow, register_1, register_2, write_register, ALUSrc, imm, 
                 RegWrite, ALU_CO, clk);
    //input
    input [5:0] register_1, register_2, write_register;
    input RegWrite;
    input clk;
    input [11:0] imm;
    input ALUSrc;
    input [3:0] ALU_CO;

    //wire
    wire reg [63:0] imm_extend;
    wire reg [63:0] read_data_2;
    wire reg [63:0] write_data;

    //64-bit 32 registers
    reg [63:0] registers[32:0];

    //output
    output  zero;
    output [63:0] ALU_result;
    output overflow;
    output [63:0] read_data_1, read_data2;

    integer  i;

    //initialzing registers
    initial begin
        for(i=0;i<64;i++)
            registers[i] = 0;
    end
    // assign registers[register_1]=15;
    // assign registers[register_1]=12;

    assign read_data_1 = registers[register_1];     //read register1 value
    assign read_data_2 = registers[register_2];     //read register2 value
    assign imm_extend = {{52{imm[11]}},imm[11:0]};      //extend 32-bit immediate to 64 bits
    assign read_data2 = (ALUSrc==1) ? imm_extend : read_data_2;    //assign read_data2 as per R-type or I-type instruction

    //instantiate ALU to perform the arithmetic operation
    ALU_64_bit alu_unit(ALU_result, zero, overflow, ALU_CO, read_data_1, read_data2);

    always @(posedge clk)
	begin
		if (RegWrite == 1)   
		begin
			registers[write_register] <= ALU_result;  //write back value in write_register
		end
	end

endmodule
