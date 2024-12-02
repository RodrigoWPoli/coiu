; timer.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 30/11/2024


; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ========================

; ================== DEFINIÇÕES DOS PORTS ===================

; ~~~~~~~~~~~~~~~~ PORT A ~~~~~~~~~~~~~~~~~~
GPIO_PORTA_AHB_IM_R             EQU    0x40058410
GPIO_PORTA_AHB_IS_R             EQU    0x40058404
GPIO_PORTA_AHB_IBE_R            EQU    0x40058408
GPIO_PORTA_AHB_IEV_R            EQU    0x4005840C
GPIO_PORTA_AHB_ICR_R            EQU    0x4005841C
GPIO_PORTA_AHB_DATA_R   	EQU    0x400583FC
GPIO_PORTA 			EQU    2_000000000000001

; ~~~~~~~~~~~~~~~~ PORT B ~~~~~~~~~~~~~~~~~~
GPIO_PORTB_AHB_IM_R             EQU     0x40059410
GPIO_PORTB_AHB_IS_R             EQU     0x40059404
GPIO_PORTB_AHB_IBE_R            EQU     0x40059408
GPIO_PORTB_AHB_IEV_R            EQU     0x4005940C
GPIO_PORTB_AHB_ICR_R            EQU     0x4005941C
GPIO_PORTB_AHB_DATA_R   	EQU     0x400593FC
GPIO_PORTB 			EQU     2_000000000000010

; ~~~~~~~~~~~~~~~~ PORT C ~~~~~~~~~~~~~~~~~~
GPIO_PORTC_AHB_IS_R             EQU     0x4005A404
GPIO_PORTC_AHB_IBE_R            EQU     0x4005A408
GPIO_PORTC_AHB_IEV_R            EQU     0x4005A40C
GPIO_PORTC_AHB_IM_R             EQU     0x4005A410
GPIO_PORTC_AHB_ICR_R            EQU     0x4005A41C
GPIO_PORTC_AHB_DATA_R   	EQU     0x4005A3FC
GPIO_PORTC 			EQU     2_000000000000100

; ~~~~~~~~~~~~~~~~ PORT D ~~~~~~~~~~~~~~~~~~
GPIO_PORTD_AHB_IM_R             EQU     0x4005B410
GPIO_PORTD_AHB_IS_R             EQU     0x4005B404
GPIO_PORTD_AHB_IBE_R            EQU     0x4005B408
GPIO_PORTD_AHB_IEV_R            EQU     0x4005B40C
GPIO_PORTD_AHB_ICR_R            EQU     0x4005B41C
GPIO_PORTD_AHB_DATA_R   	EQU     0x4005B3FC
GPIO_PORTD 			EQU     2_000000000001000

; ~~~~~~~~~~~~~~~~ PORT E ~~~~~~~~~~~~~~~~~~   
GPIO_PORTE_AHB_IM_R             EQU     0x4005C410
GPIO_PORTE_AHB_IS_R             EQU     0x4005C404
GPIO_PORTE_AHB_IBE_R            EQU     0x4005C408
GPIO_PORTE_AHB_IEV_R            EQU     0x4005C40C
GPIO_PORTE_AHB_ICR_R            EQU     0x4005C41C
GPIO_PORTE_AHB_DATA_R   	EQU     0x4005C3FC
GPIO_PORTE 			EQU     2_000000000010000

; ~~~~~~~~~~~~~~~~ PORT F ~~~~~~~~~~~~~~~~~~
GPIO_PORTF_AHB_IM_R             EQU     0x4005D410
GPIO_PORTF_AHB_IS_R             EQU     0x4005D404
GPIO_PORTF_AHB_IBE_R            EQU     0x4005D408
GPIO_PORTF_AHB_IEV_R            EQU     0x4005D40C
GPIO_PORTF_AHB_ICR_R            EQU     0x4005D41C
GPIO_PORTF_AHB_DATA_R   	EQU     0x4005D3FC
GPIO_PORTF 			EQU     2_000000000100000

; ~~~~~~~~~~~~~~~~ PORT G ~~~~~~~~~~~~~~~~~~
GPIO_PORTG_AHB_IM_R             EQU     0x4005E410
GPIO_PORTG_AHB_IS_R             EQU     0x4005E404
GPIO_PORTG_AHB_IBE_R            EQU     0x4005E408
GPIO_PORTG_AHB_IEV_R            EQU     0x4005E40C
GPIO_PORTG_AHB_ICR_R            EQU     0x4005E41C
GPIO_PORTG_AHB_DATA_R   	EQU     0x4005E3FC
GPIO_PORTG 			EQU     2_000000001000000

; ~~~~~~~~~~~~~~~~ PORT H ~~~~~~~~~~~~~~~~~~
GPIO_PORTH_AHB_IM_R             EQU     0x4005F410
GPIO_PORTH_AHB_IS_R             EQU     0x4005F404
GPIO_PORTH_AHB_IBE_R            EQU     0x4005F408
GPIO_PORTH_AHB_IEV_R            EQU     0x4005F40C
GPIO_PORTH_AHB_ICR_R            EQU     0x4005F41C
GPIO_PORTH_AHB_DATA_R   	EQU     0x4005F3FC
GPIO_PORTH 			EQU     2_000000010000000

; ~~~~~~~~~~~~~~~~ PORT J ~~~~~~~~~~~~~~~~~~
GPIO_PORTJ_AHB_IM_R             EQU    0x40060410
GPIO_PORTJ_AHB_IS_R             EQU    0x40060404
GPIO_PORTJ_AHB_IBE_R            EQU    0x40060408
GPIO_PORTJ_AHB_IEV_R            EQU    0x4006040C
GPIO_PORTJ_AHB_ICR_R            EQU    0x4006041C
GPIO_PORTJ_AHB_DATA_R    	EQU    0x400603FC
GPIO_PORTJ               	EQU    2_000000100000000

; ~~~~~~~~~~~~~~~~ PORT K ~~~~~~~~~~~~~~~~~~
GPIO_PORTK_AHB_IM_R             EQU    0x40061410
GPIO_PORTK_AHB_IS_R             EQU    0x40061404
GPIO_PORTK_AHB_IBE_R            EQU    0x40061408
GPIO_PORTK_AHB_IEV_R            EQU    0x4006140C
GPIO_PORTK_AHB_ICR_R            EQU    0x4006141C
GPIO_PORTK_AHB_DATA_R    	EQU    0x400613FC
GPIO_PORTK               	EQU    2_000001000000000

; ~~~~~~~~~~~~~~~~ PORT L ~~~~~~~~~~~~~~~~~~
GPIO_PORTL_AHB_IM_R             EQU    0x40062410
GPIO_PORTL_AHB_IS_R             EQU    0x40062404
GPIO_PORTL_AHB_IBE_R            EQU    0x40062408
GPIO_PORTL_AHB_IEV_R            EQU    0x4006240C
GPIO_PORTL_AHB_ICR_R            EQU    0x4006241C
GPIO_PORTL_DATA_R               EQU    0x400623FC
GPIO_PORTL                      EQU    2_000010000000000

; ~~~~~~~~~~~~~~~~ PORT M ~~~~~~~~~~~~~~~~~~
GPIO_PORTM_AHB_IM_R             EQU    0x40063410
GPIO_PORTM_AHB_IS_R             EQU    0x40063404
GPIO_PORTM_AHB_IBE_R            EQU    0x40063408
GPIO_PORTM_AHB_IEV_R            EQU    0x4006340C
GPIO_PORTM_AHB_ICR_R            EQU    0x4006341C
GPIO_PORTM_DATA_R               EQU    0x400633FC
GPIO_PORTM                      EQU    2_000100000000000

; ~~~~~~~~~~~~~~~~ PORT N ~~~~~~~~~~~~~~~~~~
GPIO_PORTN_AHB_IM_R             EQU    0x40064410
GPIO_PORTN_AHB_IS_R             EQU    0x40064404
GPIO_PORTN_AHB_IBE_R            EQU    0x40064408
GPIO_PORTN_AHB_IEV_R            EQU    0x4006440C
GPIO_PORTN_AHB_ICR_R            EQU    0x4006441C
GPIO_PORTN_DATA_R               EQU    0x400643FC
GPIO_PORTN                      EQU    2_001000000000000

; ~~~~~~~~~~~~~~~~ PORT P ~~~~~~~~~~~~~~~~~~
GPIO_PORTP_AHB_IM_R             EQU    0x40065410
GPIO_PORTP_AHB_IS_R             EQU    0x40065404
GPIO_PORTP_AHB_IBE_R            EQU    0x40065408
GPIO_PORTP_AHB_IEV_R            EQU    0x4006540C
GPIO_PORTP_AHB_ICR_R            EQU    0x4006541C
GPIO_PORTP_DATA_R               EQU    0x400653FC
GPIO_PORTP                      EQU    2_010000000000000

; ~~~~~~~~~~~~~~~~ PORT Q ~~~~~~~~~~~~~~~~~~
GPIO_PORTQ_AHB_IM_R             EQU    0x40066410
GPIO_PORTQ_AHB_IS_R             EQU    0x40066404
GPIO_PORTQ_AHB_IBE_R            EQU    0x40066408
GPIO_PORTQ_AHB_IEV_R            EQU    0x4006640C
GPIO_PORTQ_AHB_ICR_R            EQU    0x4006641C
GPIO_PORTQ_DATA_R               EQU    0x400663FC
GPIO_PORTQ                      EQU    2_100000000000000


; ================== DEFINIÇÕES DO NVIC ===================

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
									

;--------------------------------------------------------------------------------
; Funcao Timer_Init
; Parametro de entrada: Nao tem
; Parametro de saida: Nao tem
Interrupt_Init

        
;=====================
; ****************************************