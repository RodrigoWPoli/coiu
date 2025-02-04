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
; ========================
GPIO_PORTK_DATA_R           EQU     0x400613FC 
GPIO_PORTM_DATA_R           EQU     0x400633FC


; ================== DEFINICAO DA TABELA ===================

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
char_cdot           EQU 2_10100101
char_dot            EQU 2_00101110
char_angle          EQU 2_11011111
char_plus           EQU 2_00101011
char_minus          EQU 2_00101101
char_space          EQU 2_00100000
char_dois_pontos    EQU 2_00111010
char_parenteses_dir EQU 2_00101001
char_A              EQU 2_01000001   
char_D              EQU 2_01011000
char_I              EQU 2_01001001
char_P              EQU 2_01010000
char_R              EQU 2_01010010
char_V              EQU 2_01010110    
char_a              EQU 2_01100001
char_b              EQU 2_01100010
char_c              EQU 2_01100011
char_d              EQU 2_01100100
char_e              EQU 2_01100101
char_g              EQU 2_01100111   
char_i              EQU 2_01101001
char_l              EQU 2_01101100
char_m              EQU 2_01101101
char_n              EQU 2_01101110
char_o              EQU 2_01101111
char_r              EQU 2_01110010
char_s              EQU 2_01110011
char_t              EQU 2_01110100
char_u              EQU 2_01110101
char_x              EQU 2_01111000

	
CURR_KEY	    EQU	0x20020004
ANGLE               EQU 0x20030000
TURN	            EQU	0x20030004
APOLARITY           EQU 0x2003000C
TPOLARITY           EQU 0x20030010

; -------------------------------------------------------------------------------
; Area de Codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

        EXPORT create_data_row
        EXPORT create_increment_row
        EXPORT create_reset_row
        EXPORT LCD_Display_Character
        EXPORT LCD_go_to_second_line
        EXPORT LCD_Reset


        IMPORT SysTick_Wait1ms
        IMPORT SysTick_Wait1us

        IMPORT LCD_Display_Number
; -------------------------------------------------------------------------------
; Funcao LCD_Display_Character
; Input: R0 -> Dado a ser mostrado no display

LCD_Display_Character
            PUSH    {LR}
            
            LDR     R1, =GPIO_PORTK_DATA_R                  ; Dado a ser mostrado
            STR     R0, [R1]

            LDR     R1, =GPIO_PORTM_DATA_R
            MOV     R0, #2_101
            STR     R0, [R1]

            LDR     R2, =1
            BL      SysTick_Wait1ms
            
            LDR     R1, =GPIO_PORTM_DATA_R
            MOV     R0, #0x00
            STR     R0, [R1]
			
			LDR     R2, =1
            BL      SysTick_Wait1ms

            POP     {LR}
            BX      LR

; -------------------------------------------------------------------------------
; Funcao LCD_go_to_second_line
; Faz com que o cursor va para a segunda linha do display
; Parametro de entrada: nenhum
; Parametro de saida: nenhum

LCD_go_to_second_line
            PUSH    {LR}

            LDR     R0, =GPIO_PORTK_DATA_R          ;Retorna para home
            MOV     R1, #2_10
            STR     R1, [R0]

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #2_100
            STR     R1, [R0]

            MOV     R2, #2
            BL      SysTick_Wait1ms

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x00
            STR     R1, [R0]                        ;Retornou para home
			
			MOV     R3, #0
cursor_shift_right                                  ;Pula os 40 digitos
            LDR     R0, =GPIO_PORTK_DATA_R          
            MOV     R1, #2_10100
            STR     R1, [R0]

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #2_100
            STR     R1, [R0]

            MOV     R0, #2
            BL      SysTick_Wait1us

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x00
            STR     R1, [R0]

            ADD     R3, #1
            CMP     R3, #40
            BNE     cursor_shift_right

            POP     {LR}
            BX      LR

; -------------------------------------------------------------------------------
; Funcao LCD_Reset
; Reseta os valores de DDRAM do LCD
; Parametro de entrada: nenhum
; Parametro de saida: nenhum
LCD_Reset
            PUSH    {LR}

            LDR     R0, =GPIO_PORTK_DATA_R          ;Clear no display     
            MOV     R1, #2_1                        
            STR     R1, [R0]

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #2_100
            STR     R1, [R0]
			
			MOV     R2, #1
            BL      SysTick_Wait1ms

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x00
            STR     R1, [R0]
			
			MOV     R2, #1
            BL      SysTick_Wait1ms

            LDR     R0, =GPIO_PORTK_DATA_R          ;Retorna para home
            MOV     R1, #2_10
            STR     R1, [R0]

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #2_100
            STR     R1, [R0]

            MOV     R2, #1
            BL      SysTick_Wait1ms

            LDR     R0, =GPIO_PORTM_DATA_R
            MOV     R1, #0x00
            STR     R1, [R0]                        ;Retornou para home

			MOV     R2, #1
            BL      SysTick_Wait1ms
			
            POP     {LR}
            BX      LR
; ------------------------------------------------------------------------------
; Funcao create_data_row
; Seta hardcode no LCD para apresentar "Angulo: ang Volta: turn"
; Parametro de entrada: nenhum
; Parametro de saida: nenhum
create_data_row
        PUSH    {LR}

        BL      LCD_Reset

        LDR     R0, =char_A
        BL      LCD_Display_Character 
        LDR     R0, =char_n
        BL      LCD_Display_Character 
        LDR     R0, =char_g
        BL      LCD_Display_Character 
        LDR     R0, =char_u
        BL      LCD_Display_Character 
        LDR     R0, =char_l
        BL      LCD_Display_Character 
        LDR     R0, =char_o
        BL      LCD_Display_Character 
        LDR     R0, =char_dois_pontos
        BL      LCD_Display_Character 
        LDR     R0, =char_space
        BL      LCD_Display_Character 
        ;Aqui fazer receber o valor de ang, separar ele em até 3 digitos e mostrar
        
        LDR     R1, =ANGLE
        LDR     R0, [R1]
        MOV     R2, #0
        CMP     R0, R2
        BHS     positive

        LDR     R0, =char_minus
        BL      LCD_Display_Character
positive       

        LDR     R1, =ANGLE
        LDR     R0, [R1]
        BL      LCD_Display_Number      ; Chama função C
		
        LDR     R0, =char_angle
        BL      LCD_Display_Character

        BL      LCD_go_to_second_line

        LDR     R0, =char_V
        BL      LCD_Display_Character 
        LDR     R0, =char_o
        BL      LCD_Display_Character 
        LDR     R0, =char_l
        BL      LCD_Display_Character	
        LDR     R0, =char_t
        BL      LCD_Display_Character
        LDR     R0, =char_a
        BL      LCD_Display_Character
        LDR     R0, =char_dois_pontos
        BL      LCD_Display_Character
        LDR     R0, =char_space
        BL      LCD_Display_Character
        ;Aqui fazer receber o valor de turn, separar ele em até 3 digitos e mostrar, lembrar que pode ser negativo

        LDR     R1, =TURN
        LDR     R0, [R1]
        MOV     R2, #0
        CMP     R0, R2
        BHS     positive2

        LDR     R0, =char_minus
        BL      LCD_Display_Character
positive2       

        LDR     R1, =TURN
        LDR     R0, [R1]
        BL      LCD_Display_Number      ; Chama função C

        POP     {LR} 
        BX      LR

; ------------------------------------------------------------------------------
; Funcao create_increment_row
; Seta hardcode no LCD para apresentar "Incremento: inc"
; Parametro de entrada: nenhum
; Parametro de saida: nenhum
create_increment_row
        PUSH    {LR}
		
		BL      LCD_Reset
		
        LDR     R0, =char_I
        BL      LCD_Display_Character
        LDR     R0, =char_n
        BL      LCD_Display_Character
        LDR     R0, =char_c
        BL      LCD_Display_Character
        LDR     R0, =char_r
        BL      LCD_Display_Character
        LDR     R0, =char_e
        BL      LCD_Display_Character
        LDR     R0, =char_m
        BL      LCD_Display_Character
        LDR     R0, =char_e
        BL      LCD_Display_Character
        LDR     R0, =char_n
        BL      LCD_Display_Character
        LDR     R0, =char_t
        BL      LCD_Display_Character
        LDR     R0, =char_o
        BL      LCD_Display_Character
        LDR     R0, =char_dois_pontos
        BL      LCD_Display_Character
        LDR     R0, =char_space
        BL      LCD_Display_Character

        
        POP     {LR}
        BX      LR

; ------------------------------------------------------------------------------
; Funcao create_mode_row
; Seta hardcode no LCD para apresentar "Modo de passo: mode"
; Parametro de entrada: nenhum
; Parametro de saida: nenhum
create_mode_row
        PUSH    {LR}
		
        LDR     R0, =char_I
        BL      LCD_Display_Character
        LDR     R0, =char_n
        BL      LCD_Display_Character
        LDR     R0, =char_c
        BL      LCD_Display_Character
        LDR     R0, =char_r
        BL      LCD_Display_Character
        LDR     R0, =char_e
        BL      LCD_Display_Character
        LDR     R0, =char_m
        BL      LCD_Display_Character
        LDR     R0, =char_e
        BL      LCD_Display_Character
        LDR     R0, =char_n
        BL      LCD_Display_Character
        LDR     R0, =char_t
        BL      LCD_Display_Character
        LDR     R0, =char_o
        BL      LCD_Display_Character
        LDR     R0, =char_dois_pontos
        BL      LCD_Display_Character
        LDR     R0, =char_space
        BL      LCD_Display_Character
        ;Aqui fazer receber o valor de inc, separar ele em até 3 digitos e mostrar
        ;BL    LCD_Display_Increment
        
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
        LDR     R0, =char_R
        BL      LCD_Display_Character 
        LDR     R0, =char_e
        BL      LCD_Display_Character 
        LDR     R0, =char_s
        BL      LCD_Display_Character 
        LDR     R0, =char_e
        BL      LCD_Display_Character 
        LDR     R0, =char_t
        BL      LCD_Display_Character 
        LDR     R0, =char_a
        BL      LCD_Display_Character 
        LDR     R0, =char_n
        BL      LCD_Display_Character 
        LDR     R0, =char_d
        BL      LCD_Display_Character 
        LDR     R0, =char_o
        BL      LCD_Display_Character     

        ; ... piscando
        MOV    R9, #0                               ;quantidade de iteracoes geral
blink_loop  
        CMP    R9, #5                               ;Enquanto nao fizer x vezes, nao finaliza
        BEQ    display_resetado

display_dots
        ADD    R9, #1                               ;Soma 1 no iterador

        LDR    R0 , =char_dot
        BL     LCD_Display_Character                
        MOV    R2, #150
        BL     SysTick_Wait1ms                      ;Mostra primeiro ponto e espera um pouco
        LDR    R0, =char_dot
        BL     LCD_Display_Character                
        MOV    R2, #150
        BL     SysTick_Wait1ms                      ;Mostra segundo ponto e espera um pouco
        LDR    R0, =char_dot
        BL     LCD_Display_Character                
        MOV    R2, #150
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
		
		MOV     R0, #2
		BL      SysTick_Wait1us

		ADD     R8, #1
		CMP     R8, #3
		BNE     cursor_shift_left
		

display_spaces                                      ;Mostra 3 espaços caso ja nao tenha mostrado
		LDR    R0, =char_space
		BL     LCD_Display_Character                
		LDR    R0, =char_space
		BL     LCD_Display_Character                
		LDR    R0, =char_space
		BL     LCD_Display_Character

		MOV    R2, #150
		BL     SysTick_Wait1ms 
		
		MOV     R8, #0
cursor_shift_left2
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
		
		MOV     R0, #2
		BL      SysTick_Wait1us

		ADD     R8, #1
		CMP     R8, #3
		BNE     cursor_shift_left2
		
		B     blink_loop                      ;Se nao voltou depois do espaco, volta. Se voltou, printa pontos dnv ou sai do loop
			
display_resetado
        ; Resetar os valores de ang e turn

        ;TO-DO

        ;Mostrar data novamente
		BL      create_data_row
		
        POP     {LR} 
        BX      LR


    ALIGN
    END