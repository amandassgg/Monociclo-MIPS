//Memória de dados - monociclo
//Amanda Sousa Gonçalves - polo UFC
//Projeto de Arquitetura e Organização de Sistemas Digitais
module data_memory(
    input clk,
    input [31:0] addr,
    input [31:0] write_data,
    input MemRead,
    input MemWrite,
    output reg [31:0] read_data
);
    reg [31:0] mem [0:15];
    integer i;
    
    initial begin
        // Inicializa toda a memória com zero
        for(i = 0; i < 16; i = i + 1)
            mem[i] = 0;
        // Pré-carrega alguns dados para teste com LW
        mem[0] = 32'd5;  // Endereço 0 (0x0000_0000)
        mem[1] = 32'd20;  // Endereço 4 (0x0000_0004)
        mem[2] = 32'd12;
        mem[3] = 32'd25;
    end
    
    always @(posedge clk) begin
        if (MemWrite)
            mem[addr[31:2]] <= write_data;
    end
    
    always @(*) begin
        if (MemRead)
            read_data = mem[addr[31:2]];
        else
            read_data = 32'b0;
    end
endmodule

