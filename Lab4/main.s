; main.s
; Desenvolvido para a placa EK-TM4C1294XL

; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; ~~~~~~~~~~~~~ OTHER CONSTANTS ~~~~~~~~~~~~~~F
PWM_State               EQU     0x20010000
Duty_cycle              EQU     0x20010008
Timer1A_Addr            EQU     0x20010004
ADC_Value			   	EQU     0x20010014
Stop_motor_flag		 	EQU     0x20010020


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
		IMPORT  UART_Init
		IMPORT  Timers_Init
		IMPORT	Interrupt_Init
		
        IMPORT 	Timer0A_Handler
		IMPORT  Timer1A_Handler

		IMPORT 	Uart_Receive
		IMPORT 	Uart_Send
		IMPORT 	UI_Manager
		IMPORT  Stat_Update

		IMPORT	Invert_Motor_Direction
		IMPORT  ADC_Read
		IMPORT	Disable_Motor
		IMPORT	Enable_Motor

; -------------------------------------------------------------------------------
; Funcao main()
Start  			
	BL 	PLL_Init					 ;Subrotina para alterar o clock do microcontrolador para 80MHz
	BL 	SysTick_Init				 ;Subrotina para inicializar o SysTick
	BL 	GPIO_Init                 	 ;Subrotina que inicializa os GPIO
	BL 	UART_Init                  	 ;Subrotina que inicializa o UART
	BL 	Timers_Init              	 ;Subrotina que iniciali	za o Timer0A e o Timer1A
	BL	Interrupt_Init				 ;Subrotina que inicializa os Interrupts de GPIO
	
; -------------------------------------------------------------------------------
; Laco principal
; R8 -> Byte a ser enviado
; R9 -> Byte recebido
	MOV     R8, #0x0c       ; Limpa a tela antes de começar
	BL      Uart_Send
	MOV     R8, #0x0d
	BL      Uart_Send

MainLoop

	LDR     R0, =Timer1A_Addr
	LDR     R1, [R0]
	CMP     R1, #1
	BEQ 	update_data_timer1

	BL 		UI_Manager

	BL 		ADC_Read
	LDR		R0, =ADC_Value
	STR 	R2, [R0]

	B MainLoop                   	;Volta para o laco principal


update_data_timer1
	LDR     R0, =Timer1A_Addr       ; Zera o bit do endereço do interrupt do timer 1
	MOV     R1, #0
	STR     R1, [R0]
	
	BL 		Stat_Update

	B 		skip
skip
	B MainLoop


;--------------------------------------------------------------------------------------
    ALIGN                        	;Garante que o fim da secao esta alinhada 
    END                          	;Fim do arquivo
