//Memória de instruções - monociclo
//Amanda Sousa Gonçalves - polo UFC
//Projeto de Arquitetura e Organização de Sistemas Digitais
module instr_memory(
    input [31:0] addr,
    output reg [31:0] instruction
);
    // ROM com 16 posições
    reg [31:0] rom [0:15];
    
    initial begin
        // Instruções em hexadecimal
        rom[0] = 32'h8C080000; //lw $t0, 0($zero) 
        rom[1] = 32'h8C090004; //lw $t1, 4($zero) 
        rom[2] = 32'h01095020; //add $t2, $t0, $t1
        rom[3] = 32'hAC0A0008; //sw $t2, 8($zero)
        rom[4] = 32'h01285822; //sub $t3, $t1, $t0
        rom[5] = 32'h012C6022; //sub $t4, $t1, $t3
        rom[6] = 32'h1108FFFE; //beq $t0, $t0, -2
        // Outras posições que não serão utilizadas
        rom[7] = 32'h00000000;
        rom[8] = 32'h00000000;
        // ...
    end
    
    always @(*) begin
        instruction = rom[addr[31:2]];
    end
endmodule
