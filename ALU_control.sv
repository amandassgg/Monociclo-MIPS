//Controle da ULA - monociclo
//Amanda Sousa Gonçalves - polo UFC
//Projeto de Arquitetura e Organização de Sistemas Digitais

module ALU_control(
    input [1:0] ALUOp,
    input [5:0] funct,
    output reg [3:0] ALUControl
);
    always @(*) begin
        case(ALUOp)
            2'b00: ALUControl = 4'b0010; // para operações LW e SW, adição
            2'b01: ALUControl = 4'b0110; // para BEW, adição
            2'b10: begin                // para operaçoes do tipo R, depende.
                case(funct)
                    6'b100000: ALUControl = 4'b0010; // ADD
                    6'b100010: ALUControl = 4'b0110; // SUB
                    default:   ALUControl = 4'b0000;
                endcase
            end
            default: ALUControl = 4'b0000;    
        endcase
    end
endmodule
