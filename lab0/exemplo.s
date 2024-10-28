; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
HEAD_INICIAL	EQU 0x20000A00
HEAD_ORDENADO 	EQU 0x20000B00
; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>

; -------------------------------------------------------------------------------
; Função main()
Start  
; Comece o código aqui <======================================================

        LDR     R3, =HEAD_INICIAL             ;lista de entrada

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
        LDR     R3, =HEAD_INICIAL
        LDR     R4, =HEAD_ORDENADO
        MOV     R5, #20	
        MOV     R6, #0

;R0 é a flag de primo
;R1 é o divisor
;R3 é o ponteiro para a lista de entrada
;R4 é o ponteiro para a lista de saída
;R5 é o tamanho da lista inicial
;R6 é o contador de primos (tamanho da lista a ser ordenada)
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

;Acabou o tamanho da lista inicial, pula para ordenação
		B 		order   
		
is_prime
        CMP     R7, #2
        BLT     not_a_prime
        MOV     R0, #1   ;assume que é primo
        MOV     R1, #2   ;começa a testar a partir do 2

check_divisibility
        MUL     R2, R1, R1
        CMP     R2, R7
        BGT     end_prime       ; não achou divisor percorrendo até a N/2

        UDIV    R2, R7, R1
        MLS     R2, R2, R1, R7  ; encontra o resto
        CMP     R2, #0
        BEQ     not_a_prime

        ADD     R1, R1, #1      ; vai pro prox
        B       check_divisibility

not_a_prime ;not_prime não da pra utilizar, altera flag
        MOV     R0, #0
end_prime
        BX      LR
;-------------------------------------------------------------------------------------------;
;R2 é o endereço da lista a ser ordenada
;R3 é o valor i a ser comparado
;R4 é o valor i+1 a ser comparado
;R5 é um contador auxiliar
;R6 é o tamanho atual da lista a ser ordenada


;Ponteiro inicial E comparaçao de tamanhos
order
		LDR     R2, =HEAD_ORDENADO
		MOV		R5, #2
		
		CMP 	R6, R5
		BLO 	ordered
;Colocar nos registradores, comparar e trocar caso R4 > R5
compare
		LDRB 	R3, [R2]
		LDRB 	R4, [R2, #1]
		
		CMP 	R3, R4
		ITT  	HI
		STRBHI 	R4, [R2]
		STRBHI	R3, [R2, #1]

;Aumentar o contador temporário, comparar se chegou ao final do vetor e
;fazer a soma do ponteiro caso nao tenha acabado, ou diminuir o tam do 
;vetor caso tenha acabado
		ADD 	R5, #1
		
		CMP     R6, R5
		ITE   	LO
		 SUBLO  R6, #1        
		 ADDHS  R2, #1
		
		BLO		order
		B		compare
		
		
ordered

	NOP
    ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo
