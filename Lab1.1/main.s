; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araújo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Última atualização: 11/11/2024
; Este programa deve esperar o usu�rio pressionar uma chave.
; Caso o usuário pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; Definições de Valores


; -------------------------------------------------------------------------------
; �rea de Dados - Declarações de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT  GPIO_Init
        IMPORT  Led_Output
		IMPORT  Switch_Input
		IMPORT  Display_Output
; -------------------------------------------------------------------------------
; Função main()
Start  
; Comece o código aqui <======================================================
    
    BL PLL_Init                     ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init                 ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init                    ;Chama a subrotina que inicializa os GPIO

	MOV R0, #0x00000110 
	BL Display_Output

	MOV R0, #0x00000101 
	BL Display_Output
; R0 -> Contador
; R1 -> Passo a ser incrementado no contador
; R2 -> Quantidade de ticks de ms
; R3 -> Direção do contador
	MOV R0, #1
	MOV R1, #1
	MOV R2, #500
MainLoop
	BL PrintValue

Loop
	CMP R0, #2_11
	BNE Step_handler
	ADD R0, R1
	CMP R1, #0
	BLT CheckUnderflow
	CMP R1, #99
	BGT CheckOverflow
	
	B MainLoop

Step_handler
	CMP R0, #2_10
	BNE Neg_handler
	CMP R1, #9
	ITE LO
	ADDLO R1, #1
	MOVHS R1, #0
	
	B MainLoop

Neg_handler
	CMP R0, #2_01
	BNE Both_handler
	NEG R1, R1
	B MainLoop

Both_handler
	CMP R0, #2_00
	BNE MainLoop
	CMP R1, #9
	ITE LO
	ADDLO R1, #1
	MOVHS R1, #0
	NEG R1, R1
	B MainLoop

CheckUnderflow
	CMP R1, #0
	BGE MainLoop
	MOV R1, #99
	B MainLoop

CheckOverflow
	CMP R1, #99
	BLE MainLoop
	MOV R1, #0
	B MainLoop
	
PrintValue
	PUSH {LR}
	BL Led_Output
	BL Switch_Input
	MOV R2, #1000
	BL SysTick_Wait1ms
	POP {LR}
	BX  LR
; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
