
; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ==========================================
;~~~~~~~~~~~~ OUTRAS CONSTANTES ~~~~~~~~~~~~~
Duty_cycle                  EQU     0x20010008
MOTOR_DIRECTION			    EQU     0x2001000C
UART0_Received              EQU     0x20010010
ADC_Value			   	    EQU     0x20010014
Motor_Speed                 EQU     0x20010018

UI_Active                   EQU     0x20010100
UI_4_Printed                EQU     0x20010110



; -------------------------------------------------------------------------------
; Area de Codigo - Tudo abaixo da diretiva a seguir sera armazenado na memoria de 
;                  codigo
		AREA    |.rodata|, DATA, READONLY, ALIGN=2

UI_4_Message
		DCB     "Pressione 's' para voltar ao menu inicial.",0

UI_Speed_Message
        DCB     "Velocidade: ",0

UI_Dir_Message
        DCB     "Sentido de rotação: ",0

; -------------------------------------------------------------------------------

        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funcao do arquivo for chamada em outro arquivo	
        EXPORT UI_4  
        EXPORT Stat_Update

        IMPORT Uart_Send
        IMPORT Uart_Receive
        IMPORT Enable_Motor

; -------------------------------------------------------------------------------
; Função Stat_Update
Stat_Update
            PUSH    {LR}

            LDR     R0, =UI_Active
            LDR     R1, [R0]
            CMP     R1, #3
            BEQ     Print_Stat
            CMP     R1, #4
            BEQ     Print_Stat
            B       Stat_Update_End

Print_Stat
            MOV     R8, #0xa      ; New line
            BL      Uart_Send
            MOV     R8, #0xd      ; Carriage return
            BL      Uart_Send
            
            LDR     R2, =UI_Speed_Message
UI_3_Input_speed_msg
			LDRB    R8, [R2], #1        ; Load a byte and post-increment the pointer
			BL 		Uart_Send
			CMP 	R8, #0
			BNE		UI_3_Input_speed_msg
			
            BL      Uart_Send
            LDR     R0, =Motor_Speed   ; Load the speed (0-100%)
            LDR     R1, [R0]
            AND     R2, R1, #0xF0
            LSR     R2, R2, #4
            ADD     R8, R2, #0x30
            BL      Uart_Send
            AND     R2, R1, #0x0F
            ADD     R8, R2, #0x30
            BL      Uart_Send

            MOV     R8, #0xa      ; New line
            BL      Uart_Send
            BL      Uart_Send
            MOV     R8, #0xd      ; Carriage return
            BL      Uart_Send

            LDR     R2, =UI_Dir_Message
UI_3_Input_dir_msg
			LDRB    R8, [R2], #1        ; Load a byte and post-increment the pointer
			BL 		Uart_Send
			CMP 	R8, #0
			BNE		UI_3_Input_dir_msg
            BL      Uart_Send

            LDR     R0, =MOTOR_DIRECTION
            LDR     R1, [R0]
            CMP     R1, #0
            ITE     EQ
             MOVEQ   R8, #0x61     ; 'h' for clockwise
             MOVNE   R8, #0x68     ; 'a' for counter-clockwise
            BL      Uart_Send

            ; Reset cursor position (two lines up)
            MOV     R8, #0x1B
            BL      Uart_Send
            MOV     R8, #0x5B
            BL      Uart_Send
            MOV     R8, #0x33
            BL      Uart_Send
            MOV     R8, #0x41
            BL      Uart_Send
            ; Carriage return
            MOV     R8, #0x0d
            BL      Uart_Send

Stat_Update_End
            POP    {LR}
            BX      LR


; função UI_4 (potenciometro)
UI_4
            BL      Enable_Motor
            LDR     R0, =UI_4_Printed
            LDRB    R1, [R0]
            CMP     R1, #1
            BEQ     UI_4_Input
            
            LDR     R2, =UI_4_Message   ; Get pointer to our string
UI_4_Loop
            LDRB    R8, [R2], #1        ; Load a byte and post-increment the pointer
            CMP     R8, #0              ; Check for the null terminator
            BEQ     UI_4_Print_End
            BL      Uart_Send           ; Send the character
            B       UI_4_Loop

UI_4_Print_End
            LDR     R0, =UI_4_Printed
            MOV     R1, #1
            STRB    R1, [R0]

UI_4_Input
			BL 		Uart_Receive
            LDR     R0, =UART0_Received
            LDRB    R1, [R0]
            CMP     R1, #0x73       ; Se 's' foi pressionado
            BEQ     UI_4_stop
            B       UI_4_end

UI_4_stop
            MOV     R8, #0x0c       ; Limpa a tela e ativa a próxima UI
            BL      Uart_Send
            MOV     R8, #0x0d
            BL      Uart_Send

            MOV    R1, #0
            LDR    R0, =UI_4_Printed  ; Reseta o estado da UI 4
            STRB   R1, [R0]

            LDR     R0, =UI_Active  ; Ativa a UI 1
            MOV     R1, #1
            STR     R1, [R0]

UI_4_end
            POP    {LR}
            BX      LR


; -------------------------------------------------------------------------------
            ALIGN                           			; garante que o fim da secaoo esta alinhada 
            END                             			; fim do arquivo