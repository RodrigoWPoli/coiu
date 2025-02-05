; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Este programa espera o usuario apertar a chave USR_SW1 e/ou a chave USR_SW2.
; Caso o usuario pressione a chave USR_SW1, acendera o LED3 (PF4). Caso o usuario pressione 
; a chave USR_SW2, acendera o LED4 (PF0). Caso as duas chaves sejam pressionadas, os dois 
; LEDs acendem.

; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; ~~~~~~~~~~~~~ OTHER CONSTANTS ~~~~~~~~~~~~~~F
Timer0A_Addr             EQU     0x20010000
Timer1A_Addr             EQU     0x20010004
PREV_KEYPRESS			 EQU     0x20020000
CURR_KEY	    		 EQU	 0x20020004
ANGLE            		 EQU     0x20030000
TURN				 	 EQU	 0x20030004
MODE         			 EQU     0x20030008
APOLARITY         	     EQU     0x2003000C
TPOLARITY         	     EQU     0x20030010
char_minus          	 EQU     2_00101101
char_angle          	 EQU     2_11011111

; -------------------------------------------------------------------------------
; Area de Dados - Declaracoes de variaveis
		AREA  DATA, ALIGN=2
		; Se alguma variavel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variavel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variavel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posicao da RAM		

; -------------------------------------------------------------------------------
; Area de Codigo - Tudo abaixo da diretiva a seguir sera armazenado na memoria de 
;                  codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funcao do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a funcao Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma funcao externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; funcao <func>
		IMPORT	PLL_Init
		IMPORT	SysTick_Init
        IMPORT	SysTick_Wait1us
        IMPORT	SysTick_Wait1ms
		IMPORT	GPIO_Init
		IMPORT	LCD_Init
		IMPORT  Timers_Init
		IMPORT	Interrupt_Init
		
		IMPORT	TecladoM_Poll
        IMPORT 	Timer0A_Handler
		IMPORT  create_data_row
		IMPORT 	calculate_angle_turn

; -------------------------------------------------------------------------------
; Funcao main()
Start  			
	BL 	PLL_Init					 ;Subrotina para alterar o clock do microcontrolador para 80MHz
	BL 	SysTick_Init				 ;
	BL 	GPIO_Init                 	 ;Subrotina que inicializa os GPIO
	BL 	LCD_Init                  	 ;Subrotina que inicializa o LCD
	BL 	Timers_Init              	 ;Subrotina que inicializa o Timer0A
	BL	Interrupt_Init				 ;Subrotina que inicializa os Interrupts de GPIO

	MOV R1, #0						 ;Inicialização do angulo, das voltas, do modo e das polaridades
	LDR R0, =ANGLE
	STR R1, [R0]
	LDR R0, =TURN
	STR R1, [R0]
	LDR R0, =MODE
	STR R1, [R0]
	LDR	R0, =APOLARITY
	STR R1, [R0]
	LDR	R0, =TPOLARITY
	STR R1, [R0]

	BL  create_data_row
	
	LDR	R0, =PREV_KEYPRESS
	MOV R1, #0x10
	STR R1, [R0]
	
	LDR	R0, =CURR_KEY
	MOV R1, #0
	STR R1, [R0]
	
; -------------------------------------------------------------------------------
; Laco principal
; R1 = valor da tecla pressionada


MainLoop
	LDR     R0, =Timer0A_Addr
	LDR     R1, [R0]
	CMP     R1, #1
	BEQ 	update_data_timer0
	
	LDR     R0, =Timer1A_Addr
	LDR     R1, [R0]
	CMP     R1, #1
	BEQ 	update_data_timer1
	

	B MainLoop                   	;Volta para o laco principal


update_data_timer0
	LDR     R0, =Timer0A_Addr
	MOV 	R1, #0
	STR 	R1, [R0]

	BL		TecladoM_Poll

	LDR		R0, =PREV_KEYPRESS		; Recupera o último click e armazena o atual
	LDR 	R2, [R0]
	STR		R1, [R0]
	
	CMP 	R2, #0x10				; Pula se a última tecla for 0x10
	BEQ 	skip  
	
	CMP 	R1, #0x10				; Detecta falling-edge da tecla
	BNE 	skip  

	AND 	R1, R2, #0xFF		 	; Filtra os 8 LSB de R2
	CMP 	R1, #0x31			 	; Verifica se a tecla pressionada esta entre 1 e C
	BLO		skip
	
	CMP 	R1, #0x43
	BHI		skip
	
	LDR		R0, =CURR_KEY			; Atualiza a tecla atual
	STR		R1, [R0]
	
	BL 		calculate_angle_turn	
	

	BL		create_data_row

	B 		skip

update_data_timer1
	LDR     R0, =Timer1A_Addr       ; Zera o bit do endereço do interrupt do timer 1
	MOV     R1, #0
	STR     R1, [R0]

	B 		skip

skip
	B MainLoop
	

;--------------------------------------------------------------------------------------
    ALIGN                        	;Garante que o fim da secao esta alinhada 
    END                          	;Fim do arquivo
