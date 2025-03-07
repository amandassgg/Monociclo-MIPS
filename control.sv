//Controle geral - monociclo
//Amanda Sousa Gonçalves - polo UFC
//Projeto de Arquitetura e Organização de Sistemas Digitais
module control (
    input [5:0] opcode,
    input [5:0] funct,
    output RegDst,
    output ALUSrc,
    output MemtoReg,
    output RegWrite,
    output MemRead,
    output MemWrite,
    output Branch,
    output [1:0] ALUOp,
    output [3:0] ALUControl
);
    wire [1:0] aluOp_signal;
    
    // Instanciação do main_control
    main_control main_control (
        .opcode(opcode),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(aluOp_signal)
    );
    
    // Instanciação do ALU_control
    ALU_control alu_control (
        .ALUOp(aluOp_signal),
        .funct(funct),
        .ALUControl(ALUControl)
    );
    
    assign ALUOp = aluOp_signal; // Repasse opcional do sinal ALUOp se necessário
endmodule
