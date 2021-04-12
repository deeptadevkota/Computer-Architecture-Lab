//MODULE FOR INSTRUCTION FETCH
//Name: Deepta Devkota
//Roll_No: 191CS117
//Date: 27-03-2021
module Instruction_Fetch(instruction,new_PC,old_PC,reset,clock);
    //old_PC stores the previous 64- bit program counter
    input [63:0] old_PC;
    input reset;
    input clock;
    //Instruction memory(text data) has 252 Mega byte memory, in this verilog code it is scaled up to 252 byte memory
    reg [31:0]I_MEM[0:251];
    //In RISCV we have 32 bit instruction
    output reg [31:0] instruction;
    //new_PC stores the updated value of the program counter
    output reg [63:0] new_PC;
    
    //only at the positive edge of the clock cycle
      always @(posedge clock)
            begin
                //hardcoded the contents of the Instruction memory
                
                //for Arithmatic operation
                I_MEM[old_PC>>2]= 4358579;

                //for beq
                // I_MEM[old_PC>>2]= 98;

                //for store
                // I_MEM[old_PC>>2]= 2129955;  

                //for load
                //I_MEM[old_PC>>2]= 2129923; 

                //fectching the 32 bit instruction located at old_PC>>2 byte
                instruction=I_MEM[old_PC>> 2];
                //if reset is 0 new_PC value is incremented by 4 bits
                //if reset value is set to the first intruction
                //the first instruction is located at 1X40 00000 address, its binary equivalent is 100 0000 0000 0000 0000 0000
                case (reset)
                    0:  new_PC=old_PC+4;
                    1:  new_PC=64'b10000000000000000000000 ;
               endcase
            end
endmodule
