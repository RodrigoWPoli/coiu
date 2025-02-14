; motor.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 02/12/2024
; Ver 2 29/01/2025


; -------------------------------------------------------------------------------
		THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; ~~~~~~~~~~~~~ OTHER CONSTANTS ~~~~~~~~~~~~~~F
MOTOR_PERIOD			 	EQU 	0x2


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
GPIO_PORTH 					EQU     2_000000010000000

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
		
        IMPORT	SysTick_Wait1ms

; -------------------------------------------------------------------------------
; Funcao motor_acceleration
; Input: nenhum
; Output: nenhum

	

    ALIGN
    END