//Controle principal - monociclo
//Amanda Sousa Gonçalves - polo UFC
//Projeto de Arquitetura e Organização de Sistemas Digitais
module main_control(
    input [5:0] opcode,
    output reg RegDst,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg [1:0] ALUOp
);
    always @(*) begin
        case(opcode)
            6'b000000: begin // R-type 
                RegDst   = 1;
                ALUSrc   = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 0;
                ALUOp    = 2'b10;
            end
            6'b100011: begin // LW
                RegDst   = 0;
                ALUSrc   = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead  = 1;
                MemWrite = 0;
                Branch   = 0;
                ALUOp    = 2'b00;
            end
            6'b101011: begin // SW
                RegDst   = 0;  
                ALUSrc   = 1;
                MemtoReg = 0;  
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 1;
                Branch   = 0;
                ALUOp    = 2'b00;
            end
            6'b000100: begin // BEQ
                RegDst   = 0;  
                ALUSrc   = 0;
                MemtoReg = 0;  
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 1;
                ALUOp    = 2'b01;
            end
            default: begin
                RegDst   = 0;
                ALUSrc   = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemRead  = 0;
                MemWrite = 0;
                Branch   = 0;
                ALUOp    = 2'b00;
            end
        endcase
    end
endmodule
