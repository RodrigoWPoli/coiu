; timer.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araújo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 30/11/2024


; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ========================

; ========================
; Declaracoes de Timers
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
; Area de Codigo - Tudo abaixo da diretiva a seguir sera armazenado na memoria de 
;                  codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funcao do arquivo for chamada em outro arquivo	
        EXPORT Timer_Init
									

;--------------------------------------------------------------------------------
; Funcao Timer_Init
; Parametro de entrada: Nao tem
; Parametro de saida: Nao tem
Timer_Init
;=====================
; ****************************************