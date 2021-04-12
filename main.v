//main module for data path

module pipeline(new_PC,old_PC,reset,clock, ALUop, ALU_result);
    
    //INSTRCUTION FETCH MODULE INSTANTIATED

    input [63:0]old_PC;
    input reset;
    input clock;
    output [1:0] ALUop;
    output[63:0] ALU_result;
    
    //output alu op
    //alu result

    wire [31:0] instruction;
    output [63:0] new_PC;
        
    Instruction_Fetch Ins_fetch(instruction,new_PC,old_PC,reset,clock);
    

    //INSTRUCTION IS FETCHED


    //ALU CONTROL UNIT MODULE INSTANTIATED

    wire [6:0]OP;
    assign OP = instruction[6:0];
   

    wire ALUsrc,MemtoReg,RegWrite,MemRead, MemWrite, Branch;

    Main_Control control_unit_1(Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite, OP);

    //CONTROL UNITS OBTAINED

    // ALU CONTROL UNIT

    wire [2:0]func3=instruction[14:12];
    wire [6:0]func7=instruction[31:25];
    wire [3:0] ALU_CO; 
  

    CU control_unit_2(ALU_CO, ALUop, func3,func7);

    //ALU CO Output obtained

    //rs1, rs2, rd

    wire [5:0]register_1, register_2, write_register;
    assign register_1=instruction[19:15];
    assign register_2=instruction[24:20];
    assign write_register=instruction[11:7];
    wire zero, overflow;
    wire [63:0] read_data_1, read_data_2;
    wire [11:0] imm=instruction[31:25];
    wire [11:0] imm_1={instruction[11:5],instruction[4:0]};

  

    Datapath_beq data_path_beq(new_PC, read_data_1, read_data_2, zero, ALU_result, overflow, register_1, register_2, imm, 
                 clock, RegWrite, ALUsrc, ALU_CO, old_PC);

    Datapath_R_I data_path_R_I(read_data_1, read_data_2, zero, ALU_result, overflow, register_1, register_2, write_register, ALUsrc, imm, 
                 RegWrite, ALU_CO, clock);

    Datapath_ld_sd datapath_ld_sd(read_data_1, read_data_2, zero, ALU_result, overflow, register_1, register_2, imm_1, 
                 clock, RegWrite, ALUsrc, ALU_CO, MemWrite, MemRead, MemReg);
    
endmodule 



