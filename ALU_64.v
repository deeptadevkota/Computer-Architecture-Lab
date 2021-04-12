//64 bit ALU
// Extended version of 1-bit ALU to perform arithmetic operations on 64 bit numbers
// Name: Deepta Devkota 
//Roll_No: 191CS117 
//Date: 12-04-2021


module ALU_64_bit(result,zero,overflow,op,a, b);
     input [63:0] a, b;
     input [3:0] op;
     output reg [63:0] result;
     output reg zero,overflow;

     always@(a or b or op)
          begin
               case (op)
                    //0000 opcode corresponds to AND operation
                  0:  result = a&b; 
                    //0001 opcode corresponds to OR operation
                  1:  result=a|b;
                     //0010 opcode corresponds to ADD operation
                  2:  result = a+b;
                    //0110 opcode corresponds to SUB operation
                  6:  result = a-b;  
                     //1101 opcode corresponds to NAND operation
                  13: result=(~a)|(~b);
                     //1100 opcode corresponds to NOR operation
                  12: result=(~a)&(~b);
                    //0111 opcode corresponds to SLT operation
                  7:  result=a<b?1:0;
               endcase
               //zero flag is set when the result corresponds to zero
               zero=(result==0)?1:0;
               case (op)
                    //overflow occures during ADD and SUB operation
                    //when the both operands are positive but the result is negative or when the both operands are negative but the result is positive in ADD the overflow flag is set
                    2: overflow=((a>=0 && b>=0 && result<0)||(a<0 && b<0 && result>=0))?1:0;  
                    //when the first operand is positive the second operand is negative and the result is negative in SUB operation the overflow flag is set
                    //or when the first operand is negative the second operand is positive and the result is positive in SUB operation the overflow flag is set
                    6: overflow=((a>=0 && b<0 && result<0)||(a<0 && b>=0 && result>=0))?1:0;   
                    //default case  
                    default:overflow=0;
               endcase
          end
endmodule