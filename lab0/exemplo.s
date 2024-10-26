; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi��o da RAM		

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun��o Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma fun��o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; fun��o <func>

; -------------------------------------------------------------------------------
; Fun��o main()
Start  
; Comece o c�digo aqui <======================================================

        LDR     R3, =0x20000A00             ;lista de entrada

        ; Lista de números aleatórios
        MOV     R2, #193
        STRB    R2, [R3], #1
        MOV     R2, #63
        STRB    R2, [R3], #1
        MOV     R2, #176
        STRB    R2, [R3], #1
        MOV     R2, #127
        STRB    R2, [R3], #1
        MOV     R2, #43
        STRB    R2, [R3], #1
        MOV     R2, #13
        STRB    R2, [R3], #1
        MOV     R2, #211
        STRB    R2, [R3], #1
        MOV     R2, #3
        STRB    R2, [R3], #1
        MOV     R2, #203
        STRB    R2, [R3], #1
        MOV     R2, #5
        STRB    R2, [R3], #1
        MOV     R2, #21
        STRB    R2, [R3], #1
        MOV     R2, #7
        STRB    R2, [R3], #1
        MOV     R2, #206
        STRB    R2, [R3], #1
        MOV     R2, #245
        STRB    R2, [R3], #1
        MOV     R2, #157
        STRB    R2, [R3], #1
        MOV     R2, #237
        STRB    R2, [R3], #1
        MOV     R2, #241
        STRB    R2, [R3], #1
        MOV     R2, #105
        STRB    R2, [R3], #1
        MOV     R2, #252
        STRB    R2, [R3], #1
        MOV     R2, #19
        STRB    R2, [R3], #1

        ; Início do programa
start
        LDR     R3, =0x20000A00
        LDR     R4, =0x20000B00
        MOV     R5, #20	
        MOV     R6, #0

;R3 é o ponteiro para a lista de entrada
;R4 é o ponteiro para a lista de saída
;R5 é o tamanho da lista
;R6 é o contador de primos
;R7 é o número a ser testado

check_prime
        LDRB    R7, [R3], #1
        BL      is_prime
        CMP     R0, #1
        BNE     not_prime

        STRB    R7, [R4], #1
        ADD     R6, R6, #1

not_prime
        SUBS    R5, R5, #1
        BNE     check_prime
		
		
		; Resto do programa aqui:
		
end
        B       end


;R0 é a flag de primo
;R1 é o divisor
is_prime
        CMP     R7, #2
        BLT     not_a_prime
        MOV     R0, #1   ;assume que é primo
        MOV     R1, #2   ;começa a testar a partir do 2

check_divisibility
        MUL     R2, R1, R1
        CMP     R2, R7
        BGT     end_prime       ; não achou divisor

        UDIV    R2, R7, R1
        MLS     R2, R2, R1, R7  ; encontra o resto
        CMP     R2, #0
        BEQ     not_a_prime

        ADD     R1, R1, #1      ; vai pro prox
        B       check_divisibility

not_a_prime ;not_prime não da pra utilizar
        MOV     R0, #0
end_prime
        BX      LR


	NOP
    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo
