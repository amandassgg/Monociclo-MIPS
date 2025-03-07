//Topo do Monociclo
//Amanda Sousa Gonçalves - polo UFC
//Projeto de Arquitetura e Organização de Sistemas Digitais

module monociclo_top (
    input clk,
    input reset
);
    // Fios de interconexão
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] alu_result;
    wire [31:0] write_data;     // Dado a ser escrito na memória (originado do registrador Rt)
    wire [31:0] mem_read_data;  // Dado lido da memória de dados

    // Sinais de controle
    wire RegDst;
    wire ALUSrc;
    wire MemtoReg;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire Branch;
    wire [1:0] ALUOp;
    wire [3:0] ALUControl;
    
    // Instanciação da memória de instruções
    instr_memory instructions (
        .addr(pc),
        .instruction(instruction)
    );
    
    // Instanciação do módulo de controle (que internamente instancia main_control e ALU_control)
    control control_c (
        .opcode(instruction[31:26]),
        .funct(instruction[5:0]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );
    
    // Instanciação do datapath, que reúne os
    datapath datapath_d (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .mem_read_data(mem_read_data),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .Branch(Branch),
        .ALUControl(ALUControl),
        .pc_out(pc),
        .alu_result(alu_result),
        .write_data(write_data)
    );
    
    // Instanciação da memória de dados
    data_memory memory (
        .clk(clk),
        .addr(alu_result),
        .write_data(write_data),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .read_data(mem_read_data)
    );
    
endmodule
