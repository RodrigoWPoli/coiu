; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araújo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Última atualização: 11/11/2024

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
; ========================

; ========================
; Definições dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================

; ================== DEFINIÇÕES DOS PORTS ===================

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
GPIO_PORTA 					EQU    2_000000000000001

; ~~~~~~~~~~~~~~~~ PORT B ~~~~~~~~~~~~~~~~~~
GPIO_PORTB_AHB_DATA_R   	EQU     0x400593FC
GPIO_PORTB_AHB_DIR_R    	EQU     0x40059400
GPIO_PORTB_AHB_AFSEL_R  	EQU     0x40059420
GPIO_PORTB_AHB_PUR_R    	EQU     0x40059510
GPIO_PORTB_AHB_DEN_R    	EQU     0x4005951C
GPIO_PORTB_AHB_LOCK_R   	EQU     0x40059520
GPIO_PORTB_AHB_CR_R     	EQU     0x40059524
GPIO_PORTB_AHB_AMSEL_R  	EQU     0x40059528
GPIO_PORTB_AHB_PCTL_R   	EQU     0x4005952C
GPIO_PORTB 					EQU    2_000000000000010

; ~~~~~~~~~~~~~~~~ PORT C ~~~~~~~~~~~~~~~~~~
GPIO_PORTC_AHB_DATA_R   	EQU     0x4005A3FC
GPIO_PORTC_AHB_DIR_R    	EQU     0x4005A400
GPIO_PORTC_AHB_AFSEL_R  	EQU     0x4005A420
GPIO_PORTC_AHB_PUR_R    	EQU     0x4005A510
GPIO_PORTC_AHB_DEN_R    	EQU     0x4005A51C
GPIO_PORTC_AHB_LOCK_R   	EQU     0x4005A520
GPIO_PORTC_AHB_CR_R     	EQU     0x4005A524
GPIO_PORTC_AHB_AMSEL_R  	EQU     0x4005A528
GPIO_PORTC_AHB_PCTL_R   	EQU     0x4005A52C
GPIO_PORTC 					EQU    2_000000000000100

; ~~~~~~~~~~~~~~~~ PORT D ~~~~~~~~~~~~~~~~~~
GPIO_PORTD_AHB_DATA_R   	EQU     0x4005B3FC
GPIO_PORTD_AHB_DIR_R    	EQU     0x4005B400
GPIO_PORTD_AHB_AFSEL_R  	EQU     0x4005B420
GPIO_PORTD_AHB_PUR_R    	EQU     0x4005B510
GPIO_PORTD_AHB_DEN_R    	EQU     0x4005B51C
GPIO_PORTD_AHB_LOCK_R   	EQU     0x4005B520
GPIO_PORTD_AHB_CR_R     	EQU     0x4005B524
GPIO_PORTD_AHB_AMSEL_R  	EQU     0x4005B528
GPIO_PORTD_AHB_PCTL_R   	EQU     0x4005B52C
GPIO_PORTD 					EQU    2_000000000001000

; ~~~~~~~~~~~~~~~~ PORT E ~~~~~~~~~~~~~~~~~~
GPIO_PORTE_AHB_DATA_R   	EQU     0x4005C3FC
GPIO_PORTE_AHB_DIR_R    	EQU     0x4005C400
GPIO_PORTE_AHB_AFSEL_R  	EQU     0x4005C420
GPIO_PORTE_AHB_PUR_R    	EQU     0x4005C510
GPIO_PORTE_AHB_DEN_R    	EQU     0x4005C51C
GPIO_PORTE_AHB_LOCK_R   	EQU     0x4005C520
GPIO_PORTE_AHB_CR_R     	EQU     0x4005C524
GPIO_PORTE_AHB_AMSEL_R  	EQU     0x4005C528
GPIO_PORTE_AHB_PCTL_R   	EQU     0x4005C52C
GPIO_PORTE 					EQU    2_000000000010000

; ~~~~~~~~~~~~~~~~ PORT F ~~~~~~~~~~~~~~~~~~
GPIO_PORTF_AHB_DATA_R   	EQU     0x4005D3FC
GPIO_PORTF_AHB_DIR_R    	EQU     0x4005D400
GPIO_PORTF_AHB_AFSEL_R  	EQU     0x4005D420
GPIO_PORTF_AHB_PUR_R    	EQU     0x4005D510
GPIO_PORTF_AHB_DEN_R    	EQU     0x4005D51C
GPIO_PORTF_AHB_LOCK_R   	EQU     0x4005D520
GPIO_PORTF_AHB_CR_R     	EQU     0x4005D524
GPIO_PORTF_AHB_AMSEL_R  	EQU     0x4005D528
GPIO_PORTF_AHB_PCTL_R   	EQU     0x4005D52C
GPIO_PORTF 					EQU    2_000000000100000

; ~~~~~~~~~~~~~~~~ PORT G ~~~~~~~~~~~~~~~~~~
GPIO_PORTG_AHB_DATA_R   	EQU     0x4005E3FC
GPIO_PORTG_AHB_DIR_R    	EQU     0x4005E400
GPIO_PORTG_AHB_AFSEL_R  	EQU     0x4005E420
GPIO_PORTG_AHB_PUR_R    	EQU     0x4005E510
GPIO_PORTG_AHB_DEN_R    	EQU     0x4005E51C
GPIO_PORTG_AHB_LOCK_R   	EQU     0x4005E520
GPIO_PORTG_AHB_CR_R     	EQU     0x4005E524
GPIO_PORTG_AHB_AMSEL_R  	EQU     0x4005E528
GPIO_PORTG_AHB_PCTL_R   	EQU     0x4005E52C
GPIO_PORTG 					EQU    2_000000001000000

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
GPIO_PORTH 					EQU    2_000000010000000

; ~~~~~~~~~~~~~~~~ PORT J ~~~~~~~~~~~~~~~~~~
GPIO_PORTJ_AHB_LOCK_R    	EQU    0x40060520
GPIO_PORTJ_AHB_CR_R      	EQU    0x40060524
GPIO_PORTJ_AHB_AMSEL_R   	EQU    0x40060528
GPIO_PORTJ_AHB_PCTL_R    	EQU    0x4006052C
GPIO_PORTJ_AHB_DIR_R     	EQU    0x40060400
GPIO_PORTJ_AHB_AFSEL_R   	EQU    0x40060420
GPIO_PORTJ_AHB_DEN_R        EQU    0x4006051C
GPIO_PORTJ_AHB_IM_R         EQU    0x40060410
GPIO_PORTJ_AHB_IS_R         EQU    0x40060404
GPIO_PORTJ_AHB_IBE_R        EQU    0x40060408
GPIO_PORTJ_AHB_IEV_R        EQU    0x4006040C
GPIO_PORTJ_AHB_ICR_R        EQU    0x4006041C
GPIO_PORTJ_AHB_PUR_R     	EQU    0x40060510	
GPIO_PORTJ_AHB_DATA_R    	EQU    0x400603FC
GPIO_PORTJ               	EQU   2_000000100000000

; ~~~~~~~~~~~~~~~~ PORT K ~~~~~~~~~~~~~~~~~~
GPIO_PORTK_DATA_R           EQU     0x400613FC
GPIO_PORTK_DIR_R            EQU     0x40061400
GPIO_PORTK_AFSEL_R          EQU     0x40061420
GPIO_PORTK_PUR_R            EQU     0x40061510
GPIO_PORTK_DEN_R            EQU     0x4006151C
GPIO_PORTK_LOCK_R           EQU     0x40061520
GPIO_PORTK_CR_R             EQU     0x40061524
GPIO_PORTK_AMSEL_R          EQU     0x40061528
GPIO_PORTK_PCTL_R           EQU     0x4006152C
GPIO_PORTK               	EQU    2_000001000000000

; ~~~~~~~~~~~~~~~~ PORT L ~~~~~~~~~~~~~~~~~~
GPIO_PORTL_DATA_R           EQU     0x400623FC
GPIO_PORTL_DIR_R            EQU     0x40062400
GPIO_PORTL_AFSEL_R          EQU     0x40062420
GPIO_PORTL_PUR_R            EQU     0x40062510
GPIO_PORTL_DEN_R            EQU     0x4006251C
GPIO_PORTL_LOCK_R           EQU     0x40062520
GPIO_PORTL_CR_R             EQU     0x40062524
GPIO_PORTL_AMSEL_R          EQU     0x40062528
GPIO_PORTL_PCTL_R           EQU     0x4006252C
GPIO_PORTL               	EQU    2_000010000000000

; ~~~~~~~~~~~~~~~~ PORT M ~~~~~~~~~~~~~~~~~~
GPIO_PORTM_DATA_R           EQU     0x400633FC
GPIO_PORTM_DIR_R            EQU     0x40063400
GPIO_PORTM_AFSEL_R          EQU     0x40063420
GPIO_PORTM_PUR_R            EQU     0x40063510
GPIO_PORTM_DEN_R            EQU     0x4006351C
GPIO_PORTM_LOCK_R           EQU     0x40063520
GPIO_PORTM_CR_R             EQU     0x40063524
GPIO_PORTM_AMSEL_R          EQU     0x40063528
GPIO_PORTM_PCTL_R           EQU     0x4006352C
GPIO_PORTM               	EQU    2_000100000000000

; ~~~~~~~~~~~~~~~~ PORT N ~~~~~~~~~~~~~~~~~~
GPIO_PORTN_DATA_R           EQU     0x400643FC
GPIO_PORTN_DIR_R            EQU     0x40064400
GPIO_PORTN_AFSEL_R          EQU     0x40064420
GPIO_PORTN_PUR_R            EQU     0x40064510
GPIO_PORTN_DEN_R            EQU     0x4006451C
GPIO_PORTN_LOCK_R           EQU     0x40064520
GPIO_PORTN_CR_R             EQU     0x40064524
GPIO_PORTN_AMSEL_R          EQU     0x40064528
GPIO_PORTN_PCTL_R           EQU     0x4006452C
GPIO_PORTN               	EQU    2_001000000000000

; ~~~~~~~~~~~~~~~~ PORT P ~~~~~~~~~~~~~~~~~~
GPIO_PORTP_DATA_R           EQU     0x400653FC
GPIO_PORTP_DIR_R            EQU     0x40065400
GPIO_PORTP_AFSEL_R          EQU     0x40065420
GPIO_PORTP_PUR_R            EQU     0x40065510
GPIO_PORTP_DEN_R            EQU     0x4006551C
GPIO_PORTP_LOCK_R           EQU     0x40065520
GPIO_PORTP_CR_R             EQU     0x40065524
GPIO_PORTP_AMSEL_R          EQU     0x40065528
GPIO_PORTP_PCTL_R           EQU     0x4006552C
GPIO_PORTP               	EQU    2_010000000000000

; ~~~~~~~~~~~~~~~~ PORT Q ~~~~~~~~~~~~~~~~~~
GPIO_PORTQ_DATA_R           EQU     0x400663FC
GPIO_PORTQ_DIR_R            EQU     0x40066400
GPIO_PORTQ_AFSEL_R          EQU     0x40066420
GPIO_PORTQ_PUR_R            EQU     0x40066510
GPIO_PORTQ_DEN_R            EQU     0x4006651C
GPIO_PORTQ_LOCK_R           EQU     0x40066520
GPIO_PORTQ_CR_R             EQU     0x40066524
GPIO_PORTQ_AMSEL_R          EQU     0x40066528
GPIO_PORTQ_PCTL_R           EQU     0x4006652C
GPIO_PORTQ               	EQU    2_100000000000000


; ~~~~~~~~~~~~~~~~ Constantes ~~~~~~~~~~~~~~~~~~
DELAY_MS                    EQU		2

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init             ; Permite chamar GPIO_Init de outro arquivo
        EXPORT Led_Output            ; Permite chamar Led_Output de outro arquivo
        EXPORT Display_Output        ; Permite chamar Display_Output de outro arquivo
		EXPORT Switch_Input          ; Permite chamar Switch_Input de outro arquivo

        IMPORT SysTick_Wait1ms 
        IMPORT DefineLedA
        IMPORT DefineLedB
        IMPORT DefineLedC
        IMPORT DefineLedD
        IMPORT DefineLedE
        IMPORT DefineLedF
        IMPORT DefineLedG
									
;--------------------------------------------------------------------------------
; Função GPIO_Init
; Parâmetro de entrada: Não tem
; Parâmetro de sa�da: Não tem
GPIO_Init
;=====================
; ****************************************
; Escrever função de inicialização dos GPIO
; Inicializar as portas J e N
; ****************************************
; Ativar os clocks e verificar se estão ativos - RCGCPIO e PRGPIO

			LDR			R0, =SYSCTL_RCGCGPIO_R            ; Carrega endereço do registrador RCGCPIO
			MOV 		R1, #GPIO_PORTA                   ; Seta bits da porta A
			ORR 		R1, #GPIO_PORTB					  ; Seta bits da porta B
			ORR 		R1, #GPIO_PORTJ					  ; Seta bits da porta J  
			ORR 		R1, #GPIO_PORTP					  ; Seta bits da porta P
			ORR 		R1, #GPIO_PORTQ					  ; Seta bits da porta Q 
			STR 		R1, [R0]						  ; Seta na memória do RCGCPIO os bits das portas
			
			LDR 		R0, =SYSCTL_PRGPIO_R              ; Carrega endereço do registrador PRGPIO
EsperaGPIO 	LDR 		R1, [R0]						  ; Lê da memória o conteúdo do endereço do registrador
			MOV 		R2, #GPIO_PORTA 				  ; Seta bits da porta A
            ORR 		R2, #GPIO_PORTB					  ; Seta bits da porta B
            ORR 		R2, #GPIO_PORTJ					  ; Seta bits da porta J
            ORR 		R2, #GPIO_PORTP					  ; Seta bits da porta P
			ORR 		R2, #GPIO_PORTQ					  ; Seta bits da porta Q
			TST 		R1, R2 							  ; ANDS de R1 com R2
			BEQ 		EsperaGPIO                        ; Quando for diferente de zero, os bits do PRGPIO foram setados
			
; Limpar o AMSEL
			MOV 		R1, #0x00						  ; Coloca 0 no registrador para desabilitar função analógica
            LDR         R0, =GPIO_PORTA_AHB_AMSEL_R       ; Coloca o endereço do AMSEL da porta A
            STR         R1, [R0]                          ; Zera os bits do AMSEL da porta A
            LDR         R0, =GPIO_PORTB_AHB_AMSEL_R       ; Coloca o endereço do AMSEL da porta B
            STR         R1, [R0]                          ; Zera os bits do AMSEL da porta B  
			LDR 		R0, =GPIO_PORTJ_AHB_AMSEL_R		  ; Coloca o endereço do AMSEL para o port J
			STR 		R1, [R0]						  ; Zera os bits do AMSEL da porta J
            LDR         R0, =GPIO_PORTP_AMSEL_R       	  ; Coloca o endereço do AMSEL da porta P
            STR         R1, [R0]                          ; Zera os bits do AMSEL da porta P
            LDR         R0, =GPIO_PORTQ_AMSEL_R           ; Coloca o endereço do AMSEL da porta Q
            STR         R1, [R0]                          ; Zera os bits do AMSEL da porta Q
                      

	
; Limpar PCTL
			MOV 		R1, #0x00 						  ; Coloca 0 no registrador para selecionar o modo GPIO
            LDR         R0, =GPIO_PORTA_AHB_PCTL_R        ; Coloca o endereço do PCTL da porta A
            STR         R1, [R0]                          ; Zera os bits do PCTL da porta A
            LDR         R0, =GPIO_PORTB_AHB_PCTL_R        ; Coloca o endereço do PCTL da porta B
            STR         R1, [R0]                          ; Zera os bits do PCTL da porta B
			LDR 		R0, =GPIO_PORTJ_AHB_PCTL_R		  ; Coloca o endereço do PCTL da porta J
			STR 		R1, [R0] 						  ; Zera os bits do PCTL da porta J
            LDR         R0, =GPIO_PORTP_PCTL_R            ; Coloca o endereço do PCTL da porta P
            STR         R1, [R0]                          ; Zera os bits do PCTL da porta P
            LDR         R0, =GPIO_PORTQ_PCTL_R            ; Coloca o endereço do PCTL da porta Q
            STR         R1, [R0]                          ; Zera os bits do PCTL da porta Q

; -========== Switch ==============-
			LDR 		R0, =GPIO_PORTJ_AHB_DIR_R		  ; Coloca o endereço do DIR para o port J (push button)
			MOV 		R1, #0x00						  ; Todos os bits são entrada, só usaremos o PJ0 e PJ1
			STR 		R1, [R0]						  ; Coloca todos os bits como entrada

; -============ Led e Display ================-
            LDR         R0, =GPIO_PORTA_AHB_DIR_R		  ; Coloca o endereço do DIR para o port A (Leds e Displays)
            MOV         R1, #2_11110000					  ; PA7-PA4 são saída
            STR         R1, [R0]						  ; Seta o valor na memória
            LDR         R0, =GPIO_PORTQ_DIR_R		      ; Coloca o endereço do DIR para o port Q (Leds e Displays)
			MOV         R1, #2_00001111					  ; PQ3-PQ0 são saída
            STR         R1, [R0]						  ; Seta o valor na memória

; -========== Transistores ==============-
			
			LDR         R0, =GPIO_PORTB_AHB_DIR_R		  ; Coloca o endereço do DIR para o port B (Transistores display)
            MOV         R1, #2_00110000					  ; PB5-PB4 são saída
            STR         R1, [R0]						  ; Seta o valor na memória
            LDR         R0, =GPIO_PORTP_DIR_R		      ; Coloca o endereço do DIR para o port P (Transistor led)
			MOV         R1, #2_00100000					  ; PP5 é saída
            STR         R1, [R0]						  ; Seta o valor na memória

; Limpar o AFSEl para n�o ter função alternativa
			MOV     R1, #0x00							  ; Colocar o valor 0 para não setar função alternativa
            LDR     R0, =GPIO_PORTA_AHB_AFSEL_R           ; Carrega o endereço do AFSEL da porta A
            STR     R1, [R0]                              ; Limpa os bits
            LDR     R0, =GPIO_PORTB_AHB_AFSEL_R           ; Carrega o endereço do AFSEL da porta B
            STR     R1, [R0]                              ; Limpa os bits
            LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R    	      ; Carrega o endereço do AFSEL da porta J
            STR     R1, [R0]                        	  ; Limpa os bits
            LDR     R0, =GPIO_PORTP_AFSEL_R               ; Carrega o endereço do AFSEL da porta P
            STR     R1, [R0]                              ; Limpa os bits
            LDR     R0, =GPIO_PORTQ_AFSEL_R               ; Carrega o endereço do AFSEL da porta Q
            STR     R1, [R0]                              ; Limpa os bits

; Setar o DEN para habilitar os pinos digitais
            LDR 	R0, =GPIO_PORTA_AHB_DEN_R			  ; Carrega o endereço do DEN para a porta A
            MOV 	R1, #2_11110000				     	  ; Ativa os bits digitais para PA7-PA4
            STR		R1, [R0]							  ; Seta o bit digital para PA7-PA4
            LDR 	R0, =GPIO_PORTB_AHB_DEN_R			  ; Carrega o endereço do DEN para a porta B
            MOV 	R1, #2_00110000						  ; Ativa os bits digitais para PB7-PB4
            STR		R1, [R0]							  ; Seta o bit digital para PB7-PB4
			LDR 	R0, =GPIO_PORTJ_AHB_DEN_R			  ; Carrega o endereço do DEN para a porta J
			MOV 	R1, #00000011						  ; Ativa a PJ0 e PJ1 para ser digital
			STR		R1, [R0]							  ; Seta o bit digital para PJ0
            LDR 	R0, =GPIO_PORTP_DEN_R			      ; Carrega o endereço do DEN para a porta P
            MOV 	R1, #2_00100000						  ; Ativa os bits digitais para PP5
            STR		R1, [R0]							  ; Seta o(s) bit(s)
            LDR 	R0, =GPIO_PORTQ_DEN_R			      ; Carrega o endereço do DEN para a porta Q
            MOV 	R1, #2_00001111						  ; Ativa os bits digitais para PQ3-PQ0
            STR		R1, [R0]							  ; Seta o bit digital para PQ3-PQ0
			
; Habilitar resistor pull up para o push button
			LDR 	R0, =GPIO_PORTJ_AHB_PUR_R 			  ; Carrega o endereço do PUR para a porta J
			MOV 	R1, #2_00000011				     	  ; Seta o bit do PJ0 para utilizar o PUR
			STR 	R1, [R0]							  ; Salva o bit setado no PUR da porta J
			
; fim do setup dos registradores
			BX LR 

; -------------------------------------------------------------------------------

; Função Led_Output
; R2 -> Ticks a serem utilizados
; R3 -> valores de bits auxiliares
; Parâmetro de entrada: R0 -> Recebe os valores de leds a serem setados
; Par�metro de sa�da: N/A
Led_Output
	LDR R1, =GPIO_PORTA_AHB_DATA_R 		; Le o endereço do data
	MOV R3, #2_11110000					; Seta todos os valores poss�veis de led
    PUSH {R0}                           ; Salva o valor R0
    AND R0, R3, R0						; Faz o AND para verificar todos os valores que ir�o acender
	STR R0, [R1]						; Escreve na porta o novo valor
	
    POP {R0}                            ; Recupera o valor de R0
	LDR R1, =GPIO_PORTQ_DATA_R 		    ; Le o endereço do data
	MOV R3, #2_00001111					; Seta todos os valores poss�veis de led
    PUSH {R0}                           ; Salva o valor R0
    AND R0, R3, R0						; Faz o AND para verificar todos os valores que ir�o acender
	STR R0, [R1]						; Escreve na porta o novo valor
    POP {R0}                            ; Recupera o valor de R0

    MOV R2, #DELAY_MS

    LDR R1, =GPIO_PORTP_DATA_R 			; Le o endereço do data
	MOV R3, #2_00100000					; Ativa o DS2
	STR R3, [R1]						; Escreve na porta o novo valor

    PUSH {LR}                           ; Salva o Link Register
    BL SysTick_Wait1ms                  ; Espera 1ms

    LDR R1, =GPIO_PORTP_DATA_R 			; Le o endereço do data
	MOV R3, #2_00000000					; Desativa o DS2
	STR R3, [R1]						; Escreve na porta o novo valor
    
    MOV R2, #1
    BL SysTick_Wait1ms                  ; Espera 1ms

    POP {LR}                            ; Recupera LR
	BX LR
; -------------------------------------------------------------------------------

; Fun��o Display_Output
; Par�metro de entrada:
;   - R0 -> Recebe o valor em bin�rio para mostrar nos displays
; Par�metro de sa�da: N/A
Display_Output	
    PUSH {R0}                           ; Salva o valor R0
    PUSH {R1}                           ; Salva o valor R1
    PUSH {R2}                           ; Salva o valor R2
    PUSH {R3}                           ; Salva o valor R3
    PUSH {R4}                           ; Salva o valor R4
    PUSH {R5}                           ; Salva o valor R5
    PUSH {R6}                           ; Salva o valor R6
	
    ; R0 - Guarda o valor bin�rio
    ; R1 - Guarda o valor do bit a ser comparado
    ; R2 - Guarda o valor dos ANDs para testar se a express�o � verdadeira
    ; R3 - Guarda o valor da compara��o do bit com o valor dos mapas de karnaugh
    ; R4 - Guarda o valor do OR dos valores de R2 
    ; R5 - Guarda o valor a ser setado no display
    ; R6 - Usado para selecionar o display no qual mostrar o valor hexa

    ; =========================== Display Esq ===================================
    MOV R6, R0                          ; Guarda o valor de R0
    MOV R5, #2_01111111                 ; Seta os LEDs para HIGH pois a l�gica do mapa de karnaugh � invertida
    LSR R0, R0, #4                      ; Shifta 4 bits para a direita para pegar o valor da esquerda

    PUSH {LR}                           ; Salva o Link Register
    BL DefineLedA
    BL DefineLedB
    BL DefineLedC
    BL DefineLedD
    BL DefineLedE
    BL DefineLedF
    BL DefineLedG
    POP {LR}                            ; Recupera o Link Register

    PUSH {R5}                           ; Salva o valor R5
    LDR R1, =GPIO_PORTA_AHB_DATA_R 		; Le o endereço do data
	MOV R2, #2_11110000					; Seleciona os LEDs da Porta A
    AND R5, R2, R5						; Faz o AND para verificar todos os valores que ir�o acender
	STR R5, [R1]						; Escreve na porta o novo valor

    POP {R5}                            ; Recupera o valor de R5
	LDR R1, =GPIO_PORTQ_DATA_R 		    ; Le o endereço do data
	MOV R2, #2_00001111					; Seleciona os LEDs da Porta Q
;    PUSH {R5}                          ; Salva o valor R5 - a principio n�o precisa
    AND R5, R2, R5						; Faz o AND para verificar todos os valores que ir�o acender
	STR R5, [R1]						; Escreve na porta o novo valor

 
    ; Liga os leds do display
    LDR R1, =GPIO_PORTB_AHB_DATA_R 		; Le o endereço do data
	MOV R2, #2_00010000					; Insere um valor no R2
	STR R2, [R1]						; Escreve na porta o novo valor

    PUSH {LR}
    MOV R2, #DELAY_MS
    BL   SysTick_Wait1ms                ; Espera 0,1s

    ;Desativa os Leds do display
    LDR R1, =GPIO_PORTB_AHB_DATA_R 		; Le o endereço do data
	MOV R2, #2_00000000					; Insere um valor no R2
	STR R2, [R1]

    MOV R2, #1                           ; Espera 1ms
    BL SysTick_Wait1ms

    POP {LR}

    ; =========================== Display Dir ===================================
    MOV R0, R6                          ; Guarda o valor de R0
    MOV R5, #2_01111111                 ; Seta os LEDs para HIGH pois a l�gica do mapa de karnaugh � invertida
    PUSH {LR}                           ; Salva o Link Register
    BL DefineLedA
    BL DefineLedB
    BL DefineLedC
    BL DefineLedD
    BL DefineLedE
    BL DefineLedF
    BL DefineLedG
    POP {LR}                            ; Recupera o Link Register

    PUSH {R5}                           ; Salva o valor R5
    LDR R1, =GPIO_PORTA_AHB_DATA_R 		; Le o endereço do data
	MOV R2, #2_11110000					; Seleciona os LEDs da Porta A
    AND R5, R2, R5						; Faz o AND para verificar todos os valores que ir�o acender
	STR R5, [R1]						; Escreve na porta o novo valor

    POP {R5}                            ; Recupera o valor de R5
	LDR R1, =GPIO_PORTQ_DATA_R 		    ; Le o endereço do data
	MOV R2, #2_00001111					; Seleciona os LEDs da Porta Q
;    PUSH {R5}                           ; Salva o valor R5 - a principio n�o precisa
    AND R5, R2, R5						; Faz o AND para verificar todos os valores que ir�o acender
	STR R5, [R1]						; Escreve na porta o novo valor

    ; Liga os leds do display
    LDR R1, =GPIO_PORTB_AHB_DATA_R 		; Le o endereço do data
	MOV R2, #2_00100000					; Insere um valor no R2
	STR R2, [R1]						; Escreve na porta o novo valor

    PUSH {LR}
    MOV R2, #DELAY_MS
    BL   SysTick_Wait1ms                ; Espera 0,3s

    ;Desativa os Leds do display
    LDR R1, =GPIO_PORTB_AHB_DATA_R 		; Le o endereço do data
	MOV R2, #2_00000000					; Insere um valor no R2
	STR R2, [R1]

    MOV R2, #1                           ; Espera 1ms
    BL SysTick_Wait1ms

    POP {LR}

    POP {R6}                            ; Recupera o valor de R5
    POP {R5}                            ; Recupera o valor de R5
    POP {R4}                            ; Recupera o valor de R4
    POP {R3}                            ; Recupera o valor de R3
    POP {R2}                            ; Recupera o valor de R2
    POP {R1}                            ; Recupera o valor de R1
    POP {R0}                            ; Recupera o valor de R0
    BX LR
; -------------------------------------------------------------------------------

; Função Switch_Input
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: R0 --> o valor da leitura
Switch_Input
; ****************************************
; Escrever função que l� a chave e retorna 
; um registrador se est� ativada ou n�o
; ****************************************
	LDR	R1, =GPIO_PORTJ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	LDR R3, [R1]                            ;L� no barramento de dados o pino [J0, J1]
	
	BX LR

    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo