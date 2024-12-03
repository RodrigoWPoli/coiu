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
; ~~~~~~~~~~~~~ OTHER CONSTANTS ~~~~~~~~~~~~~~
Timer0A_Addr             EQU     0x20010000
PREV_KEYPRESS            EQU     0x20020000

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
		IMPORT  Timer0A_Init
		IMPORT	Interrupt_Init

		IMPORT	TecladoM_Poll
		IMPORT  create_table
		IMPORT  multi_table
        IMPORT 	Timer0A_Handler
		IMPORT	LCD_Display_Character

; -------------------------------------------------------------------------------
; Funcao main()
Start  			
	BL 	PLL_Init					 ;Subrotina para alterar o clock do microcontrolador para 80MHz
	BL 	SysTick_Init				 ;
	BL 	GPIO_Init                 	 ;Subrotina que inicializa os GPIO
	BL 	LCD_Init                  	 ;Subrotina que inicializa o LCD
	BL 	Timer0A_Init              	 ;Subrotina que inicializa o Timer0A
	BL	Interrupt_Init				 ;Subrotina que inicializa os Interrupts de GPIO
	BL 	create_table				 ;Subrotina que cria a tabela de multiplicacao

; -------------------------------------------------------------------------------
; Laco principal
; R1 = valor da tecla pressionada


MainLoop
	LDR     R0, =Timer0A_Addr
	LDR     R1, [R0]
	CMP     R1, #1
	BEQ 	update_data
	MOV 	R2, #0
	STR     R2, [R0]

	B MainLoop                   ;Volta para o laco principal


update_data
	LDR     R0, =Timer0A_Addr
	MOV 	R1, #0
	STR 	R1, [R0]

	BL		TecladoM_Poll

	LDR		R0, =PREV_KEYPRESS
	LDR 	R2, [R0]
	STR 	R1, [R0]
	; PUSH 	{R1}
	; BL 		LCD_Display_Character
	; POP 	{R1}
	CMP 	R2, #0x10			; Se a última tecla for nula pula
	BEQ		skip

	CMP 	R1, #0x10			; Detecta falling-edge da tecla
	BNE 	skip 

	AND 	R1, R2, #0x0F		 ; Filtra os 4 LSB de R1
	CMP 	R1, #0x1			 ; Verifica se a tecla pressionada esta entre 1 e 9
	BLO		skip
	
	CMP 	R1, #0x9
	BHI		skip
	
	; R2 = resultado da multiplicacao
	BL multi_table
	
skip
	
	B MainLoop

    ALIGN                        ;Garante que o fim da secao esta alinhada 
    END                          ;Fim do arquivo
