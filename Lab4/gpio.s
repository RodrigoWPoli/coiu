; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 30/11/2024

; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ========================
; ========================
; Definicoes dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
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

; ~~~~~~~~~~~~~~~~ PORT B ~~~~~~~~~~~~~~~~~~
GPIO_PORTB_AHB_DATA_R   	EQU     0x400593FC
GPIO_PORTB_AHB_DIR_R    	EQU     0x40059400
GPIO_PORTB_AHB_AFSEL_R  	EQU     0x40059420
GPIO_PORTB_AHB_PUR_R    	EQU     0x40059510
GPIO_PORTB_AHB_DEN_R    	EQU     0x4005951C
GPIO_PORTB_AHB_LOCK_R   	EQU     0x40059520
GPIO_PORTB_AHB_CR_R     	EQU     0x40059524
GPIO_PORTB_AHB_AMSEL_R  	EQU     0x40059528
GPIO_PORTB_AHB_PCTL_R   	EQU     0x4005952C
GPIO_PORTB 					EQU     2_000000000000010

; ~~~~~~~~~~~~~~~~ PORT C ~~~~~~~~~~~~~~~~~~
GPIO_PORTC_AHB_DATA_R   	EQU     0x4005A3FC
GPIO_PORTC_AHB_DIR_R    	EQU     0x4005A400
GPIO_PORTC_AHB_AFSEL_R  	EQU     0x4005A420
GPIO_PORTC_AHB_PUR_R    	EQU     0x4005A510
GPIO_PORTC_AHB_DEN_R    	EQU     0x4005A51C
GPIO_PORTC_AHB_LOCK_R   	EQU     0x4005A520
GPIO_PORTC_AHB_CR_R     	EQU     0x4005A524
GPIO_PORTC_AHB_AMSEL_R  	EQU     0x4005A528
GPIO_PORTC_AHB_PCTL_R   	EQU     0x4005A52C
GPIO_PORTC 					EQU     2_000000000000100

; ~~~~~~~~~~~~~~~~ PORT D ~~~~~~~~~~~~~~~~~~
GPIO_PORTD_AHB_DATA_R   	EQU     0x4005B3FC
GPIO_PORTD_AHB_DIR_R    	EQU     0x4005B400
GPIO_PORTD_AHB_AFSEL_R  	EQU     0x4005B420
GPIO_PORTD_AHB_PUR_R    	EQU     0x4005B510
GPIO_PORTD_AHB_DEN_R    	EQU     0x4005B51C
GPIO_PORTD_AHB_LOCK_R   	EQU     0x4005B520
GPIO_PORTD_AHB_CR_R     	EQU     0x4005B524
GPIO_PORTD_AHB_AMSEL_R  	EQU     0x4005B528
GPIO_PORTD_AHB_PCTL_R   	EQU     0x4005B52C
GPIO_PORTD 					EQU     2_000000000001000

; ~~~~~~~~~~~~~~~~ PORT E ~~~~~~~~~~~~~~~~~~
GPIO_PORTE_AHB_DATA_R   	EQU     0x4005C3FC
GPIO_PORTE_AHB_DIR_R    	EQU     0x4005C400
GPIO_PORTE_AHB_AFSEL_R  	EQU     0x4005C420
GPIO_PORTE_AHB_PUR_R    	EQU     0x4005C510
GPIO_PORTE_AHB_DEN_R    	EQU     0x4005C51C
GPIO_PORTE_AHB_LOCK_R   	EQU     0x4005C520
GPIO_PORTE_AHB_CR_R     	EQU     0x4005C524
GPIO_PORTE_AHB_AMSEL_R  	EQU     0x4005C528
GPIO_PORTE_AHB_PCTL_R   	EQU     0x4005C52C
GPIO_PORTE 					EQU     2_000000000010000

; ~~~~~~~~~~~~~~~~ PORT F ~~~~~~~~~~~~~~~~~~
GPIO_PORTF_AHB_DATA_R   	EQU     0x4005D3FC
GPIO_PORTF_AHB_DIR_R    	EQU     0x4005D400
GPIO_PORTF_AHB_AFSEL_R  	EQU     0x4005D420
GPIO_PORTF_AHB_PUR_R    	EQU     0x4005D510
GPIO_PORTF_AHB_DEN_R    	EQU     0x4005D51C
GPIO_PORTF_AHB_LOCK_R   	EQU     0x4005D520
GPIO_PORTF_AHB_CR_R     	EQU     0x4005D524
GPIO_PORTF_AHB_AMSEL_R  	EQU     0x4005D528
GPIO_PORTF_AHB_PCTL_R   	EQU     0x4005D52C
GPIO_PORTF 					EQU     2_000000000100000

; ~~~~~~~~~~~~~~~~ PORT G ~~~~~~~~~~~~~~~~~~
GPIO_PORTG_AHB_DATA_R   	EQU     0x4005E3FC
GPIO_PORTG_AHB_DIR_R    	EQU     0x4005E400
GPIO_PORTG_AHB_AFSEL_R  	EQU     0x4005E420
GPIO_PORTG_AHB_PUR_R    	EQU     0x4005E510
GPIO_PORTG_AHB_DEN_R    	EQU     0x4005E51C
GPIO_PORTG_AHB_LOCK_R   	EQU     0x4005E520
GPIO_PORTG_AHB_CR_R     	EQU     0x4005E524
GPIO_PORTG_AHB_AMSEL_R  	EQU     0x4005E528
GPIO_PORTG_AHB_PCTL_R   	EQU     0x4005E52C
GPIO_PORTG 					EQU     2_000000001000000

; ~~~~~~~~~~~~~~~~ PORT H ~~~~~~~~~~~~~~~~~~
GPIO_PORTH_AHB_DATA_R   	EQU     0x4005F3FC
GPIO_PORTH_AHB_DIR_R    	EQU     0x4005F400
GPIO_PORTH_AHB_AFSEL_R  	EQU     0x4005F420
GPIO_PORTH_AHB_PUR_R    	EQU     0x4005F510
GPIO_PORTH_AHB_DEN_R    	EQU     0x4005F51C
GPIO_PORTH_AHB_LOCK_R   	EQU     0x4005F520
GPIO_PORTH_AHB_CR_R     	EQU     0x4005F524
GPIO_PORTH_AHB_AMSEL_R  	EQU     0x4005F528
GPIO_PORTH_AHB_PCTL_R   	EQU     0x4005F52C
GPIO_PORTH 					EQU     2_000000010000000

; ~~~~~~~~~~~~~~~~ PORT J ~~~~~~~~~~~~~~~~~~
GPIO_PORTJ_AHB_DATA_R    	EQU    0x400603FC
GPIO_PORTJ_AHB_DIR_R     	EQU    0x40060400
GPIO_PORTJ_AHB_AFSEL_R   	EQU    0x40060420
GPIO_PORTJ_AHB_PUR_R     	EQU    0x40060510	
GPIO_PORTJ_AHB_DEN_R        EQU    0x4006051C
GPIO_PORTJ_AHB_LOCK_R    	EQU    0x40060520
GPIO_PORTJ_AHB_CR_R      	EQU    0x40060524
GPIO_PORTJ_AHB_AMSEL_R   	EQU    0x40060528
GPIO_PORTJ_AHB_PCTL_R    	EQU    0x4006052C
GPIO_PORTJ               	EQU    2_000000100000000

; ~~~~~~~~~~~~~~~~ PORT K ~~~~~~~~~~~~~~~~~~
GPIO_PORTK_DATA_R           EQU     0x400613FC
GPIO_PORTK_DIR_R            EQU     0x40061400
GPIO_PORTK_AFSEL_R          EQU     0x40061420
GPIO_PORTK_PUR_R            EQU     0x40061510
GPIO_PORTK_DEN_R            EQU     0x4006151C
GPIO_PORTK_LOCK_R           EQU     0x40061520
GPIO_PORTK_CR_R             EQU     0x40061524
GPIO_PORTK_AMSEL_R          EQU     0x40061528
GPIO_PORTK_PCTL_R           EQU     0x4006152C
GPIO_PORTK               	EQU     2_000001000000000

; ~~~~~~~~~~~~~~~~ PORT L ~~~~~~~~~~~~~~~~~~
GPIO_PORTL_DATA_R           EQU     0x400623FC
GPIO_PORTL_DIR_R            EQU     0x40062400
GPIO_PORTL_AFSEL_R          EQU     0x40062420
GPIO_PORTL_PUR_R            EQU     0x40062510
GPIO_PORTL_PDR_R            EQU     0x40062514
GPIO_PORTL_DEN_R            EQU     0x4006251C
GPIO_PORTL_LOCK_R           EQU     0x40062520
GPIO_PORTL_CR_R             EQU     0x40062524
GPIO_PORTL_AMSEL_R          EQU     0x40062528
GPIO_PORTL_PCTL_R           EQU     0x4006252C
GPIO_PORTL               	EQU     2_000010000000000

; ~~~~~~~~~~~~~~~~ PORT M ~~~~~~~~~~~~~~~~~~
GPIO_PORTM_DATA_R           EQU     0x400633FC
GPIO_PORTM_DIR_R            EQU     0x40063400
GPIO_PORTM_AFSEL_R          EQU     0x40063420
GPIO_PORTM_PUR_R            EQU     0x40063510
GPIO_PORTM_DEN_R            EQU     0x4006351C
GPIO_PORTM_LOCK_R           EQU     0x40063520
GPIO_PORTM_CR_R             EQU     0x40063524
GPIO_PORTM_AMSEL_R          EQU     0x40063528
GPIO_PORTM_PCTL_R           EQU     0x4006352C
GPIO_PORTM               	EQU     2_000100000000000

; ~~~~~~~~~~~~~~~~ PORT N ~~~~~~~~~~~~~~~~~~
GPIO_PORTN_DATA_R           EQU     0x400643FC
GPIO_PORTN_DIR_R            EQU     0x40064400
GPIO_PORTN_AFSEL_R          EQU     0x40064420
GPIO_PORTN_PUR_R            EQU     0x40064510
GPIO_PORTN_DEN_R            EQU     0x4006451C
GPIO_PORTN_LOCK_R           EQU     0x40064520
GPIO_PORTN_CR_R             EQU     0x40064524
GPIO_PORTN_AMSEL_R          EQU     0x40064528
GPIO_PORTN_PCTL_R           EQU     0x4006452C
GPIO_PORTN               	EQU     2_001000000000000

; ~~~~~~~~~~~~~~~~ PORT P ~~~~~~~~~~~~~~~~~~
GPIO_PORTP_DATA_R           EQU     0x400653FC
GPIO_PORTP_DIR_R            EQU     0x40065400
GPIO_PORTP_AFSEL_R          EQU     0x40065420
GPIO_PORTP_PUR_R            EQU     0x40065510
GPIO_PORTP_DEN_R            EQU     0x4006551C
GPIO_PORTP_LOCK_R           EQU     0x40065520
GPIO_PORTP_CR_R             EQU     0x40065524
GPIO_PORTP_AMSEL_R          EQU     0x40065528
GPIO_PORTP_PCTL_R           EQU     0x4006552C
GPIO_PORTP               	EQU     2_010000000000000

; ~~~~~~~~~~~~~~~~ PORT Q ~~~~~~~~~~~~~~~~~~
GPIO_PORTQ_DATA_R           EQU     0x400663FC
GPIO_PORTQ_DIR_R            EQU     0x40066400
GPIO_PORTQ_AFSEL_R          EQU     0x40066420
GPIO_PORTQ_PUR_R            EQU     0x40066510
GPIO_PORTQ_DEN_R            EQU     0x4006651C
GPIO_PORTQ_LOCK_R           EQU     0x40066520
GPIO_PORTQ_CR_R             EQU     0x40066524
GPIO_PORTQ_AMSEL_R          EQU     0x40066528
GPIO_PORTQ_PCTL_R           EQU     0x4006652C
GPIO_PORTQ               	EQU     2_100000000000000

; ===========================================
;~~~~~~~~~~~~ OUTRAS CONSTANTES ~~~~~~~~~~~~~



; -------------------------------------------------------------------------------
; Area de Codigo - Tudo abaixo da diretiva a seguir sera armazenado na memoria de 
;                  codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funcao do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init           
		EXPORT LCD_Init
        
        IMPORT SysTick_Wait1us
;--------------------------------------------------------------------------------
; Funcao GPIO_Init
; Ports e Pinos utilizados:
;   Port J: PJ1     -> Botao RST Global -> PJ0 -> Botao alterar mode
;   Port K: PK0-PK7 -> Dados do LCD
;   Port L: PL0-PL3 -> Teclado Matricial
;   Port M: PM0-PM2 -> Controle do LCD -> PM4-PM7 -> Teclado Matricial
;   Port do Motor -> TODO
GPIO_Init
;=====================
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; apos isso verificar no PRGPIO se a porta esta pronta para uso.
; enable clock to GPIOF at clock gating register
            LDR     R0, =SYSCTL_RCGCGPIO_R  		                ;Carrega o endereco do registrador RCGCGPIO
			MOV		R1, #GPIO_PORTM                                 ;Seta o bit da porta generica 
			ORR     R1, #GPIO_PORTK				                    ;Seta o bit da porta generica, fazendo com OR
			ORR 	R1, #GPIO_PORTJ 			                    ;Seta o bit da porta generica, fazendo com OR
			ORR 	R1, #GPIO_PORTL 			                    ;Seta o bit da porta generica, fazendo com OR
			ORR 	R1, #GPIO_PORTH 			                    ;Seta o bit da porta generica, fazendo com OR
			ORR 	R1, #GPIO_PORTE 			                    ;Seta o bit da porta generica, fazendo com OR
			ORR 	R1, #GPIO_PORTF 			                    ;Seta o bit da porta generica, fazendo com OR
            STR     R1, [R0]					                	;Move para a memoria os bits das portas no endereco do RCGCGPIO
 
            LDR     R0, =SYSCTL_PRGPIO_R			                ;Carrega o endereco do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO  
            LDR     R1, [R0]						                ;Le da memoria o conteudo do endereco do registrador
            MOV     R2, #GPIO_PORTM                                 ;Seta os bits correspondentes das portas para fazer a comparacao
            ORR     R2, #GPIO_PORTK                                 ;Seta o bit da porta generica, fazendo com OR
            ORR     R2, #GPIO_PORTJ                                 ;Seta o bit da porta generica, fazendo com OR
            ORR     R2, #GPIO_PORTL                                 ;Seta o bit da porta generica, fazendo com OR
            ORR     R2, #GPIO_PORTH                                 ;Seta o bit da porta generica, fazendo com OR
            ORR     R2, #GPIO_PORTE                                 ;Seta o bit da porta generica, fazendo com OR
            ORR     R2, #GPIO_PORTF                                 ;Seta o bit da porta generica, fazendo com OR
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
            LDR     R0, =GPIO_PORTE_AHB_AMSEL_R		                ;Carrega o R0 com o endereco do AMSEL para a porta generica
            STR     R1, [R0]					                    ;Guarda no registrador AMSEL da porta generica da memoria
            LDR     R0, =GPIO_PORTF_AHB_AMSEL_R		                ;Carrega o R0 com o endereco do AMSEL para a porta generica
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
            LDR     R0, =GPIO_PORTE_AHB_PCTL_R                      ;Carrega o R0 com o endereco do PCTL para a porta generica
            STR     R1, [R0]                                        ;Guarda no registrador PCTL da porta generica da memoria
            LDR     R0, =GPIO_PORTF_AHB_PCTL_R                      ;Carrega o R0 com o endereco do PCTL para a porta generica
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

            LDR     R0, =GPIO_PORTE_AHB_DIR_R                       ;Carrega o R0 com o endereco do DIR para a porta generica
            MOV     R1, #2_00001111            		                ;PE0-PE3 para saída do motor
            STR     R1, [R0]						                ;Guarda no registrador PCTL da porta generica da memoria

            LDR     R0, =GPIO_PORTF_AHB_DIR_R                       ;Carrega o R0 com o endereco do DIR para a porta generica
            MOV     R1, #2_00001100            		                ;PF0-PF1 para saída do motor
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
            LDR     R0, =GPIO_PORTE_AHB_AFSEL_R                     ;Carrega o endereco do AFSEL da porta generica
            STR     R1, [R0]                                        ;Escreve na porta
            LDR     R0, =GPIO_PORTF_AHB_AFSEL_R                     ;Carrega o endereco do AFSEL da porta generica
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

            LDR 	R0, =GPIO_PORTE_AHB_DEN_R			            ; Carrega o endereco do DEN para a porta J
			MOV 	R1, #2_00001111						            ; Ativa a PH0-PH3 para ser digital
            STR		R1, [R0]							            ; Seta o bit digital para PH0-PH3

            LDR 	R0, =GPIO_PORTF_AHB_DEN_R			            ; Carrega o endereco do DEN para a porta J
			MOV 	R1, #2_00001100						            ; Ativa a PH0-PH3 para ser digital
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

            LDR 	R0, =GPIO_PORTE_AHB_PUR_R 			            ; Carrega o endereco do PUR para a porta J
			MOV 	R1, #2_00001111				     	            ; Seta o bit de PH0-PH3 para utilizar o PDR
			STR 	R1, [R0]							            ; Salva o bit setado no PDR da porta H

            LDR 	R0, =GPIO_PORTF_AHB_PUR_R 			            ; Carrega o endereco do PUR para a porta J
			MOV 	R1, #2_00001100				     	            ; Seta o bit de PH0-PH3 para utilizar o PDR
			STR 	R1, [R0]							            ; Salva o bit setado no PDR da porta H

; 8. Seta os bits que não mudam
            LDR    R0, =GPIO_PORTF_AHB_DATA_R		                ;Carrega o endereco do DATA para a porta generica
            MOV    R1, #2_110					                    ;Coloca 0 no registrador
            STR    R1, [R0]					                        ;Guarda no registrador da memoria funcionalidade digital
            
;retorno            
			BX      LR

; -------------------------------------------------------------------------------
; Funcao LCD_Init
LCD_Init
            ; 
            PUSH    {LR} 
            LDR     R0, =GPIO_PORTK_DATA_R
            MOV     R1, #0x38
            STR     R1, [R0]

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x04
            STR     R1, [R0]

            LDR     R0, =15
            BL      SysTick_Wait1us
            
            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x00
            STR     R1, [R0]

            LDR     R0, =45
            BL      SysTick_Wait1us

            ; 
            LDR     R0, =GPIO_PORTK_DATA_R
            MOV     R1, #0x06
            STR     R1, [R0]

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x04
            STR     R1, [R0]

            LDR     R0, =15
            BL      SysTick_Wait1us
            
            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x00
            STR     R1, [R0]

            LDR     R0, =45
            BL      SysTick_Wait1us

            ; 
            LDR     R0, =GPIO_PORTK_DATA_R
            MOV     R1, #0x0E
            STR     R1, [R0]

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x04
            STR     R1, [R0]

            LDR     R0, =15
            BL      SysTick_Wait1us

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x00
            STR     R1, [R0]

            LDR     R0, =45
            BL      SysTick_Wait1us

            ; 
            LDR     R0, =GPIO_PORTK_DATA_R
            MOV     R1, #0x01
            STR     R1, [R0]

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x04
            STR     R1, [R0]

            LDR     R0, =15
            BL      SysTick_Wait1us
            
            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x00
            STR     R1, [R0]

            LDR     R0, =5
            BL      SysTick_Wait1us
            
            POP     {LR}
            BX      LR									;Retorno

;---------------------------------------------------------------------------------------------
            ALIGN                           			; garante que o fim da secaoo esta alinhada 
            END                             			; fim do arquivo