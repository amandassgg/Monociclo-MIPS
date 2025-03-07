//Testbench
//Amanda Sousa Gonçalves - polo UFC
//Projeto de Arquitetura e Organização de Sistemas Digitais
module tb_monociclo_top;
    reg clk;
    reg reset;
    
    // Instancia o módulo top
    monociclo_top DUT (
        .clk(clk),
        .reset(reset)
    );
    
    // Geração do clock (período de 10 unidades de tempo)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Reset inicial
    initial begin
        reset = 1;
        #10;
        reset = 0;
        
        // Tempo de simulação
        #200;
        $finish;
    end
    
endmodule

