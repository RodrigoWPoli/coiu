; uart.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 12/02/2025

; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ==========================================
; ==========================================
; Definicoes dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
SYSCTL_RCGCUART_R    EQU    0x400FE618
SYSCTL_PRUART_R      EQU    0x400FEA18
; ===========================================
; Definicoes dos Ports
; ~~~~~~~~~~~~~~~~ PORT A ~~~~~~~~~~~~~~~~~~
GPIO_PORTA_AHB_LOCK_R 		EQU     0x40058520
GPIO_PORTA_AHB_CR_R     	EQU     0x40058524
GPIO_PORTA_AHB_AMSEL_R  	EQU	    0x40058528
GPIO_PORTA_AHB_PCTL_R   	EQU	    0x4005852C
GPIO_PORTA_AHB_DIR_R    	EQU	    0x40058400
GPIO_PORTA_AHB_AFSEL_R  	EQU	    0x40058420
GPIO_PORTA_AHB_DEN_R    	EQU     0x4005851C
GPIO_PORTA_AHB_PUR_R    	EQU     0x40058510
GPIO_PORTA_AHB_DATA_R   	EQU     0x400583FC
GPIO_PORTA 					EQU     2_000000000000001

; ===========================================
;definições dos Uarts
; ~~~~~~~~~~~~~~~~ UART0 ~~~~~~~~~~~~~~~~~~
UART0_DR_R                  EQU     0x4000C000
UART0_RSR_R                 EQU     0x4000C004
UART0_ECR_R                 EQU     0x4000C004
UART0_FR_R                  EQU     0x4000C018
UART0_ILPR_R                EQU     0x4000C020
UART0_IBRD_R                EQU     0x4000C024
UART0_FBRD_R                EQU     0x4000C028
UART0_LCRH_R                EQU     0x4000C02C
UART0_CTL_R                 EQU     0x4000C030
UART0_IFLS_R                EQU     0x4000C034
UART0_IM_R                  EQU     0x4000C038
UART0_RIS_R                 EQU     0x4000C03C
UART0_MIS_R                 EQU     0x4000C040
UART0_ICR_R                 EQU     0x4000C044
UART0_DMACTL_R              EQU     0x4000C048
UART0_9BITADDR_R            EQU     0x4000C0A4
UART0_9BITAMASK_R           EQU     0x4000C0A8
UART0_PP_R                  EQU     0x4000CFC0
UART0_CC_R                  EQU     0x4000CFC8
;~~~~~~~~~~~~ OUTRAS CONSTANTES ~~~~~~~~~~~~~



; -------------------------------------------------------------------------------
; Area de Codigo - Tudo abaixo da diretiva a seguir sera armazenado na memoria de 
;                  codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funcao do arquivo for chamada em outro arquivo	
        EXPORT UART_Init           
        
        IMPORT SysTick_Wait1us
;--------------------------------------------------------------------------------
; Funcao UART_Init
; Ports e Pinos utilizados:
; Port A: PA0 e PA1 -> GPIOPCTL 0x11
; UART 0   
UART_Init
;================================================================================
; Inicialização do UART
; 1. Habilitar o clock no módulo UART no registrador RCGCUART e esperar até que a respectiva UART
; esteja pronta para ser acessada no registrador PRUART
            LDR     R0, =SYSCTL_RCGCUART_R  		                ;Carrega o endereco do registrador RCGCGPIO
			MOV		R1, #1                                          ;Seta o bit da UART 0
            STR     R1, [R0]					                	;Move para a memoria o bit da UART 0 no endereco do RCGCGPIO
            
            LDR     R0, =SYSCTL_PRUART_R			                ;Carrega o endereco do PRUART para esperar a UART ficar pronta 

EsperaUART  
            LDR     R1, [R0]						                ;Le da memoria o conteudo do endereco do registrador
            MOV     R2, #1                                          ;Seta os bits correspondentes da uart
            TST     R1, R2						                    ;ANDS de R1 com R2
            BEQ     EsperaUART					                    ;Se o flag Z=1, volta para o laco. Senao continua executando

; 2. Desabilitar o UART para fazer as alterações necessárias
            LDR     R0, =UART0_CTL_R		                        ;Carrega o endereco do CTL para a UART 0
            MOV     R1, #0                                          ;Coloca 0 no registrador para desabilitar a UART
            STR     R1, [R0]                                        ;Guarda no registrador da memoria

; 3. Configurar o Baud Rate
            LDR     R0, =UART0_IBRD_R		                        ;Carrega o endereco do IBRD para a UART 0
            MOV     R1, #0x56                                       ;IBRD = int(80,000,000 / (16 * 57,600)) = int(86.8055)
            STR     R1, [R0]                                        ;Guarda no registrador da memoria

            LDR     R0, =UART0_FBRD_R		                        ;Carrega o endereco do FBRD para a UART 0
            MOV     R1, #0x34                                       ;FBRD = round(0.8055 * 64) = 52
            STR     R1, [R0]                                        ;Guarda no registrador da memoria



;================================================================================
; Inicialização do GPIO
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; apos isso verificar no PRGPIO se a porta esta pronta para uso.
; enable clock to GPIOF at clock gating register
            LDR     R0, =SYSCTL_RCGCGPIO_R  		                ;Carrega o endereco do registrador RCGCGPIO
			MOV		R1, #GPIO_PORTM                                 ;Seta o bit da porta generica 
			ORR     R1, #GPIO_PORTK				                    ;Seta o bit da porta generica, fazendo com OR
			ORR 	R1, #GPIO_PORTJ 			                    ;Seta o bit da porta generica, fazendo com OR
			ORR 	R1, #GPIO_PORTL 			                    ;Seta o bit da porta generica, fazendo com OR
			ORR 	R1, #GPIO_PORTH 			                    ;Seta o bit da porta generica, fazendo com OR
            STR     R1, [R0]					                	;Move para a memoria os bits das portas no endereco do RCGCGPIO
 
            LDR     R0, =SYSCTL_PRGPIO_R			                ;Carrega o endereco do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO  
            LDR     R1, [R0]						                ;Le da memoria o conteudo do endereco do registrador
            MOV     R2, #GPIO_PORTM                                 ;Seta os bits correspondentes das portas para fazer a comparacao
            ORR     R2, #GPIO_PORTK                                 ;Seta o bit da porta generica, fazendo com OR
            ORR     R2, #GPIO_PORTJ                                 ;Seta o bit da porta generica, fazendo com OR
            ORR     R2, #GPIO_PORTL                                 ;Seta o bit da porta generica, fazendo com OR
            ORR     R2, #GPIO_PORTH                                 ;Seta o bit da porta generica, fazendo com OR
            TST     R1, R2						                    ;ANDS de R1 com R2
            BEQ     EsperaGPIO					                    ;Se o flag Z=1, volta para o laco. Senao continua executando
 
; 2. Limpar o AMSEL para desabilitar a analogica
            MOV     R1, #0x00						                ;Colocar 0 no registrador para desabilitar a funcao analogica
            LDR     R0, =GPIO_PORTM_AMSEL_R                         ;Carrega o R0 com o endereco do AMSEL para a porta generica
            STR     R1, [R0]						                ;Guarda no registrador AMSEL da porta generica da memoria
            LDR     R0, =GPIO_PORTK_AMSEL_R    		                ;Carrega o R0 com o endereco do AMSEL para a porta generica
            STR     R1, [R0]					                    ;Guarda no registrador AMSEL da porta generica da memoria
            LDR     R0, =GPIO_PORTJ_AHB_AMSEL_R    		            ;Carrega o R0 com o endereco do AMSEL para a porta generica
            STR     R1, [R0]					                    ;Guarda no registrador AMSEL da porta generica da memoria
            LDR     R0, =GPIO_PORTL_AMSEL_R    		                ;Carrega o R0 com o endereco do AMSEL para a porta generica
            STR     R1, [R0]					                    ;Guarda no registrador AMSEL da porta generica da memoria
            LDR     R0, =GPIO_PORTH_AHB_AMSEL_R		                ;Carrega o R0 com o endereco do AMSEL para a porta generica
            STR     R1, [R0]					                    ;Guarda no registrador AMSEL da porta generica da memoria
 
; 3. Limpar PCTL para selecionar o GPIO
            MOV     R1, #0x00					                    ;Colocar 0 no registrador para selecionar o modo GPIO
            LDR     R0, =GPIO_PORTM_PCTL_R		                    ;Carrega o R0 com o endereco do PCTL para a porta generica
            STR     R1, [R0]                                        ;Guarda no registrador PCTL da porta generica da memoria
            LDR     R0, =GPIO_PORTK_PCTL_R                          ;Carrega o R0 com o endereco do PCTL para a porta generica
            STR     R1, [R0]                                        ;Guarda no registrador PCTL da porta generica da memoria
            LDR     R0, =GPIO_PORTJ_AHB_PCTL_R		                ;Carrega o R0 com o endereco do PCTL para a porta generica
            STR     R1, [R0]                                        ;Guarda no registrador PCTL da porta generica da memoria
            LDR     R0, =GPIO_PORTL_PCTL_R		                    ;Carrega o R0 com o endereco do PCTL para a porta generica
            STR     R1, [R0]                                        ;Guarda no registrador PCTL da porta generica da memoria
            LDR     R0, =GPIO_PORTH_AHB_PCTL_R                      ;Carrega o R0 com o endereco do PCTL para a porta generica
            STR     R1, [R0]                                        ;Guarda no registrador PCTL da porta generica da memoria

; 4. DIR para 0 se for entrada, 1 se for saida
            LDR     R0, =GPIO_PORTK_DIR_R	    	                ;Carrega o R0 com o endereco do DIR para a porta generica
			MOV     R1, #2_11111111					                ;PK0-PK7 para Dados do LCD
            STR     R1, [R0]						                ;Guarda no registrador
            
            LDR     R0, =GPIO_PORTM_DIR_R		                    ;Carrega o R0 com o endereco do DIR para a porta generica
            MOV     R1, #2_11110111            		                ;PM0-PM2 para saida de controle do LCD e PM4-PM7 para entrada do teclado
            STR     R1, [R0]						                ;Guarda no registrador PCTL da porta generica da memoria

            LDR     R0, =GPIO_PORTL_DIR_R                           ;Carrega o R0 com o endereco do DIR para a porta generica
            MOV     R1, #2_00000000                                 ;PL0-PL3 para entrada do teclado
            STR     R1, [R0]                                        ;Guarda no registrador

            LDR     R0, =GPIO_PORTJ_AHB_DIR_R                       ;Carrega o R0 com o endereco do DIR para a porta generica
            MOV     R1, #2_00000000            		                ;PJ0 e PJ1 para entrada USR_SW1, USR_SW2
            STR     R1, [R0]						                ;Guarda no registrador PCTL da porta generica da memoria

            LDR     R0, =GPIO_PORTH_AHB_DIR_R                       ;Carrega o R0 com o endereco do DIR para a porta generica
            MOV     R1, #2_00001111            		                ;PH0-PH3 para saída do motor
            STR     R1, [R0]						                ;Guarda no registrador PCTL da porta generica da memoria

; 5. Limpar os bits AFSEL para 0 para selecionar GPIO 
;    Sem funcao alternativa
            MOV     R1, #0x00						                ;Colocar o valor 0 para nao setar funcao alternativa
            LDR     R0, =GPIO_PORTK_AFSEL_R		                    ;Carrega o endereco do AFSEL da porta generica
            STR     R1, [R0]						                ;Escreve na porta
            LDR     R0, =GPIO_PORTM_AFSEL_R                         ;Carrega o endereco do AFSEL da porta generica
            STR     R1, [R0]                                        ;Escreve na porta
            LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R                     ;Carrega o endereco do AFSEL da porta generica
            STR     R1, [R0]                                        ;Escreve na porta
            LDR     R0, =GPIO_PORTL_AFSEL_R                         ;Carrega o endereco do AFSEL da porta generica
            STR     R1, [R0]                                        ;Escreve na porta
            LDR     R0, =GPIO_PORTH_AHB_AFSEL_R                     ;Carrega o endereco do AFSEL da porta generica
            STR     R1, [R0]                                        ;Escreve na porta

; 6. Setar os bits de DEN para habilitar I/O digital
            LDR     R0, =GPIO_PORTK_DEN_R			                ;Carrega o endereco do DEN
            MOV     R1, #2_11111111                                 ;Ativa os pinos PK0-PK7 como I/O Digital
            STR     R1, [R0]					                    ;Escreve no registrador da memoria funcionalidade digital 
 
            LDR     R0, =GPIO_PORTM_DEN_R			                ;Carrega o endereco do DEN
			MOV     R1, #2_11110111                                 ;Ativa os pinos PM0-PM2 como I/O Digital e PM4-PM7 como I/O Digital  
            STR     R1, [R0]                                        ;Escreve no registrador da memoria funcionalidade digital

            LDR     R0, =GPIO_PORTL_DEN_R                           ;Carrega o endereco do DEN
            MOV     R1, #2_00001111                                 ;Ativa os pinos PL0-PL3 como I/O Digital
            STR     R1, [R0]                                        ;Escreve no registrador da memoria funcionalidade digital

            LDR 	R0, =GPIO_PORTJ_AHB_DEN_R			            ; Carrega o endereco do DEN para a porta J
			MOV 	R1, #2_00000011						            ; Ativa a PJ0 e PJ1 para ser digital
            STR		R1, [R0]							            ; Seta o bit digital para PJ0 e PJ1

            LDR 	R0, =GPIO_PORTH_AHB_DEN_R			            ; Carrega o endereco do DEN para a porta J
			MOV 	R1, #2_00001111						            ; Ativa a PH0-PH3 para ser digital
            STR		R1, [R0]							            ; Seta o bit digital para PH0-PH3

; 7. Para habilitar resistor de pull-down/pull-up interno, setar PDR para 1
			LDR     R0, =GPIO_PORTL_PDR_R			                ;Carrega o endereco do PDR para a porta generica
			MOV     R1, #2_00001111					                ;Habilitar funcionalidade digital de resistor de pull-down nos bits 0 e 1
            STR     R1, [R0]						                ;Escreve no registrador da memoria do resistor de pull-down

            LDR 	R0, =GPIO_PORTJ_AHB_PUR_R 			            ; Carrega o endereco do PUR para a porta J
			MOV 	R1, #2_00000011				     	            ; Seta o bit do PJ0 e PJ1 para utilizar o PUR
			STR 	R1, [R0]							            ; Salva o bit setado no PUR da porta J 

            LDR 	R0, =GPIO_PORTJ_AHB_PUR_R 			            ; Carrega o endereco do PUR para a porta J
			MOV 	R1, #2_00001111				     	            ; Seta o bit de PH0-PH3 para utilizar o PDR
			STR 	R1, [R0]							            ; Salva o bit setado no PDR da porta H
            
;retorno            
			BX      LR

;---------------------------------------------------------------------------------------------
            ALIGN                           			; garante que o fim da secaoo esta alinhada 
            END                             			; fim do arquivo