// MAIN Test bench
// Name: Deepta Devkota 
//Roll_No: 191CS117
//Date: 12-04-2021
module pipeline_tb();
    reg [63:0] old_PC;
    reg reset;
    reg clock;

    wire [1:0] ALUop;
    wire [63:0] ALU_result, ALU_result_1, ALU_result_2;
    wire [63:0] new_PC;
    wire[31:0] instruction;
    wire [6:0]OP;
    wire ALUsrc,MemtoReg,RegWrite,MemRead, MemWrite, Branch;

  Instruction_Fetch Ins_fetch(instruction,new_PC,old_PC,reset,clock);

    initial begin
        //INSTRUCTION FETCH
    
        $display("Pipeline:\n");
        old_PC = 64'd10;
        reset = 0;
        clock = 1;
        #5 $monitor("old_PC: %b\nreset: %b \nclock: %b\n instruction: %b", old_PC,reset,clock, instruction);
       
    end
        assign OP = instruction[6:0];
        Main_Control control_unit_1(Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite, OP);
        initial begin
         #15   $monitor("ALUop: %b, OP: %b",ALUop, OP);
        end

    wire [2:0]func3=instruction[14:12];
    wire [6:0]func7=instruction[31:25];
    wire [3:0] ALU_CO; 
  

    CU control_unit_2(ALU_CO, ALUop, func3,func7);
    initial begin
        #30 $monitor("func3: %b func7: %b\n", func3, func7);
    end

    wire [5:0]register_1, register_2, write_register;
    assign register_1=instruction[19:15];
    assign register_2=instruction[24:20];
    assign write_register=instruction[11:7];
    wire zero, overflow;
    wire [63:0] read_data_1, read_data_2;
    wire [11:0] imm=instruction[31:25];
    wire [11:0] imm_1={instruction[11:5],instruction[4:0]};

    Datapath_R_I data_path_R_I(read_data_1, read_data_2, zero, ALU_result, overflow, register_1, register_2, write_register, ALUsrc, imm, 
                 RegWrite, ALU_CO, clock);
    initial begin

        #5
        if(ALUsrc==1)
            $display("I-type instruction:\n");
        else
            $display("R-type instruction:\n");
       #40 $monitor("ALU result: %b\n", ALU_result);
    end


    // Datapath_beq data_path_beq(new_PC, read_data_1, read_data_2, zero, ALU_result_1, overflow, register_1, register_2, imm, 
    //              clock, RegWrite, ALUsrc, ALU_CO, old_PC);
    // initial begin

    //     #5
    //     $display("BEQ instruction:\n");
    //     #40 $monitor("new_PC: %b\n",new_PC);
    // end
 
 

    // Datapath_ld_sd datapath_ld_sd(read_data_1, read_data_2, zero, ALU_result_2, overflow, register_1, register_2, imm_1, 
    //              clock, RegWrite, ALUsrc, ALU_CO, MemWrite, MemRead, MemReg);
    // initial begin

    //     #5
    //     $display("Load/store instruction:\n");
        
    //     #40
    //     if(RegWrite==1)
    //        #55 $monitor("Data loaded onto register\n");
    //     else if(MemWrite==1)
    //        #60 $monitor("Data stored in memory\n");
    // end
    

endmodule