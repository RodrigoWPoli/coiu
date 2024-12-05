;led_blinking.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 02/12/2024


; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ========================

; ================== DEFINICAO DA TABELA ===================
GPIO_PORTA_AHB_DATA_R   	EQU    0x400583FC
GPIO_PORTP_DATA_R           EQU    0x400653FC
GPIO_PORTQ_DATA_R           EQU    0x400663FC
Timer1A_Addr                EQU    0x20010004
MULTI_HEAD	                EQU    0x20000A00
CURR_KEY					EQU	   0x20020004
BLINKING_COUNTER            EQU    0x20010008

; -------------------------------------------------------------------------------
; Area de Codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

        EXPORT blink_leds

; ------------------------------------------------------------------------------
; Funcao blink_leds
; Checa se tem q ligar ou desligar os LEDs. Calcula quais LEDs tem que ligar.
blink_leds

            LDR		R0, =CURR_KEY		; Recupera a tecla atual
			LDR 	R1, [R0]

            LDR     R0, =MULTI_HEAD     
            ADD     R0, R0, R1
            LDRB    R2, [R0]            ; Carrega o valor atual da tabuada do dígito em R2

            CMP     R2, #0
            BEQ     reset_leds

            LDR     R0, =BLINKING_COUNTER ; Recupera o valor de contagem atual para alterar a frequência do blink
            LDR     R3, [R0]
            ADD     R3, R3, #1            ; Incrementa o contador em 1
            STR     R3, [R0]

            CMP     R3, R1
            BLO     leds_wait_state       ; Pula o toggle até chegar na contagem para realizar o delay

            LDR     R0, =BLINKING_COUNTER
            MOV     R3, #0
            STR     R3, [R0]

            LDR     R0, =GPIO_PORTP_DATA_R
            LDR     R1, [R0]                ; Recupera a configuração anterior dos LEDs

            CMP     R1, #2_00000000
            ITE     EQ                      ; Toggles the LEDs to make them blink
            MOVEQ   R1, #2_00100000
            MOVNE   R1, #2_00000000
            STR     R1, [R0]

			LDR		R0, =CURR_KEY		; Recupera a tecla atual
			LDR 	R1, [R0]
			
            LDR     R0, =MULTI_HEAD     
            ADD     R0, R0, R1
            LDRB    R2, [R0]            ; Carrega o valor atual da tabuada do dígito em R2
            
            CMP     R2, #1
            BEQ     set_led1

            CMP     R2, #2
            BEQ     set_led2

            CMP     R2, #3
            BEQ     set_led3

            CMP     R2, #4
            BEQ     set_led4

            CMP     R2, #5
            BEQ     set_led5

            CMP     R2, #6
            BEQ     set_led6

            CMP     R2, #7
            BEQ     set_led7

            CMP     R2, #8
            BEQ     set_led8

            CMP     R2, #9
            BEQ     set_led8

set_led1
            MOV     R1, #2_10000000
            B       blink_leds_return
set_led2
            MOV     R1, #2_11000000
            B       blink_leds_return            

set_led3
            MOV     R1, #2_11100000
            B       blink_leds_return

set_led4
            MOV     R1, #2_11110000
            B       blink_leds_return

set_led5
            MOV     R1, #2_11111000
            B       blink_leds_return

set_led6
            MOV     R1, #2_11111100
            B       blink_leds_return

set_led7
            MOV     R1, #2_11111110
            B       blink_leds_return

set_led8
            MOV     R1, #2_11111111
            B       blink_leds_return

reset_leds  
            MOV     R1, #2_00000000
            B       blink_leds_return

leds_wait_state
            LDR 	R0, =GPIO_PORTA_AHB_DATA_R
            LDR     R1, [R0]

            LDR 	R0, =GPIO_PORTQ_DATA_R
            LDR     R2, [R0]
            ORR     R1, R1, R2

            B       blink_leds_return

blink_leds_return
			; A4-A7     Q0-Q3
			AND		R2, R1, #0xF0
			LDR 	R0, =GPIO_PORTA_AHB_DATA_R
            STR     R2, [R0]
			
            AND		R2, R1, #0x0F
			LDR 	R0, =GPIO_PORTQ_DATA_R
            STR     R2, [R0]

            BX LR




            ALIGN
            END