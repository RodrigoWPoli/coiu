; timers.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 02/12/2024

; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Definicoes dos Registradores Gerais
SYSCTL_RCGCTIMER_R	        EQU	    0x400FE604
SYSCTL_PRTIMER_R	        EQU	    0x400FEA04
; ========================
; Definicoes dos Timers
; ~~~~~~~~~~~~~~~~ Timer 0 ~~~~~~~~~~~~~~~~~~
TIMER0_A_NVIC_INT_NUM   EQU     19
TIMER0_A_NVIC_PRIO_R    EQU     0xE000E410
TIMER0_A_NVIC_EN_R      EQU     0xE000E100
TIMER0_CFG_R            EQU     0x40030000
TIMER0_TAMR_R           EQU     0x40030004
TIMER0_CTL_R            EQU     0x4003000C
TIMER0_IMR_R            EQU     0x40030018
TIMER0_ICR_R            EQU     0x40030024
TIMER0_TAILR_R          EQU     0x40030028
TIMER0_TAPR_R           EQU     0x40030038
TIMER0 		            EQU     2_00000001
; ~~~~~~~~~~~~~~~~ Timer 1 ~~~~~~~~~~~~~~~~~~
TIMER1_A_NVIC_INT_NUM   EQU     21
TIMER1_A_NVIC_PRIO_R    EQU     0xE000E414
TIMER1_A_NVIC_EN_R      EQU     0xE000E100
TIMER1_CFG_R            EQU     0x40031000
TIMER1_TAMR_R           EQU     0x40031004
TIMER1_CTL_R            EQU     0x4003100C
TIMER1_IMR_R            EQU     0x40031018
TIMER1_ICR_R            EQU     0x40031024
TIMER1_TAILR_R          EQU     0x40031028
TIMER1_TAPR_R           EQU     0x40031038
TIMER1 		            EQU     2_00000010

; ~~~~~~~~~~~~~ OTHER CONSTANTS ~~~~~~~~~~~~~~
Timer0A_Addr             EQU     0x20010000
Timer1A_Addr             EQU     0x20010004


; -------------------------------------------------------------------------------
; Area de Codigo - Tudo abaixo da diretiva a seguir sera armazenado na memoria de 
;                  codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funcao do arquivo for chamada em outro arquivo	
        EXPORT Timers_Init
        EXPORT Timer0A_Handler
        EXPORT Timer1A_Handler

									
;--------------------------------------------------------------------------------
Timers_Init
            LDR     R0, =SYSCTL_RCGCTIMER_R             ; Seta o timer 0 para ser usado
            MOV     R1, #TIMER0
            ORR     R1, #TIMER1
            STR     R1, [R0]

            LDR     R0, =SYSCTL_PRTIMER_R
EsperaTIMERS
            LDR     R2, [R0]
            TST     R1, R2
            BEQ     EsperaTIMERS

            PUSH {LR}
            
            BL Timer0A_Init
            BL Timer1A_Init
            
            POP {LR}
            BX LR

Timer0A_Init
            LDR     R0, =Timer0A_Addr
            MOV     R1, #0
            STR     R1, [R0]            

            LDR     R0, =TIMER0_CTL_R             ; Desabilita o timer 0
            MOV     R1, #0
            STR     R1, [R0]

            LDR     R0, =TIMER0_CFG_R             ; Configura o modo de 32 bits
            MOV     R1, #0x0
            STR     R1, [R0]

            LDR     R0, =TIMER0_TAMR_R            ; Define o modo one-shot=0x01 ou periódico=0x02
            MOV     R1, #0x2
            STR     R1, [R0]

            LDR     R0, =TIMER0_TAILR_R           ; Tempo calculado para 20ms
            LDR     R1, =1600000                    
            STR     R1, [R0]

            LDR     R0, =TIMER0_TAPR_R            ; Configura o Prescaler 
            MOV     R1, #0                        ; 0 para desabilitado
            STR     R1, [R0]

            LDR     R0, =TIMER0_ICR_R             ; Garante que a primeira interrupcao sera atendida (?)
            MOV     R1, #1
            STR     R1, [R0]

            LDR     R0, =TIMER0_IMR_R             ; Utiliza a interrupcao para estouro do timer
            MOV     R1, #1
            STR     R1, [R0]
            
            MOV     R0, #4                        ; Configura a prioridade da interrupcao do timer
            LSL     R0, R0, #29
            LDR     R1, =TIMER0_A_NVIC_PRIO_R
            STR     R0, [R1]

            MOV     R0, #1                        ; Habilita a interrupcao do Timer 0A no NVIC Enable Register
            LSL     R0, R0, #TIMER0_A_NVIC_INT_NUM
            LDR     R1, =TIMER0_A_NVIC_EN_R
            STR     R0, [R1]

            LDR     R0, =TIMER0_CTL_R             ; Habilita o timer 0
            MOV     R1, #1
            STR     R1, [R0]

            BX LR


Timer0A_Handler

            LDR     R0, =TIMER0_ICR_R             ; Limpa o bit da interrupcao
            MOV     R1, #1
            STR     R1, [R0]

            LDR     R0, =Timer0A_Addr
            MOV     R1, #1
            STR     R1, [R0]
            
            BX LR

;--------------------------------------------------------------------------------
Timer1A_Init
            LDR     R0, =Timer1A_Addr
            MOV     R1, #0
            STR     R1, [R0]

            LDR     R0, =TIMER1_CTL_R             ; Desabilita o timer 1
            MOV     R1, #0
            STR     R1, [R0]

            LDR     R0, =TIMER1_CFG_R             ; Configura o modo de 32 bits
            MOV     R1, #0x0
            STR     R1, [R0] 

            LDR     R0, =TIMER1_TAMR_R            ; Define o modo one-shot=0x01 ou periódico=0x02
            MOV     R1, #0x2
            STR     R1, [R0]

            LDR     R0, =TIMER1_TAILR_R           ; Tempo calculado para 100ms
            LDR     R1, =8000000                    
            STR     R1, [R0]

            LDR     R0, =TIMER1_TAPR_R            ; Configura o Prescaler 
            MOV     R1, #0                        ; 0 para desabilitado
            STR     R1, [R0]

            LDR     R0, =TIMER1_ICR_R             ; Garante que a primeira interrupcao sera atendida (?)
            MOV     R1, #1
            STR     R1, [R0]

            LDR     R0, =TIMER1_IMR_R             ; Utiliza a interrupcao para estouro do timer
            MOV     R1, #1
            STR     R1, [R0]
            
            MOV     R0, #4                        ; Configura a prioridade da interrupcao do timer
            LSL     R0, R0, #13
            LDR     R1, =TIMER1_A_NVIC_PRIO_R
            STR     R0, [R1]

            MOV     R0, #1                        ; Habilita a interrupcao do Timer 0A no NVIC Enable Register
            LSL     R0, R0, #TIMER1_A_NVIC_INT_NUM
            LDR     R1, =TIMER1_A_NVIC_EN_R
            STR     R0, [R1]

            LDR     R0, =TIMER1_CTL_R             ; Habilita o timer 1
            MOV     R1, #1
            STR     R1, [R0]

            BX LR


Timer1A_Handler

            LDR     R0, =TIMER1_ICR_R             ; Limpa o bit da interrupcao
            MOV     R1, #1
            STR     R1, [R0]

            LDR     R0, =Timer1A_Addr
            MOV     R1, #1
            STR     R1, [R0]
            
            BX LR

;-----------------------------------------------------------------------------------------
            ALIGN                        ;Garante que o fim da secao esta alinhada 
            END                          ;Fim do arquivo



