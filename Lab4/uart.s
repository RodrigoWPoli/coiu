; uart.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 12/02/2025

; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ==========================================
; ==========================================
; Definicoes dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
SYSCTL_RCGCUART_R    EQU    0x400FE618
SYSCTL_PRUART_R      EQU    0x400FEA18
; ===========================================
; Definicoes dos Ports
; ~~~~~~~~~~~~~~~~ PORT A ~~~~~~~~~~~~~~~~~~
GPIO_PORTA_AHB_LOCK_R 		EQU     0x40058520
GPIO_PORTA_AHB_CR_R     	EQU     0x40058524
GPIO_PORTA_AHB_AMSEL_R  	EQU	    0x40058528
GPIO_PORTA_AHB_PCTL_R   	EQU	    0x4005852C
GPIO_PORTA_AHB_DIR_R    	EQU	    0x40058400
GPIO_PORTA_AHB_AFSEL_R  	EQU	    0x40058420
GPIO_PORTA_AHB_DEN_R    	EQU     0x4005851C
GPIO_PORTA_AHB_PUR_R    	EQU     0x40058510
GPIO_PORTA_AHB_DATA_R   	EQU     0x400583FC
GPIO_PORTA 					EQU     2_000000000000001

; ===========================================
;definições dos Uarts
; ~~~~~~~~~~~~~~~~ UART0 ~~~~~~~~~~~~~~~~~~
UART0_DR_R                  EQU     0x4000C000
UART0_RSR_R                 EQU     0x4000C004
UART0_ECR_R                 EQU     0x4000C004
UART0_FR_R                  EQU     0x4000C018
UART0_ILPR_R                EQU     0x4000C020
UART0_IBRD_R                EQU     0x4000C024
UART0_FBRD_R                EQU     0x4000C028
UART0_LCRH_R                EQU     0x4000C02C
UART0_CTL_R                 EQU     0x4000C030
UART0_IFLS_R                EQU     0x4000C034
UART0_IM_R                  EQU     0x4000C038
UART0_RIS_R                 EQU     0x4000C03C
UART0_MIS_R                 EQU     0x4000C040
UART0_ICR_R                 EQU     0x4000C044
UART0_DMACTL_R              EQU     0x4000C048
UART0_9BITADDR_R            EQU     0x4000C0A4
UART0_9BITAMASK_R           EQU     0x4000C0A8
UART0_PP_R                  EQU     0x4000CFC0
UART0_CC_R                  EQU     0x4000CFC8
;~~~~~~~~~~~~ OUTRAS CONSTANTES ~~~~~~~~~~~~~
UART0_Received              EQU     0x20010010

UI_Active                   EQU     0x20010100
UI_1_Printed                EQU     0x20010104
UI_2_Printed                EQU     0x20010108
UI_3_Printed                EQU     0x2001010C
UI_4_Printed                EQU     0x20010110



; -------------------------------------------------------------------------------
; Area de Codigo - Tudo abaixo da diretiva a seguir sera armazenado na memoria de 
;                  codigo
		AREA    |.rodata|, DATA, READONLY, ALIGN=2

UI_1_Message
        DCB     "Motor parado, pressione '*' para iniciar.",0

UI_2_Message
		DCB     "Controle do motor DC: potenciômetro (tecle 'p') ou teclado (tecle 't').",0
		
UI_3_Message
		DCB     "Escolha o sentido de rotação: 'a' para anti-horário e 'h' para horário.\nEscolha a velocidade de rotação: '5' para 50%, '6' para 60%, '7' para 70%, '8' para 80%, '9' para 90% e '0' para 100% da Velocidade máxima.\n\n\tPressione 's' para voltar ao menu inicial.",0

UI_4_Message
		DCB     "Pressione 's' para voltar ao menu inicial.",0

        
      


        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funcao do arquivo for chamada em outro arquivo	
        EXPORT UART_Init  
        EXPORT Uart_Receive
        EXPORT Uart_Send         
        EXPORT UI_Manager    
        
        IMPORT SysTick_Wait1us

;--------------------------------------------------------------------------------
; Funcao UART_Init
; Ports e Pinos utilizados:
; Port A: PA0 e PA1 -> GPIOPCTL 0x11
; UART 0   
UART_Init
;================================================================================
; Inicialização do UART
; 1. Habilitar o clock no módulo UART no registrador RCGCUART e esperar até que a respectiva UART
; esteja pronta para ser acessada no registrador PRUART
            LDR     R0, =SYSCTL_RCGCUART_R  		                ;Carrega o endereco do registrador RCGCGPIO
			MOV		R1, #1                                          ;Seta o bit da UART 0
            STR     R1, [R0]					                	;Move para a memoria o bit da UART 0 no endereco do RCGCGPIO
            
            LDR     R0, =SYSCTL_PRUART_R			                ;Carrega o endereco do PRUART para esperar a UART ficar pronta 

EsperaUART  
            LDR     R1, [R0]						                ;Le da memoria o conteudo do endereco do registrador
            MOV     R2, #1                                          ;Seta os bits correspondentes da uart
            TST     R1, R2						                    ;ANDS de R1 com R2
            BEQ     EsperaUART					                    ;Se o flag Z=1, volta para o laco. Senao continua executando

; 2. Desabilitar o UART para fazer as alterações necessárias
            LDR     R0, =UART0_CTL_R		                        ;Carrega o endereco do CTL para a UART 0
            MOV     R1, #0                                          ;Coloca 0 no registrador para desabilitar a UART
            STR     R1, [R0]                                        ;Guarda no registrador da memoria

; 3. Configurar o Baud Rate
            LDR     R0, =UART0_IBRD_R		                        ;Carrega o endereco do IBRD para a UART 0
            MOV     R1, #260                                        ;IBRD = int(80,000,000 / (16 * 19,200)) = int(260.4166)
            STR     R1, [R0]                                        ;Guarda no registrador da memoria

            LDR     R0, =UART0_FBRD_R		                        ;Carrega o endereco do FBRD para a UART 0
            MOV     R1, #27                                         ;FBRD = round(0.4166 * 64) = 27
            STR     R1, [R0]                                        ;Guarda no registrador da memoria

; 4. Configurar o LCRH para 8 bits, 1 stop bit, sem paridade
            LDR     R0, =UART0_LCRH_R		                        ;Carrega o endereco do LCRH para a UART 0
            MOV     R1, #2_01110000                                ;Tamanho de palavra = 8 bits, 1 stop bit, sem paridade
            STR     R1, [R0]                                        ;Guarda no registrador da memoria

; 5. Garantir que a fonte do clock seja o system clock
            LDR     R0, =UART0_CC_R		                            ;Carrega o endereco do CC para a UART 0
            MOV     R1, #0                                          ;Coloca 0 no registrador para selecionar o system clock
            STR     R1, [R0]                                        ;Guarda no registrador da memoria

; 6. Habilitar as flags RXE, TXE e UARTEN no registrador CTL
            LDR     R0, =UART0_CTL_R		                        ;Carrega o endereco do CTL para a UART 0
            MOV     R1, #0x0301                                     ;Habilita RXE, TXE e UARTEN
            STR     R1, [R0]                                        ;Guarda no registrador da memoria
;================================================================================
; Inicialização do GPIO
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; apos isso verificar no PRGPIO se a porta esta pronta para uso.
            LDR     R0, =SYSCTL_RCGCGPIO_R  		                ;Carrega o endereco do registrador RCGCGPIO
            LDR    R1, [R0]					                	;Le da memoria o conteudo do endereco do registrador
			ORR    R1, R1, #GPIO_PORTA                             ;Seta o bit da porta A
            STR     R1, [R0]					                	;Move para a memoria os bits das portas no endereco do RCGCGPIO
 
            LDR     R0, =SYSCTL_PRGPIO_R			                ;Carrega o endereco do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO  
            LDR     R1, [R0]						                ;Le da memoria o conteudo do endereco do registrador
            MOV     R2, #GPIO_PORTA                                 ;Seta os bits correspondentes das portas para fazer a comparacao
            TST     R1, R2						                    ;ANDS de R1 com R2
            BEQ     EsperaGPIO		    			                ;Se o flag Z=1, volta para o laco. Senao continua executando
 
; 2. Limpar o AMSEL para desabilitar a analogica
            MOV     R1, #0x00						                ;Colocar 0 no registrador para desabilitar a funcao analogica
            LDR     R0, =GPIO_PORTA_AHB_AMSEL_R                     ;Carrega o R0 com o endereco do AMSEL para a porta A
            STR     R1, [R0]						                ;Guarda no registrador AMSEL da porta generica da memoria
 
; 3. Setar função alternativa nos pinos RX e TX no PCTL
            MOV     R1, #0x11					                    ;Colocar 0 no registrador para selecionar o modo GPIO
            LDR     R0, =GPIO_PORTA_AHB_PCTL_R		                ;Carrega o R0 com o endereco do PCTL para a porta generica
            STR     R1, [R0]						                ;Guarda no registrador PCTL da porta generica da memoria

; 5. Setar os bits AFSEL para 1 para selecionar função alternativa 
;    Com funcao alternativa
            MOV     R1, #2_00000011						                ;Colocar o valor 1 para  setar funcao alternativa
            LDR     R0, =GPIO_PORTA_AHB_AFSEL_R                     ;Carrega o endereco do AFSEL da porta generica
            STR     R1, [R0]                                        ;Escreve na porta

; 6. Setar os bits de DEN para habilitar I/O digital
            LDR 	R0, =GPIO_PORTA_AHB_DEN_R			            ;Carrega o endereco do DEN para a porta J
			MOV 	R1, #2_00000011						            ;Ativa a PA0 e PA1 para ser digital
            STR		R1, [R0]							            ;Seta o bit digital para PJ0 e PJ1

            LDR    R0, =UI_Active   ; Define a UI 1 como ativa
            MOV    R1, #1
            STR    R1, [R0]

            MOV    R1, #0
            LDR    R0, =UI_1_Printed  ; Inicializa variáveis das UIs
            STRB   R1, [R0]
            LDR    R0, =UI_2_Printed
            STRB   R1, [R0]
            LDR    R0, =UI_3_Printed
            STRB   R1, [R0]
            LDR    R0, =UI_4_Printed
            STRB   R1, [R0]


            LDR    R0, =UART0_Received ; Inicializa variáveis das UIs
            MOV    R1, #0
            STRB   R1, [R0]

;retorno            
			BX      LR


;--------------------------------------------------------------------------------------------
; Função Uart_Receive
; Recebe um byte da UART0
; Verifica caso exista dados recebidos checando o flag RXFE do registrador UARTFR
; 1 - Não há dados para ler; 0 - Há dados para ler
; Parâmetros de entrada: nenhum
; Parâmetros de saída: R9 - byte recebido 
Uart_Receive
            PUSH    {LR}

            LDR    R0, =UART0_FR_R
            MOV    R1, #0x10
            LDR    R2, [R0]
            TST    R2, R1
            BNE    empty

            LDR    R0, =UART0_DR_R
            LDRB   R9, [R0]
            LDR    R0, =UART0_Received
            STRB   R9, [R0]

empty


            POP     {LR}						
            BX      LR
;--------------------------------------------------------------------------------------------
; Função Uart_Send
; Envia um byte pela UART0
; Verifica caso a UART0 esteja pronta para enviar dados checando o flag TXFF do registrador UARTFR
; 1 - Não está pronta para enviar; 0 - Está pronta para enviar
; Parâmetros de entrada: R8 - byte a ser enviado
; Parâmetros de saída: nenhum
Uart_Send
            ; Save LR and registers that will be used
            PUSH    {R0-R2, LR}

            LDR    R0, =UART0_FR_R
            MOV    R1, #0x20
            LDR    R2, [R0]
            TST    R2, R1
            BNE    full

            LDR    R0, =UART0_DR_R
            STRB   R8, [R0]
full
            LDR     R0, =UART0_FR_R
            LDR     R1, [R0]          ; Load the UARTFR register
            TST     R1, #2_00100000   ; Check the TXFF bit
            BNE     full             ; If the TXFF bit is set, the FIFO is full, so we need to wait

            ; Restore LR and registers
            POP     {R0-R2, LR}
            BX      LR
;---------------------------------------------------------------------------------------------

; função UI_1
;   Envia a mensagem "Motor parado, pressione '*' para iniciar." e aguarda a entrada do usuário

UI_1

            LDR     R0, =UI_1_Printed
            LDRB    R1, [R0]
            CMP     R1, #1
            BEQ     UI_1_Input
            
            LDR     R2, =UI_1_Message   ; Get pointer to our string
UI_1_Loop
            LDRB    R8, [R2], #1        ; Load a byte and post-increment the pointer
            CMP     R8, #0              ; Check for the null terminator
            BEQ     UI_1_Print_End
            BL      Uart_Send           ; Send the character
            B       UI_1_Loop

UI_1_Print_End
            LDR     R0, =UI_1_Printed
            MOV     R1, #1
            STRB    R1, [R0]

UI_1_Input
			BL 		Uart_Receive
            LDR     R0, =UART0_Received
            LDRB    R1, [R0]
            CMP     R1, #0x2A       ; Se '*' foi pressionado
            BNE     UI_1_end

            MOV     R8, #0x0c       ; Limpa a tela e ativa a próxima UI
            BL      Uart_Send
            MOV     R8, #0x0d
            BL      Uart_Send

            MOV    R1, #0
            LDR    R0, =UI_1_Printed  ; Inicializa variáveis das UIs
            STRB   R1, [R0]
            
            LDR     R0, =UI_Active  ; Ativa a UI 2
            MOV     R1, #2
            STR     R1, [R0]
UI_1_end
            POP    {LR}
            BX      LR

; função UI_2
UI_2

            LDR     R0, =UI_2_Printed
            LDRB    R1, [R0]
            CMP     R1, #1
            BEQ     UI_2_Input
            
            LDR     R2, =UI_2_Message   ; Get pointer to our string
UI_2_Loop
            LDRB    R8, [R2], #1        ; Load a byte and post-increment the pointer
            CMP     R8, #0              ; Check for the null terminator
            BEQ     UI_2_Print_End
            BL      Uart_Send           ; Send the character
            B       UI_2_Loop

UI_2_Print_End
            LDR     R0, =UI_2_Printed
            MOV     R1, #1
            STRB    R1, [R0]

UI_2_Input
			BL 		Uart_Receive
            LDR     R0, =UART0_Received
            LDRB    R1, [R0]
            CMP     R1, #0x74       ; Se 't' foi pressionado
            BEQ     UI_2_T_set
            CMP     R1, #0x70       ; Se 'p' foi pressionado
            BEQ     UI_2_P_set
            B       UI_2_end

UI_2_T_set
            MOV     R8, #0x0c       ; Limpa a tela e ativa a próxima UI
            BL      Uart_Send
            MOV     R8, #0x0d
            BL      Uart_Send

            MOV    R1, #0
            LDR    R0, =UI_2_Printed  ; Reseta o estado da UI 2
            STRB   R1, [R0]
            
            LDR     R0, =UI_Active  ; Ativa a UI 3T
            MOV     R1, #3
            STR     R1, [R0]
            B       UI_2_end

UI_2_P_set
            MOV     R8, #0x0c       ; Limpa a tela e ativa a próxima UI
            BL      Uart_Send
            MOV     R8, #0x0d
            BL      Uart_Send

            MOV    R1, #0
            LDR    R0, =UI_2_Printed  ; Reseta o estado da UI 2
            STRB   R1, [R0]
            
            LDR     R0, =UI_Active  ; Ativa a UI 3P
            MOV     R1, #4
            STR     R1, [R0]

UI_2_end
            POP    {LR}
            BX      LR


; Conjunto de funções para UIs
; função UI_Manager
;  Gerencia a troca de UIs
UI_Manager
            PUSH    {LR}
            LDR     R0, =UI_Active
            LDR     R1, [R0]
            CMP     R1, #1
            BEQ     UI_1
            CMP     R1, #2
            BEQ     UI_2
            CMP     R1, #3
            BEQ     UI_3
            CMP     R1, #4
            BEQ     UI_4


; função UI_3 (teclado)
UI_3

            LDR     R0, =UI_3_Printed
            LDRB    R1, [R0]
            CMP     R1, #1
            BEQ     UI_3_Input
            
            LDR     R2, =UI_3_Message   ; Get pointer to our string
UI_3_Loop
            LDRB    R8, [R2], #1        ; Load a byte and post-increment the pointer
            CMP     R8, #0              ; Check for the null terminator
            BEQ     UI_3_Print_End
            BL      Uart_Send           ; Send the character
            B       UI_3_Loop

UI_3_Print_End
            LDR     R0, =UI_3_Printed
            MOV     R1, #1
            STRB    R1, [R0]

UI_3_Input
			BL 		Uart_Receive
            LDR     R0, =UART0_Received
            LDRB    R1, [R0]
            CMP     R1, #0x68       ; Se 'h' foi pressionado
            BEQ     UI_3_cw
            CMP     R1, #0x61       ; Se 'a' foi pressionado
            BEQ     UI_3_ccw
            CMP     R1, #0x73       ; Se 's' foi pressionado
            BEQ     UI_3_stop
            ; 0-9 DEVE VIR POR ÚLTIMO
            CMP     R1, #0x30       ; Se um dígito entre 0 e 9 foi pressionado
            BLT     UI_3_end
            CMP     R1, #0x39
            BGT     UI_3_end
            B       UI_3_speed

UI_3_cw
UI_3_ccw
UI_3_speed
            
            
UI_3_stop
            MOV     R8, #0x0c       ; Limpa a tela e ativa a próxima UI
            BL      Uart_Send
            MOV     R8, #0x0d
            BL      Uart_Send

            MOV    R1, #0
            LDR    R0, =UI_3_Printed  ; Reseta o estado da UI 3
            STRB   R1, [R0]

            LDR     R0, =UI_Active  ; Ativa a UI 1
            MOV     R1, #1
            STR     R1, [R0]

UI_3_end
            POP    {LR}
            BX      LR

; função UI_4 (potenciometro)
UI_4

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