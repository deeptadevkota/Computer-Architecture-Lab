// ALU Control Unit
// Generetes 4-bit output based on Op and Funct inputs which helps in selecting the required arithmetic/ memory/ BEQ operation
// Name: Deepta Devkota 
//Roll_No: 191CS117
//Date: 10-03-2021

module CU (ALU_CO, OP, func3,func7);

    input [1:0] OP;              //2 bit op input
    input [6:0] func7;  
    input [2:0] func3;         //6 bit funct input
    output reg [3:0] ALU_CO;     //4 bit control unit output


    always @(OP, func7,func3) begin
        case (OP)                // to check the required operation
            0 : ALU_CO = 2;      // load / store
            1 : ALU_CO = 6;      // BEQ
        endcase
        if (OP == 2 && func7==0 && func3==0) begin
            ALU_CO=2;
        end
        else if (OP==2 && func7==32 && func3==0) begin
            ALU_CO=6;
        end
        else if (OP==2 && func7==0 && func3==7) begin
            ALU_CO=0;
        end
        else if(OP==2 && func7==0 && func3==6) begin
            ALU_CO=1;
        end
    end

endmodule
