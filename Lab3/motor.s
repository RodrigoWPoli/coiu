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
MOTOR_PERIOD			 EQU 	 0x2


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
	BGE     skip_inverse_apolarity

	LDR		R1, =APOLARITY				;Transforma a polaridade em negativa porque houve mudança de sinal
	MOV		R3, #1
	STR		R3, [R1]

	NEG 	R2, R2						;Inverte o sinal do angulo para sempre ser positivo

skip_inverse_apolarity
	LDR 	R1, =ANGLE
	STR		R2, [R1]

	PUSH 	{R0, R1, R2, R3, R4}
	MOV 	R0, R4
	MOV 	R1, #1
	LDR 	R2, =MODE
	LDR 	R2, [R2]
	BL 		turn_motor
	POP 	{R0, R1, R2, R3, R4}

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

	PUSH 	{R0, R1, R2, R3, R4}
	MOV 	R0, R4
	MOV 	R1, #1
	LDR 	R2, =MODE
	LDR 	R2, [R2]
	BL 		turn_motor
	POP 	{R0, R1, R2, R3, R4}

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

	PUSH 	{R0, R1, R2, R3, R4}
	MOV 	R0, R4
	MOV 	R1, #0
	LDR 	R2, =MODE
	LDR 	R2, [R2]
	BL 		turn_motor
	POP 	{R0, R1, R2, R3, R4}

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

	PUSH 	{R0, R1, R2, R3, R4}
	MOV 	R0, R4
	MOV 	R1, #0
	LDR 	R2, =MODE
	LDR 	R2, [R2]
	BL 		turn_motor
	POP 	{R0, R1, R2, R3, R4}

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

; Funcao full_step_clockwise
; Input: nenhum
; Output: nenhum

full_step_clockwise
	MOV 	R1, #2_00001000
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 1 de 8 
	STR 	R1, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R2, #2_00000100
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 2 de 8 
	STR 	R2, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R3, #2_00000010
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 3 de 8 
	STR 	R3, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R4, #2_00000001
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 4 de 8 
	STR 	R4, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms
	
	MOV 	R1, #2_00001000
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 5 de 8 
	STR 	R1, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R2, #2_00000100
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 6 de 8 
	STR 	R2, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R3, #2_00000010
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 7 de 8 
	STR 	R3, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R4, #2_00000001
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 8 de 8 
	STR 	R4, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	B 		continue_cycle
;	----------------------------------------------------------------------

; Funcao full_step_counter_clockwise
; Input: nenhum
; Output: nenhum

full_step_counter_clockwise
	MOV 	R4, #2_00000001
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 8 de 8 
	STR 	R4, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R3, #2_00000010
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 7 de 8 
	STR 	R3, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R2, #2_00000100
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 6 de 8 
	STR 	R2, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R1, #2_00001000
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 5 de 8 
	STR 	R1, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms


	MOV 	R4, #2_00000001
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 4 de 8 
	STR 	R4, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms	

	MOV 	R3, #2_00000010
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 3 de 8 
	STR 	R3, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R2, #2_00000100
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 2 de 8 
	STR 	R2, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R1, #2_00001000
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 1 de 8 
	STR 	R1, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	B 		continue_cycle
;----------------------------------------------------------------------

; Funcao half_step_clockwise
; Input: nenhum
; Output: nenhum

half_step_clockwise
	MOV 	R1, #2_00001000
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 1 de 8 
	STR 	R1, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R2, #2_00001100
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 2 de 8 
	STR 	R2, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R3, #2_00000100
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 3 de 8 
	STR 	R3, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R4, #2_00000110
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 4 de 8 
	STR 	R4, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms
	
	MOV 	R1, #2_00000010
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 5 de 8 
	STR 	R1, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R2, #2_00000011
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 6 de 8 
	STR 	R2, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R3, #2_00000001
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 7 de 8 
	STR 	R3, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R4, #2_00001001
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 8 de 8 
	STR 	R4, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	B 		continue_cycle
;----------------------------------------------------------------------

; Funcao half_step_counter_clockwise
; Input: nenhum
; Output: nenhum

half_step_counter_clockwise
	MOV 	R4, #2_00001001
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 8 de 8 
	STR 	R4, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R3, #2_00000001
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 7 de 8 
	STR 	R3, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms
	
	MOV 	R2, #2_00000011
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 6 de 8 
	STR 	R2, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms
	
	MOV 	R1, #2_00000010
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 5 de 8 
	STR 	R1, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R4, #2_00000110
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 4 de 8 
	STR 	R4, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R3, #2_00000100
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 3 de 8 
	STR 	R3, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms
	
	MOV 	R2, #2_00001100
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 2 de 8 
	STR 	R2, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	MOV 	R1, #2_00001000
	LDR 	R0, =GPIO_PORTH_AHB_DATA_R  		; Realiza o passo 1 de 8 
	STR 	R1, [R0]
	LDR 	R2, =MOTOR_PERIOD
	BL		SysTick_Wait1ms

	B 		continue_cycle
;----------------------------------------------------------------------

; Funcao turn_motor
; Input: R0: angulo, R1: direcao, R2: modo
; Output: nenhum

turn_motor
	PUSH 	{LR}

	MOV 	R5, #2
	MOV 	R3, #256

	CMP 	R2, #1  	; Verifica se o modo é full-step (0) ou half-step (1) e atualiza o número de ciclos
	BNE 	skip_double_cycle
	MUL 	R3, R3, R5			;é os mulek

skip_double_cycle
	MUL 	R0, R0, R3

	MOV 	R3, #360
	UDIV 	R0, R0, R3

	MOV 	R3, #0

cycle
	PUSH	{R0, R1, R2, R3}

	CMP 	R1, #1  	; Verifica se a direção é horária (0) ou anti-horária (1)
	BEQ 	counter_clockwise

clockwise
	CMP 	R2, #0  	; Verifica se o modo é full-step (0) ou half-step (1)
	BEQ 	full_step_clockwise
	B		half_step_clockwise

counter_clockwise
	CMP 	R2, #0  	; Verifica se o modo é full-step (0) ou half-step (1)
	BEQ 	full_step_counter_clockwise
	B		half_step_counter_clockwise

continue_cycle
	POP		{R0, R1, R2, R3}
	ADD		R3, R3, #1
	CMP		R3, R0
	BNE		cycle

	POP 	{LR}
	BX		LR

    ALIGN
    END