;lcd_char.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 02/12/2024


; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ========================

; ================== DEFINICAO DA TABELA ===================

char_T              EQU 2_01010100
char_a              EQU 2_01100001
char_b              EQU 2_01100010
char_u              EQU 2_01110101
char_d              EQU 2_01100100
char_o              EQU 2_01101111
char_0              EQU 2_00110000
char_1              EQU 2_00110001
char_2              EQU 2_00110010
char_3              EQU 2_00110011
char_4              EQU 2_00110100
char_5              EQU 2_00110101
char_6              EQU 2_00110110
char_7              EQU 2_00110111
char_8              EQU 2_00111000
char_9              EQU 2_00111001
char_equal          EQU 2_00111101
char_X              EQU 2_01011000
char_x              EQU 2_01111000
char_cdot           EQU 2_10100101
char_R              EQU 2_01010010
char_e              EQU 2_01100101
char_s              EQU 2_01110011
char_t              EQU 2_01110100
char_n              EQU 2_01101110
char_dot            EQU 2_00101110
char_space          EQU 2_00100000
	
CURR_KEY	    	EQU	0x20020004
MULTI_HEAD	    	EQU 0x20000A00


; -------------------------------------------------------------------------------
; Area de Codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

        EXPORT create_first_row
        EXPORT create_second_row
        EXPORT create_reset_row

        IMPORT LCD_Display_Character
        IMPORT LCD_Reset

; ------------------------------------------------------------------------------
; Funcao create_first_row
; Seta hardcode no LCD para apresentar "Tabuada do n"
; Parametro de entrada: nenhum
; Parametro de saida: nenhum
create_first_row
        PUSH    {LR}

        BL      LCD_Reset

        LDR     R1, =char_T
        BL      LCD_Display_Character 
        LDR     R1, =char_a
        BL      LCD_Display_Character 
        LDR     R1, =char_b
        BL      LCD_Display_Character 
        LDR     R1, =char_u
        BL      LCD_Display_Character 
        LDR     R1, =char_a
        BL      LCD_Display_Character 
        LDR     R1, =char_d
        BL      LCD_Display_Character 
        LDR     R1, =char_a
        BL      LCD_Display_Character 
        LDR     R1, =char_space
        BL      LCD_Display_Character 
        LDR     R1, =char_d
        BL      LCD_Display_Character 
        LDR     R1, =char_o
        BL      LCD_Display_Character 
        LDR     R1, =char_space
        BL      LCD_Display_Character	
        
        LDR 	R0, =CURR_KEY
        LDR 	R1, [R0]
        ORR     R1, R1, #0x30     
        BL      LCD_Display_Character


        POP     {LR} 
        BX      LR

; ------------------------------------------------------------------------------
; Funcao create_second_row
; Seta hardcode no LCD para apresentar "n x fator = res"
; Parametro de entrada: R2 = fator, R3 = resultado
; Parametro de saida: nenhum
create_second_row
        PUSH    {LR}

        LDR 	R0, =CURR_KEY		; Recupera o valor da tecla atual
        LDR 	R1, [R0]
        ORR     R1, R1, #0x30
		
        BL      LCD_Display_Character
        LDR     R1, =char_space
        BL      LCD_Display_Character
        LDR     R1, =char_x
        BL      LCD_Display_Character
        LDR     R1, =char_space
        BL      LCD_Display_Character
		
		LDR 	R0, =CURR_KEY
        LDR 	R1, [R0]
		
        LDR 	R0, =MULTI_HEAD			; Recupera o fator multiplicativo da memoria
		ADD     R0, R0, R1
        LDR 	R2, [R0]
		
		MUL 	R3, R2, R1
		
        ORR     R1, R2, #0x30
        BL      LCD_Display_Character
        LDR     R1, =char_space
        BL      LCD_Display_Character
        LDR     R1, =char_equal
        BL      LCD_Display_Character
        LDR     R1, =char_space
        BL      LCD_Display_Character
        
		MOV 	R1, R3
		AND 	R1, R1, #0xFF
		CMP 	R1, #10
		BLO 	single_dig
		
		MOV 	R4, #1
		MOV		R2, #10
loop_2nd_dig
		ADD 	R4, R4, #1
		MUL 	R5, R4, R2
		CMP 	R1, R5
		BHS 	loop_2nd_dig
		
		SUB 	R1, R4, #1
		PUSH 	{R1}
		ORR     R1, R1, #0x30
        BL      LCD_Display_Character
		POP 	{R1}
		MOV		R2, #10
		MUL 	R4, R1, R2
		MOV 	R1, R3
		SUB 	R1, R1, R4

single_dig
		ORR     R1, R1, #0x30
        BL      LCD_Display_Character

        POP     {LR}
        BX      LR

; ------------------------------------------------------------------------------
; Funcao create_reset_row
; Seta hardcode no LCD para apresentar "Resetando..."
; Parametro de entrada: nenhum
; Parametro de saida: nenhum
create_reset_row
        PUSH    {LR}

        BL      LCD_Reset

        ; Resetando
        LDR     R1, =char_R
        BL      LCD_Display_Character 
        LDR     R1, =char_e
        BL      LCD_Display_Character 
        LDR     R1, =char_s
        BL      LCD_Display_Character 
        LDR     R1, =char_e
        BL      LCD_Display_Character 
        LDR     R1, =char_t
        BL      LCD_Display_Character 
        LDR     R1, =char_a
        BL      LCD_Display_Character 
        LDR     R1, =char_n
        BL      LCD_Display_Character 
        LDR     R1, =char_d
        BL      LCD_Display_Character 
        LDR     R1, =char_o
        BL      LCD_Display_Character 
;        LDR     R1, =char_dot
;        BL      LCD_Display_Character
;        LDR     R1, =char_dot
;        BL      LCD_Display_Character
;        LDR     R1, =char_dot
;        BL      LCD_Display_Character
    

        ; ... piscando
        MOV    R9, #0                               ;quantidade de iteracoes geral
blink_loop  
        CMP    R9, #3                               ;Enquanto nao fizer x vezes, nao finaliza
        BEQ    display_resetado

display_dots
        ADD    R9, #1                               ;Soma 1 no iterador

        LDR    R1, =char_dot
        BL     LCD_Display_Character                
        MOV    R2, #100
        BL     SysTick_Wait1ms                      ;Mostra primeiro ponto e espera um pouco
        LDR    R1, =char_dot
        BL     LCD_Display_Character                
        MOV    R2, #100
        BL     SysTick_Wait1ms                      ;Mostra segundo ponto e espera um pouco
        LDR    R1, =char_dot
        BL     LCD_Display_Character                
        MOV    R2, #100
        BL     SysTick_Wait1ms                      ;Mostra terceiro ponto e espera um pouco


LCD_Clear_Tail                                      ;limpa os 3 pontos finais

            MOV     R8, #0                          ;contador de iteracoes de espacos
            MOV     R7, #0                          ;contador de iteracoes de left shift
cursor_shift_left                                   ;Volta os 3 dígitos para esquerda
            LDR     R0, =GPIO_PORTK_DATA_R          
            MOV     R1, #2_10000
            STR     R1, [R0]

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #2_100
            STR     R1, [R0]

            MOV     R0, #2
            BL      SysTick_Wait1us

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x00
            STR     R1, [R0]

            ADD     R8, #1
            CMP     R8, #3
            BNE     cursor_shift_left

display_spaces                                      ;Mostra 3 espaços caso ja nao tenha mostrado
            CMP     R7, #1
            BEQ     blink_loop                      ;Se nao voltou depois do espaco, volta. Se voltou, printa pontos dnv ou sai do loop

            LDR    R1, =char_space
            BL     LCD_Display_Character                
            LDR    R1, =char_space
            BL     LCD_Display_Character                
            LDR    R1, =char_space
            BL     LCD_Display_Character                
            
            ADD    R7, #1                           ;Se for primeira vez mostrando espaços, seta a flag
display_resetado

        BL      LCD_Reset

        ; Resetado
        LDR     R1, =char_R
        BL      LCD_Display_Character 
        LDR     R1, =char_e
        BL      LCD_Display_Character 
        LDR     R1, =char_s
        BL      LCD_Display_Character 
        LDR     R1, =char_e
        BL      LCD_Display_Character 
        LDR     R1, =char_t
        BL      LCD_Display_Character 
        LDR     R1, =char_a
        BL      LCD_Display_Character 
        LDR     R1, =char_d
        BL      LCD_Display_Character 
        LDR     R1, =char_o
        BL      LCD_Display_Character 
        
        POP     {LR} 
        BX      LR


    ALIGN
    END