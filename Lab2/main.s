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

		IMPORT	TecladoM_Poll
		IMPORT  create_table
		IMPORT  multi_table
        IMPORT Timer0A_Handler
		IMPORT	LCD_Display_Character

; -------------------------------------------------------------------------------
; Funcao main()
Start  			
	BL 	PLL_Init					 ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL 	SysTick_Init				 ;
	BL 	GPIO_Init                 	 ;Chama a subrotina que inicializa os GPIO
	BL 	LCD_Init                  	 ;Chama a subrotina que inicializa o LCD
	BL 	Timer0A_Init              	 ;Chama a subrotina que inicializa o Timer0A
	;BL 	create_table			 ;Chama a subrotina que cria a tabela de multiplicacao

; -------------------------------------------------------------------------------
; Laco principal
; R1 = valor da tecla pressionada
; R2 = valor da tabela de multiplicacao
; R3 = resultado da multiplicacao

MainLoop
	
	;PUSH 	{R1}
	;BL 		multi_table
	;POP 	{R1}
	;MULS 	R3, R1, R2 	; oq q é isso aqui?

	LDR     R0, =Timer0A_Addr
	LDR     R1, [R0]
	CMP     R1, #1
	IT     	EQ
	BLEQ	TecladoM_Poll
	MOV 	R2, #0
	STR     R2, [R0]

	ADD 	R1, R1, #2_00110000		 ;Adiciona valor para escrever no display LCD (se nenhuma tecla for pressionada o simbolo @:01000000 sera mostrado)
	BL 		LCD_Display_Character



	B MainLoop                   ;Volta para o laco principal


    ALIGN                        ;Garante que o fim da secao esta alinhada 
    END                          ;Fim do arquivo
