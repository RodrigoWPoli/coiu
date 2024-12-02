; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Este programa espera o usu�rio apertar a chave USR_SW1 e/ou a chave USR_SW2.
; Caso o usu�rio pressione a chave USR_SW1, acender� o LED3 (PF4). Caso o usu�rio pressione 
; a chave USR_SW2, acender� o LED4 (PF0). Caso as duas chaves sejam pressionadas, os dois 
; LEDs acendem.

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================


; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi��o da RAM		

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun��o Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma fun��o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; fun��o <func>
		IMPORT	PLL_Init
		IMPORT	SysTick_Init
        IMPORT	SysTick_Wait1us
		IMPORT	GPIO_Init
		IMPORT	LCD_Init
		IMPORT	TecladoM_Poll

		IMPORT	LCD_Display_Character

; -------------------------------------------------------------------------------
; Fun��o main()
Start  			
	BL PLL_Init					 ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init				 ;
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	BL LCD_Init                  ;Chama a subrotina que inicializa o LCD

MainLoop
	BL LCD_Display_Character
	BL TecladoM_Poll
	B MainLoop                   ;Volta para o laco principal	


    ALIGN                        ;Garante que o fim da secao esta alinhada 
    END                          ;Fim do arquivo
