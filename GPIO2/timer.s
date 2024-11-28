; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
; ========================
; ========================
; Defini��es dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
; Defini��es dos Ports
; PORT J
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

; ~~~~~~~~~~~~~~~~ Timer 0 ~~~~~~~~~~~~~~~~~~

TIMER0_CFG_R                EQU     0x40030000
TIMER0_TAMR_R               EQU     0x40030004
TIMER0_TBMR_R               EQU     0x40030008
TIMER0_CTL_R                EQU     0x4003000C
TIMER0_SYNC_R               EQU     0x40030010
TIMER0_IMR_R                EQU     0x40030018
TIMER0_RIS_R                EQU     0x4003001C
TIMER0_MIS_R                EQU     0x40030020
TIMER0_ICR_R                EQU     0x40030024
TIMER0_TAILR_R              EQU     0x40030028
TIMER0_TBILR_R              EQU     0x4003002C
TIMER0_TAMATCHR_R           EQU     0x40030030
TIMER0_TBMATCHR_R           EQU     0x40030034
TIMER0_TAPR_R               EQU     0x40030038
TIMER0_TBPR_R               EQU     0x4003003C
TIMER0_TAPMR_R              EQU     0x40030040
TIMER0_TBPMR_R              EQU     0x40030044
TIMER0_TAR_R                EQU     0x40030048
TIMER0_TBR_R                EQU     0x4003004C
TIMER0_TAV_R                EQU     0x40030050
TIMER0_TBV_R                EQU     0x40030054
TIMER0_RTCPD_R              EQU     0x40030058
TIMER0_TAPS_R               EQU     0x4003005C
TIMER0_TBPS_R               EQU     0x40030060
TIMER0_DMAEV_R              EQU     0x4003006C
TIMER0_ADCEV_R              EQU     0x40030070
TIMER0_PP_R                 EQU     0x40030FC0
TIMER0_CC_R                 EQU     0x40030FC8
; ~~~~~~~~~~~~~~~~ Timer 1 ~~~~~~~~~~~~~~~~~~
TIMER1_CFG_R                EQU     0x40031000
TIMER1_TAMR_R               EQU     0x40031004
TIMER1_TBMR_R               EQU     0x40031008
TIMER1_CTL_R                EQU     0x4003100C
TIMER1_SYNC_R               EQU     0x40031010
TIMER1_IMR_R                EQU     0x40031018
TIMER1_RIS_R                EQU     0x4003101C
TIMER1_MIS_R                EQU     0x40031020
TIMER1_ICR_R                EQU     0x40031024
TIMER1_TAILR_R              EQU     0x40031028
TIMER1_TBILR_R              EQU     0x4003102C
TIMER1_TAMATCHR_R           EQU     0x40031030
TIMER1_TBMATCHR_R           EQU     0x40031034
TIMER1_TAPR_R               EQU     0x40031038
TIMER1_TBPR_R               EQU     0x4003103C
TIMER1_TAPMR_R              EQU     0x40031040
TIMER1_TBPMR_R              EQU     0x40031044
TIMER1_TAR_R                EQU     0x40031048
TIMER1_TBR_R                EQU     0x4003104C
TIMER1_TAV_R                EQU     0x40031050
TIMER1_TBV_R                EQU     0x40031054
TIMER1_RTCPD_R              EQU     0x40031058
TIMER1_TAPS_R               EQU     0x4003105C
TIMER1_TBPS_R               EQU     0x40031060
TIMER1_DMAEV_R              EQU     0x4003106C
TIMER1_ADCEV_R              EQU     0x40031070
TIMER1_PP_R                 EQU     0x40031FC0
TIMER1_CC_R                 EQU     0x40031FC8
; ~~~~~~~~~~~~~~~~ Timer 2 ~~~~~~~~~~~~~~~~~~
TIMER2_CFG_R                EQU     0x40032000
TIMER2_TAMR_R               EQU     0x40032004
TIMER2_TBMR_R               EQU     0x40032008
TIMER2_CTL_R                EQU     0x4003200C
TIMER2_SYNC_R               EQU     0x40032010
TIMER2_IMR_R                EQU     0x40032018
TIMER2_RIS_R                EQU     0x4003201C
TIMER2_MIS_R                EQU     0x40032020
TIMER2_ICR_R                EQU     0x40032024
TIMER2_TAILR_R              EQU     0x40032028
TIMER2_TBILR_R              EQU     0x4003202C
TIMER2_TAMATCHR_R           EQU     0x40032030
TIMER2_TBMATCHR_R           EQU     0x40032034
TIMER2_TAPR_R               EQU     0x40032038
TIMER2_TBPR_R               EQU     0x4003203C
TIMER2_TAPMR_R              EQU     0x40032040
TIMER2_TBPMR_R              EQU     0x40032044
TIMER2_TAR_R                EQU     0x40032048
TIMER2_TBR_R                EQU     0x4003204C
TIMER2_TAV_R                EQU     0x40032050
TIMER2_TBV_R                EQU     0x40032054
TIMER2_RTCPD_R              EQU     0x40032058
TIMER2_TAPS_R               EQU     0x4003205C
TIMER2_TBPS_R               EQU     0x40032060
TIMER2_DMAEV_R              EQU     0x4003206C
TIMER2_ADCEV_R              EQU     0x40032070
TIMER2_PP_R                 EQU     0x40032FC0
TIMER2_CC_R                 EQU     0x40032FC8

; ~~~~~~~~~~~~~~~~ Timer 3 ~~~~~~~~~~~~~~~~~~

TIMER3_CFG_R                EQU     0x40033000
TIMER3_TAMR_R               EQU     0x40033004
TIMER3_TBMR_R               EQU     0x40033008
TIMER3_CTL_R                EQU     0x4003300C
TIMER3_SYNC_R               EQU     0x40033010
TIMER3_IMR_R                EQU     0x40033018
TIMER3_RIS_R                EQU     0x4003301C
TIMER3_MIS_R                EQU     0x40033020
TIMER3_ICR_R                EQU     0x40033024
TIMER3_TAILR_R              EQU     0x40033028
TIMER3_TBILR_R              EQU     0x4003302C
TIMER3_TAMATCHR_R           EQU     0x40033030
TIMER3_TBMATCHR_R           EQU     0x40033034
TIMER3_TAPR_R               EQU     0x40033038
TIMER3_TBPR_R               EQU     0x4003303C
TIMER3_TAPMR_R              EQU     0x40033040
TIMER3_TBPMR_R              EQU     0x40033044
TIMER3_TAR_R                EQU     0x40033048
TIMER3_TBR_R                EQU     0x4003304C
TIMER3_TAV_R                EQU     0x40033050
TIMER3_TBV_R                EQU     0x40033054
TIMER3_RTCPD_R              EQU     0x40033058
TIMER3_TAPS_R               EQU     0x4003305C
TIMER3_TBPS_R               EQU     0x40033060
TIMER3_DMAEV_R              EQU     0x4003306C
TIMER3_ADCEV_R              EQU     0x40033070
TIMER3_PP_R                 EQU     0x40033FC0
TIMER3_CC_R                 EQU     0x40033FC8

; ~~~~~~~~~~~~~~~~ Timer 4 ~~~~~~~~~~~~~~~~~~

TIMER4_CFG_R                EQU     0x40034000
TIMER4_TAMR_R               EQU     0x40034004
TIMER4_TBMR_R               EQU     0x40034008
TIMER4_CTL_R                EQU     0x4003400C
TIMER4_SYNC_R               EQU     0x40034010
TIMER4_IMR_R                EQU     0x40034018
TIMER4_RIS_R                EQU     0x4003401C
TIMER4_MIS_R                EQU     0x40034020
TIMER4_ICR_R                EQU     0x40034024
TIMER4_TAILR_R              EQU     0x40034028
TIMER4_TBILR_R              EQU     0x4003402C
TIMER4_TAMATCHR_R           EQU     0x40034030
TIMER4_TBMATCHR_R           EQU     0x40034034
TIMER4_TAPR_R               EQU     0x40034038
TIMER4_TBPR_R               EQU     0x4003403C
TIMER4_TAPMR_R              EQU     0x40034040
TIMER4_TBPMR_R              EQU     0x40034044
TIMER4_TAR_R                EQU     0x40034048
TIMER4_TBR_R                EQU     0x4003404C
TIMER4_TAV_R                EQU     0x40034050
TIMER4_TBV_R                EQU     0x40034054
TIMER4_RTCPD_R              EQU     0x40034058
TIMER4_TAPS_R               EQU     0x4003405C
TIMER4_TBPS_R               EQU     0x40034060
TIMER4_DMAEV_R              EQU     0x4003406C
TIMER4_ADCEV_R              EQU     0x40034070
TIMER4_PP_R                 EQU     0x40034FC0
TIMER4_CC_R                 EQU     0x40034FC8

; ~~~~~~~~~~~~~~~~ Timer 5 ~~~~~~~~~~~~~~~~~~

TIMER5_CFG_R                EQU     0x40035000
TIMER5_TAMR_R               EQU     0x40035004
TIMER5_TBMR_R               EQU     0x40035008
TIMER5_CTL_R                EQU     0x4003500C
TIMER5_SYNC_R               EQU     0x40035010
TIMER5_IMR_R                EQU     0x40035018
TIMER5_RIS_R                EQU     0x4003501C
TIMER5_MIS_R                EQU     0x40035020
TIMER5_ICR_R                EQU     0x40035024
TIMER5_TAILR_R              EQU     0x40035028
TIMER5_TBILR_R              EQU     0x4003502C
TIMER5_TAMATCHR_R           EQU     0x40035030
TIMER5_TBMATCHR_R           EQU     0x40035034
TIMER5_TAPR_R               EQU     0x40035038
TIMER5_TBPR_R               EQU     0x4003503C
TIMER5_TAPMR_R              EQU     0x40035040
TIMER5_TBPMR_R              EQU     0x40035044
TIMER5_TAR_R                EQU     0x40035048
TIMER5_TBR_R                EQU     0x4003504C
TIMER5_TAV_R                EQU     0x40035050
TIMER5_TBV_R                EQU     0x40035054
TIMER5_RTCPD_R              EQU     0x40035058
TIMER5_TAPS_R               EQU     0x4003505C
TIMER5_TBPS_R               EQU     0x40035060
TIMER5_DMAEV_R              EQU     0x4003506C
TIMER5_ADCEV_R              EQU     0x40035070
TIMER5_PP_R                 EQU     0x40035FC0
TIMER5_CC_R                 EQU     0x40035FC8

; ~~~~~~~~~~~~~~~~ Timer 6 ~~~~~~~~~~~~~~~~~~

TIMER6_CFG_R                EQU     0x400E0000
TIMER6_TAMR_R               EQU     0x400E0004
TIMER6_TBMR_R               EQU     0x400E0008
TIMER6_CTL_R                EQU     0x400E000C
TIMER6_SYNC_R               EQU     0x400E0010
TIMER6_IMR_R                EQU     0x400E0018
TIMER6_RIS_R                EQU     0x400E001C
TIMER6_MIS_R                EQU     0x400E0020
TIMER6_ICR_R                EQU     0x400E0024
TIMER6_TAILR_R              EQU     0x400E0028
TIMER6_TBILR_R              EQU     0x400E002C
TIMER6_TAMATCHR_R           EQU     0x400E0030
TIMER6_TBMATCHR_R           EQU     0x400E0034
TIMER6_TAPR_R               EQU     0x400E0038
TIMER6_TBPR_R               EQU     0x400E003C
TIMER6_TAPMR_R              EQU     0x400E0040
TIMER6_TBPMR_R              EQU     0x400E0044
TIMER6_TAR_R                EQU     0x400E0048
TIMER6_TBR_R                EQU     0x400E004C
TIMER6_TAV_R                EQU     0x400E0050
TIMER6_TBV_R                EQU     0x400E0054
TIMER6_RTCPD_R              EQU     0x400E0058
TIMER6_TAPS_R               EQU     0x400E005C
TIMER6_TBPS_R               EQU     0x400E0060
TIMER6_DMAEV_R              EQU     0x400E006C
TIMER6_ADCEV_R              EQU     0x400E0070
TIMER6_PP_R                 EQU     0x400E0FC0
TIMER6_CC_R                 EQU     0x400E0FC8

; ~~~~~~~~~~~~~~~~ Timer 7 ~~~~~~~~~~~~~~~~~~

TIMER7_CFG_R                EQU     0x400E1000
TIMER7_TAMR_R               EQU     0x400E1004
TIMER7_TBMR_R               EQU     0x400E1008
TIMER7_CTL_R                EQU     0x400E100C
TIMER7_SYNC_R               EQU     0x400E1010
TIMER7_IMR_R                EQU     0x400E1018
TIMER7_RIS_R                EQU     0x400E101C
TIMER7_MIS_R                EQU     0x400E1020
TIMER7_ICR_R                EQU     0x400E1024
TIMER7_TAILR_R              EQU     0x400E1028
TIMER7_TBILR_R              EQU     0x400E102C
TIMER7_TAMATCHR_R           EQU     0x400E1030
TIMER7_TBMATCHR_R           EQU     0x400E1034
TIMER7_TAPR_R               EQU     0x400E1038
TIMER7_TBPR_R               EQU     0x400E103C
TIMER7_TAPMR_R              EQU     0x400E1040
TIMER7_TBPMR_R              EQU     0x400E1044
TIMER7_TAR_R                EQU     0x400E1048
TIMER7_TBR_R                EQU     0x400E104C
TIMER7_TAV_R                EQU     0x400E1050
TIMER7_TBV_R                EQU     0x400E1054
TIMER7_RTCPD_R              EQU     0x400E1058
TIMER7_TAPS_R               EQU     0x400E105C
TIMER7_TBPS_R               EQU     0x400E1060
TIMER7_DMAEV_R              EQU     0x400E106C
TIMER7_ADCEV_R              EQU     0x400E1070
TIMER7_PP_R                 EQU     0x400E1FC0
TIMER7_CC_R                 EQU     0x400E1FC8



; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
		EXPORT PortN_Output			; Permite chamar PortN_Output de outro arquivo
		EXPORT PortJ_Input          ; Permite chamar PortJ_Input de outro arquivo
									

;--------------------------------------------------------------------------------
; Fun��o GPIO_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
GPIO_Init
;=====================
; ****************************************