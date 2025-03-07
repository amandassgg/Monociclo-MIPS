//Datapath do Monociclo
//Amanda Sousa Gonçalves - polo UFC
//Projeto de Arquitetura e Organização de Sistemas Digitais

module datapath(
    input clk,
    input reset,
    input [31:0] instruction,
    input [31:0] mem_read_data,
    input RegDst,
    input ALUSrc,
    input MemtoReg,
    input RegWrite,
    input Branch,
    input [3:0] ALUControl,
    output reg [31:0] pc_out,
    output [31:0] alu_result,
    output [31:0] write_data  
);
  
    reg [31:0] PC;
    

    wire [4:0] rs, rt, rd;
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    
    // Instanciação do módulo SignExtend para o imediato
    wire [31:0] sign_ext;
    signextend se (
        .in(instruction[15:0]),
        .out(sign_ext)
    );
    
    // Instanciação do Multiplexador para escolher o registrador de escrita
    wire [4:0] write_reg;
    mux2to1 #(5) mux_write_reg (
        .in0(rt),
        .in1(rd),
        .sel(RegDst),
        .out(write_reg)
    );
    
    // Instanciação do Multiplexador para selecionar o dado a ser escrito (ALU ou memória)
    wire [31:0] write_back;
    mux2to1 mux_write_back (
        .in0(alu_result),
        .in1(mem_read_data),
        .sel(MemtoReg),
        .out(write_back)
    );
    
    // Instanciação do banco de registradores (Register File) com reset
    wire [31:0] reg_data1, reg_data2;
    register_file rf (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .read_reg1(rs),
        .read_reg2(rt),
        .write_reg(write_reg),
        .write_data(write_back),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );
    
    // Multiplexador para seleção da segunda entrada da ALU
    wire [31:0] alu_in2;
    mux2to1 mux_alu_in2 (
        .in0(reg_data2),
        .in1(sign_ext),
        .sel(ALUSrc),
        .out(alu_in2)
    );
    
    // Instanciação da ALU
    wire zero;
    alu alu_inst (
        .a(reg_data1),
        .b(alu_in2),
        .ALUControl(ALUControl),
        .result(alu_result),
        .zero(zero)
    );
    
    // Instanciação do adder para calcular PC + 4
    wire [31:0] pc_plus4;
    adder add_pc (
        .in1(PC),
        .in2(32'd4),
        .sum(pc_plus4)
    );
    
    // Cálculo do deslocamento para branch 
    wire [31:0] sign_ext_shifted;
    assign sign_ext_shifted = sign_ext << 2;
    
    // Instanciação do Adder para calcular o endereço de branch: PC+4 + (imediato << 2)
    wire [31:0] branch_addr;
    adder add_branch (
        .in1(pc_plus4),
        .in2(sign_ext_shifted),
        .sum(branch_addr)
    );
    
    // Sinal de saída para escrita na memória 
    assign write_data = reg_data2;
    
    // Lógica de atualização do PC
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 0;
        else begin
            if (Branch && zero)
                PC <= branch_addr;
            else
                PC <= pc_plus4;
        end
    end
    
    // Atribuição do PC à saída para monitoramento
    always @(*) begin
        pc_out = PC;
    end
endmodule

//Partes do datapath

module register_file(
    input clk,
    input reset,
    input RegWrite,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] registers [0:31];
    integer i;
    
    // Leitura assíncrona
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];
    
    // Escrita síncrona com reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Zera os registradores
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end else if (RegWrite && write_reg != 5'b00000) begin
            registers[write_reg] <= write_data;
        end
    end
endmodule

module adder(
    input [31:0] in1,
    input [31:0] in2,
    output [31:0] sum
);
    assign sum = in1 + in2;
endmodule

module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] ALUControl,
    output reg [31:0] result,
    output zero
);
    always @(*) begin
        case(ALUControl)
            4'b0010: result = a + b; 
            4'b0110: result = a - b; 
            default: result = 32'b0;
        endcase
    end
    assign zero = (result == 0);
endmodule

module mux2to1 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] in0,
    input [WIDTH-1:0] in1,
    input sel,
    output [WIDTH-1:0] out
);
    assign out = (sel) ? in1 : in0;
endmodule

module signextend(
    input [15:0] in,
    output [31:0] out
);
    assign out = {{16{in[15]}}, in};
endmodule
