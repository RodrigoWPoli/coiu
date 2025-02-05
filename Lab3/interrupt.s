; timer.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 2/12/2024


; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ========================
ANGLE            	     EQU     0x20030000
TURN			     	 EQU     0x20030004
MODE         		     EQU     0x20030008
APOLARITY         	     EQU     0x2003000C
TPOLARITY         	     EQU     0x20030010
; ================== DEFINICOES DOS PORTS ===================

; ~~~~~~~~~~~~~~~~ PORT A ~~~~~~~~~~~~~~~~~~
GPIO_PORTA_AHB_IM_R             EQU    0x40058410
GPIO_PORTA_AHB_IS_R             EQU    0x40058404
GPIO_PORTA_AHB_IBE_R            EQU    0x40058408
GPIO_PORTA_AHB_IEV_R            EQU    0x4005840C
GPIO_PORTA_AHB_ICR_R            EQU    0x4005841C
GPIO_PORTA_AHB_DATA_R   		EQU    0x400583FC
GPIO_PORTA 						EQU    2_000000000000001

; ~~~~~~~~~~~~~~~~ PORT B ~~~~~~~~~~~~~~~~~~
GPIO_PORTB_AHB_IM_R             EQU     0x40059410
GPIO_PORTB_AHB_IS_R             EQU     0x40059404
GPIO_PORTB_AHB_IBE_R            EQU     0x40059408
GPIO_PORTB_AHB_IEV_R            EQU     0x4005940C
GPIO_PORTB_AHB_ICR_R            EQU     0x4005941C
GPIO_PORTB_AHB_DATA_R   		EQU     0x400593FC
GPIO_PORTB 						EQU     2_000000000000010

; ~~~~~~~~~~~~~~~~ PORT C ~~~~~~~~~~~~~~~~~~
GPIO_PORTC_AHB_IS_R             EQU     0x4005A404
GPIO_PORTC_AHB_IBE_R            EQU     0x4005A408
GPIO_PORTC_AHB_IEV_R            EQU     0x4005A40C
GPIO_PORTC_AHB_IM_R             EQU     0x4005A410
GPIO_PORTC_AHB_ICR_R            EQU     0x4005A41C
GPIO_PORTC_AHB_DATA_R   		EQU     0x4005A3FC
GPIO_PORTC 						EQU     2_000000000000100

; ~~~~~~~~~~~~~~~~ PORT D ~~~~~~~~~~~~~~~~~~
GPIO_PORTD_AHB_IM_R             EQU     0x4005B410
GPIO_PORTD_AHB_IS_R             EQU     0x4005B404
GPIO_PORTD_AHB_IBE_R            EQU     0x4005B408
GPIO_PORTD_AHB_IEV_R            EQU     0x4005B40C
GPIO_PORTD_AHB_ICR_R            EQU     0x4005B41C
GPIO_PORTD_AHB_DATA_R   		EQU     0x4005B3FC
GPIO_PORTD 						EQU     2_000000000001000

; ~~~~~~~~~~~~~~~~ PORT E ~~~~~~~~~~~~~~~~~~   
GPIO_PORTE_AHB_IM_R             EQU     0x4005C410
GPIO_PORTE_AHB_IS_R             EQU     0x4005C404
GPIO_PORTE_AHB_IBE_R            EQU     0x4005C408
GPIO_PORTE_AHB_IEV_R            EQU     0x4005C40C
GPIO_PORTE_AHB_ICR_R            EQU     0x4005C41C
GPIO_PORTE_AHB_DATA_R   		EQU     0x4005C3FC
GPIO_PORTE 						EQU     2_000000000010000

; ~~~~~~~~~~~~~~~~ PORT F ~~~~~~~~~~~~~~~~~~
GPIO_PORTF_AHB_IM_R             EQU     0x4005D410
GPIO_PORTF_AHB_IS_R             EQU     0x4005D404
GPIO_PORTF_AHB_IBE_R            EQU     0x4005D408
GPIO_PORTF_AHB_IEV_R            EQU     0x4005D40C
GPIO_PORTF_AHB_ICR_R            EQU     0x4005D41C
GPIO_PORTF_AHB_DATA_R   		EQU     0x4005D3FC
GPIO_PORTF 						EQU     2_000000000100000

; ~~~~~~~~~~~~~~~~ PORT G ~~~~~~~~~~~~~~~~~~
GPIO_PORTG_AHB_IM_R             EQU     0x4005E410
GPIO_PORTG_AHB_IS_R             EQU     0x4005E404
GPIO_PORTG_AHB_IBE_R            EQU     0x4005E408
GPIO_PORTG_AHB_IEV_R            EQU     0x4005E40C
GPIO_PORTG_AHB_ICR_R            EQU     0x4005E41C
GPIO_PORTG_AHB_DATA_R   		EQU     0x4005E3FC
GPIO_PORTG 						EQU     2_000000001000000

; ~~~~~~~~~~~~~~~~ PORT H ~~~~~~~~~~~~~~~~~~
GPIO_PORTH_AHB_IM_R             EQU     0x4005F410
GPIO_PORTH_AHB_IS_R             EQU     0x4005F404
GPIO_PORTH_AHB_IBE_R            EQU     0x4005F408
GPIO_PORTH_AHB_IEV_R            EQU     0x4005F40C
GPIO_PORTH_AHB_ICR_R            EQU     0x4005F41C
GPIO_PORTH_AHB_DATA_R   		EQU     0x4005F3FC
GPIO_PORTH 						EQU     2_000000010000000

; ~~~~~~~~~~~~~~~~ PORT J ~~~~~~~~~~~~~~~~~~
GPIO_PORTJ_AHB_IS_R             EQU    0x40060404
GPIO_PORTJ_AHB_IBE_R            EQU    0x40060408
GPIO_PORTJ_AHB_IEV_R            EQU    0x4006040C
GPIO_PORTJ_AHB_IM_R             EQU    0x40060410
GPIO_PORTJ_AHB_RIS_R            EQU    0x40060414
GPIO_PORTJ_AHB_ICR_R            EQU    0x4006041C
GPIO_PORTJ_AHB_DATA_R    		EQU    0x400603FC
GPIO_PORTJ               		EQU    2_000000100000000

; ~~~~~~~~~~~~~~~~ PORT K ~~~~~~~~~~~~~~~~~~
GPIO_PORTK_IM_R                 EQU    0x40061410
GPIO_PORTK_IS_R                 EQU    0x40061404
GPIO_PORTK_IBE_R                EQU    0x40061408
GPIO_PORTK_IEV_R                EQU    0x4006140C
GPIO_PORTK_ICR_R                EQU    0x4006141C
GPIO_PORTK_DATA_R    	        EQU    0x400613FC
GPIO_PORTK               		EQU    2_000001000000000

; ~~~~~~~~~~~~~~~~ PORT L ~~~~~~~~~~~~~~~~~~
GPIO_PORTL_IM_R                 EQU    0x40062410
GPIO_PORTL_IS_R                 EQU    0x40062404
GPIO_PORTL_IBE_R                EQU    0x40062408
GPIO_PORTL_IEV_R                EQU    0x4006240C
GPIO_PORTL_ICR_R                EQU    0x4006241C
GPIO_PORTL_DATA_R               EQU    0x400623FC
GPIO_PORTL                      EQU    2_000010000000000

; ~~~~~~~~~~~~~~~~ PORT M ~~~~~~~~~~~~~~~~~~
GPIO_PORTM_IM_R                 EQU    0x40063410
GPIO_PORTM_IS_R                 EQU    0x40063404
GPIO_PORTM_IBE_R                EQU    0x40063408
GPIO_PORTM_IEV_R                EQU    0x4006340C
GPIO_PORTM_ICR_R                EQU    0x4006341C
GPIO_PORTM_DATA_R               EQU    0x400633FC
GPIO_PORTM                      EQU    2_000100000000000

; ~~~~~~~~~~~~~~~~ PORT N ~~~~~~~~~~~~~~~~~~
GPIO_PORTN_IM_R                 EQU    0x40064410
GPIO_PORTN_IS_R                 EQU    0x40064404
GPIO_PORTN_IBE_R                EQU    0x40064408
GPIO_PORTN_IEV_R                EQU    0x4006440C
GPIO_PORTN_ICR_R                EQU    0x4006441C
GPIO_PORTN_DATA_R               EQU    0x400643FC
GPIO_PORTN                      EQU    2_001000000000000

; ~~~~~~~~~~~~~~~~ PORT P ~~~~~~~~~~~~~~~~~~
GPIO_PORTP_IM_R                 EQU    0x40065410
GPIO_PORTP_IS_R                 EQU    0x40065404
GPIO_PORTP_IBE_R                EQU    0x40065408
GPIO_PORTP_IEV_R                EQU    0x4006540C
GPIO_PORTP_ICR_R                EQU    0x4006541C
GPIO_PORTP_DATA_R               EQU    0x400653FC
GPIO_PORTP                      EQU    2_010000000000000

; ~~~~~~~~~~~~~~~~ PORT Q ~~~~~~~~~~~~~~~~~~
GPIO_PORTQ_IM_R                 EQU    0x40066410
GPIO_PORTQ_IS_R                 EQU    0x40066404
GPIO_PORTQ_IBE_R                EQU    0x40066408
GPIO_PORTQ_IEV_R                EQU    0x4006640C
GPIO_PORTQ_ICR_R                EQU    0x4006641C
GPIO_PORTQ_DATA_R               EQU    0x400663FC
GPIO_PORTQ                      EQU    2_100000000000000


; ================== DEFINICOES DO NVIC ===================

; ~~~~~~~~~~~~~~~~ ENABLE ~~~~~~~~~~~~~~~~~~
NVIC_EN0_R                      EQU     0xE000E100
NVIC_EN1_R                      EQU     0xE000E104
NVIC_EN2_R                      EQU     0xE000E108
NVIC_EN3_R                      EQU     0xE000E10C

; ~~~~~~~~~~~~~~~~ DISABLE ~~~~~~~~~~~~~~~~~~
NVIC_DIS0_R                     EQU     0xE000E180
NVIC_DIS1_R                     EQU     0xE000E184
NVIC_DIS2_R                     EQU     0xE000E188
NVIC_DIS3_R                     EQU     0xE000E18C

; ~~~~~~~~~~~~~~~~ PRIORITY ~~~~~~~~~~~~~~~~~~
NVIC_PRI0_R                     EQU     0xE000E400
NVIC_PRI1_R                     EQU     0xE000E404
NVIC_PRI2_R                     EQU     0xE000E408
NVIC_PRI3_R                     EQU     0xE000E40C
NVIC_PRI4_R                     EQU     0xE000E410
NVIC_PRI5_R                     EQU     0xE000E414
NVIC_PRI6_R                     EQU     0xE000E418
NVIC_PRI7_R                     EQU     0xE000E41C
NVIC_PRI8_R                     EQU     0xE000E420
NVIC_PRI9_R                     EQU     0xE000E424
NVIC_PRI10_R                    EQU     0xE000E428
NVIC_PRI11_R                    EQU     0xE000E42C
NVIC_PRI12_R                    EQU     0xE000E430
NVIC_PRI13_R                    EQU     0xE000E434
NVIC_PRI14_R                    EQU     0xE000E438
NVIC_PRI15_R                    EQU     0xE000E43C
NVIC_PRI16_R                    EQU     0xE000E440
NVIC_PRI17_R                    EQU     0xE000E444
NVIC_PRI18_R                    EQU     0xE000E448
NVIC_PRI19_R                    EQU     0xE000E44C
NVIC_PRI20_R                    EQU     0xE000E450
NVIC_PRI21_R                    EQU     0xE000E454
NVIC_PRI22_R                    EQU     0xE000E458
NVIC_PRI23_R                    EQU     0xE000E45C
NVIC_PRI24_R                    EQU     0xE000E460
NVIC_PRI25_R                    EQU     0xE000E464
NVIC_PRI26_R                    EQU     0xE000E468
NVIC_PRI27_R                    EQU     0xE000E46C
NVIC_PRI28_R                    EQU     0xE000E470
; -------------------------------------------------------------------------------
; Area de Codigo - Tudo abaixo da diretiva a seguir sera armazenado na memoria de 
;                  codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funcao do arquivo for chamada em outro arquivo	
        EXPORT Interrupt_Init
        EXPORT GPIOPortJ_Handler
									
        IMPORT SysTick_Wait1ms
        IMPORT create_reset_row
        IMPORT create_mode_row
        IMPORT LCD_Reset
;--------------------------------------------------------------------------------
;=========================================
; Funcao Interrupt_Init
; Parametro de entrada: Nao tem
; Parametro de saida: Nao tem
Interrupt_Init

; 1. Desabilitar a interrupcao no registradore IM
        MOV     R1, #0x00						                ;Desabilitar as interrupcoes
        LDR     R0, =GPIO_PORTJ_AHB_IM_R                                                ;Carrega o endereco do IM para a porta generica
        STR     R1, [R0]                                                                ;Escreve no registrador

; 2. Configurar o tipo de interrupcao (borda = 0 , nivel = 1) no IS

        MOV     R1, #2_00                                                               ;Por borda
        LDR     R0, =GPIO_PORTJ_AHB_IS_R                                                ;Carrega o endereco IS para a porta generica
        STR     R1, [R0]                                                                ;Seta o valor no registrador

; 3. Configurar tipo de borda (unica = 0, dupla = 1) no IBE

        MOV     R1, #2_00                                                               ;Por borda unica
        LDR     R0, =GPIO_PORTJ_AHB_IBE_R                                               ;Carrega o endereco IBE para a porta generica
        STR     R1, [R0]                                                                ;Seta o valor no registrador

; 4. Configurar modo da borda (descida = 0, subida = 1) no IEV                          

        MOV     R1, #2_00                                                               ;Por borda de descida
        LDR     R0, =GPIO_PORTJ_AHB_IEV_R                                               ;Carrega o endereco IEV para a porta generica
        STR     R1, [R0]                                                                ;Seta o valor no registrador

; 5. Realizar o ack para garantir que a interrupcao ira ocorrer no ICR

        MOV     R1, #2_11                                                               ;Seta o bit de acknowledge
        LDR     R0, =GPIO_PORTJ_AHB_ICR_R                                               ;Pega o endereco do ICR
        STR     R1, [R0]                                                                ;Seta o valor no registrador
        
; 6. Habilitar a interrupcao no registrador IM

        MOV     R1, #2_11						                ;Habilitar as interrupcoes
        LDR     R0, =GPIO_PORTJ_AHB_IM_R                                                ;Carrega o endereco do IM para a porta generica
        STR     R1, [R0]                                                                ;Escreve no registrador

; 7. Habilitar fonte de interrupcao no NVIC (Portj = interrupcao 51 - pag 116, tabela 2-9)
; Achar qual o ENX - Tabela 3-8, pagina 146

        MOV     R1, #1                                                                  ;Seta 1
        LSL     R1, #19                                                                 ;Desloca 19 bits, ja que 51-32=19 (intervalo entre inicio do EN que contem o 51)
        LDR     R0, =NVIC_EN1_R                                                         ;Carrega o endereco do EN1
        STR     R1, [R0]                                                                ;Seta no registrador

; 8. Setar prioridade no NVIC, achar qual PRIX - Tabela 3-8, pagina 147
 
        MOV     R1, #2                                                                  ;Prioridade 2
        LSL     R1, #29                                                                 ;Deslocar 29 bits para ir pro ultimo byte do PRI12
        LDR     R0, =NVIC_PRI12_R                                                       ;Carrega o endereco do PRI12
        STR     R1, [R0]                                                                ;Seta no registrador
		
		BX LR
;=========================================
; ******************************************************

;Funcao GPIOPortJ_Handler ISR, tratamento de interrupcao
;Parametro de entrada: nao tem
;Parametro de saida: nao tem
GPIOPortJ_Handler
        PUSH    {LR}

        LDR     R0, =GPIO_PORTJ_AHB_RIS_R                                               ;Carrega o endereco do RIS para verificar qual botão foi apertado
        LDR     R1, [R0]                                                                ;Carrega o valor do RIS
        CMP     R1, #2_00000001                                                         ;Verifica se o botão 0 foi apertado
        BEQ     sw1

        CMP     R1, #2_00000010                                                         ;Verifica se o botão 1 foi apertado
        BEQ     sw2

        B      debounce_skip

sw1
        LDR     R0, =GPIO_PORTJ_AHB_ICR_R                                               ;Carrega o endereco do ICR para o ack
        MOV     R1, #2_00000001                                                         ;Seta o bit 0 para ack
        STR     R1, [R0]                                                                ;Salva no registrador

        LDR		R0, =GPIO_PORTJ_AHB_DATA_R
        LDR 	R1, [R0]
		
        MOV 	R2, #20
        BL 		SysTick_Wait1ms
	
        LDR		R0, =GPIO_PORTJ_AHB_DATA_R
        LDR 	R2, [R0]
		
        CMP 	R1, R2								; Ignora varia��es de freq. > 50Hz
        BNE 	debounce_skip

        LDR     R0, =MODE
        LDR     R1, [R0]
        EOR     R1, R1, #1                                                      ;XOR para inverter o modo
        STR     R1, [R0]                                                        ;Salva o valor na memoria

        BL      create_mode_row
sw2
        LDR     R0, =GPIO_PORTJ_AHB_ICR_R                                               ;Carrega o endereco do ICR para o ack
        MOV     R1, #2_00000010                                                         ;Seta o bit 0 para ack
        STR     R1, [R0]                                                                ;Salva no registrador

        LDR		R0, =GPIO_PORTJ_AHB_DATA_R
        LDR 	R1, [R0]
		
        MOV 	R2, #20
        BL 		SysTick_Wait1ms
	
        LDR		R0, =GPIO_PORTJ_AHB_DATA_R
        LDR 	R2, [R0]
		
        CMP 	R1, R2								; Ignora varia��es de freq. > 50Hz
        BNE 	debounce_skip

		MOV R1, #0						 ;Reset do angulo, das voltas e das polaridades
		LDR R0, =ANGLE
		STR R1, [R0]
		LDR R0, =TURN
		STR R1, [R0]
		LDR R0, =APOLARITY
		STR R1, [R0]
		LDR R0, =TPOLARITY
		STR R1, [R0]        
		
        BL      create_reset_row   

debounce_skip
        POP     {LR}
        BX      LR

;=========================================
; ******************************************************

        ALIGN                        ;Garante que o fim da secao esta alinhada 
        END                          ;Fim do arquivo
