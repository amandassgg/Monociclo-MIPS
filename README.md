# Monociclo-MIPS
O projeto em questão implementa um processador monociclo em SystemVerilog, desenvolvido como parte do curso de Arquitetura e Organização de Sistemas Digitais. O processador é capaz de executar instruções básicas, como carregar (LW), armazenar (SW), operações aritméticas (ADD, SUB) e desvios condicionais (BEQ).

## Estrutura do Projeto

O projeto é composto pelos seguintes arquivos:

- monociclo.sv: Módulo topo do processador monociclo, que integra todos os componentes principais.
- datapath.sv: Caminho de dados do processador, que inclui o banco de registradores, ULA, multiplexadores e outros componentes.
- control.sv: Módulo de controle principal, que gera os sinais de controle com base no opcode da instrução.
- main_control.sv: Submódulo de controle que decodifica o opcode.
- ALU_control.sv: Controle da Unidade Lógica e Aritmética (ULA), responsável por selecionar a operação a ser executada.
- data_memory.sv: Memória de dados, que armazena e recupera dados durante a execução do programa.
- instr_memory.sv: Memória de instruções, que armazena as instruções a serem executadas pelo processador.
- monociclo_tb.sv: Testbench para simulação do processador monociclo.
- run_x.sh: Script para executar a simulação usando a ferramenta `xrun`.

Observação: Os dados disponibilizados nas memórias de instrução e de dados servem apenas para que a simulação ocorra e possa ser verificado o comportamento do datapath e do controle e, por isso, não estão completamente preenchidos.

Observação 2: Na pasta "imagens", há alguns registros gráficos do funcionamento do circuito. 

Para executar a simulação, execute o script run_x.sh, que compila e simula o projeto.

