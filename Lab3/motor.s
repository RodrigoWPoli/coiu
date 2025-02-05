;lcd.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 02/12/2024
; Ver 2 29/01/2025


; -------------------------------------------------------------------------------
		PRESERVE8 {TRUE}
		THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; ~~~~~~~~~~~~~ OTHER CONSTANTS ~~~~~~~~~~~~~~F
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

        EXPORT calculate_angle_turn
		
        IMPORT	SysTick_Wait1ms
		IMPORT  create_data_row
		IMPORT 	create_increment_row
		IMPORT  LCD_Display_Number
		IMPORT  LCD_Display_Character
		IMPORT  angle_decoder

; -------------------------------------------------------------------------------
; Funcao calculate_angle_turn
; Input: nenhum
; Output: nenhum

calculate_angle_turn
    PUSH    {LR}

    LDR 	R1, =CURR_KEY				;Incremento do angulo
    LDR 	R0, [R1]
	BL		angle_decoder
	MOV 	R4, R0

	BL 		create_increment_row		;Cria a linha de incremento

	LDR 	R1, =CURR_KEY				;Verifica se o incremento do angulo é negativo ou positivo
    LDR 	R0, [R1]
    CMP     R0, #0x37
    BLO     positive

    LDR     R0, =char_minus				;Valor negativo de incremento, subtrair de angulo positivo ou somar de angulo negativo
    BL      LCD_Display_Character		; printar - no display

	LDR 	R1, =APOLARITY				;Verifica polaridade: 0 = positivo, 1 = negativo
	LDR 	R2, [R1]
	CMP		R2, #1
	BEQ		negativeAngle
	
	LDR 	R1, =ANGLE					;Faz a subtração do angulo, porque o angulo é positivo e incremento negativo
	LDR 	R2, [R1]
	MOV		R0, R4
	SUB		R2, R0						;Verifica se houve mudança de sinal
	CMP		R2, #0
	BGE     skip_inverse_apolarity1

	LDR		R1, =APOLARITY				;Transforma a polaridade em negativa porque houve mudança de sinal
	MOV		R3, #1
	STR		R3, [R1]

	NEG 	R2, R2						;Inverte o sinal do angulo para sempre ser positivo

skip_inverse_apolarity1
	LDR 	R1, =ANGLE
	STR		R2, [R1]

	B 		display_number

negativeAngle
	LDR 	R1, =ANGLE					;Faz a soma do angulo, porque o angulo é negativo e incremento negativo
	LDR 	R2, [R1]
	MOV		R0, R4
	ADD		R2, R0

	CMP		R2, #360					;Verifica se bateu uma volta
	BLO		skip_add_turn

	LDR     R1, =TPOLARITY              ;Verifica polaridade: 0 = positivo, 1 = negativo
    LDR     R3, [R1]                    ;Se a polaridade for negativa, somar mais um, se for positiva, subtrair um
    LDR     R1, =TURN
    LDR     R5, [R1]
    CMP     R3, #1
    ITE     EQ
    ADDEQ   R5, #1
    SUBNE   R5, #1                      ;Verificar se as voltas caíram para um valor negativo

    CMP     R5, #0
    LDR     R1, =TPOLARITY
    MOV     R6, #1
    ITT     LT							;Se caiu para valor negativo, coloco positivo a volta e mudo a polaridade
    NEGLT   R5, R5
    STRLT   R6, [R1]

	LDR 	R1, =TURN
    STR     R5, [R1]

	SUB 	R2, #360
	LDR		R1, =ANGLE
	
skip_add_turn
	STR		R2, [R1]

	B 		display_number
positive   

	LDR 	R1, =APOLARITY				;Verifica polaridade: 0 = positivo, 1 = negativo
	LDR 	R2, [R1]
	CMP		R2, #0
	BEQ		positiveAngle
	
	LDR 	R1, =ANGLE					;Faz a subtração do angulo, porque o angulo é negativo e incremento positivo
	LDR 	R2, [R1]
	MOV		R0, R4
	SUB		R2, R0						;Verifica se houve mudança de sinal
	CMP		R2, #0
	BGE     skip_inverse_apolarity2

	LDR		R1, =APOLARITY				;Transforma a polaridade em positiva porque houve mudança de sinal
	MOV		R3, #0
	STR		R3, [R1]

	NEG 	R2, R2						;Inverte o sinal do angulo para sempre ser positivo

skip_inverse_apolarity2
	LDR 	R1, =ANGLE
	STR		R2, [R1]

	B 		display_number

positiveAngle
	LDR 	R1, =ANGLE					;Faz a soma do angulo, porque o angulo é positivo e incremento positivo
	LDR 	R2, [R1]
	MOV		R0, R4
	ADD		R2, R0

	CMP		R2, #360					;Verifica se bateu uma volta
	BLO		skip_add_turn2

	LDR     R1, =TPOLARITY              ;Verifica polaridade: 0 = positivo, 1 = negativo
    LDR     R3, [R1]                    ;Se a polaridade for positiva, somar mais um, se for negativa, subtrair um
    LDR     R1, =TURN
    LDR     R5, [R1]
    CMP     R3, #0
    ITE     EQ
    ADDEQ   R5, #1
    SUBNE   R5, #1                      ;Verificar se as voltas subiram para um valor positivo

    CMP     R5, #0
    LDR     R1, =TPOLARITY
    MOV     R6, #0
    ITT     LT							;Se subiu para valor positivo, coloco positivo a volta e mudo a polaridade
    NEGLT   R5, R5
    STRLT   R6, [R1]

	LDR 	R1, =TURN
    STR     R5, [R1]

	SUB 	R2, #360
	LDR		R1, =ANGLE
	
skip_add_turn2
	STR		R2, [R1]

	B 		display_number
	
display_number
	
	MOV 	R0, R4
    BL      LCD_Display_Number      	; Chama função C
	LDR		R0, =char_angle
	BL		LCD_Display_Character
	
	MOV 	R2, #1000
	BL		SysTick_Wait1ms

    POP     {LR}
    BX      LR

;----------------------------------------------------------------------

    ALIGN
    END