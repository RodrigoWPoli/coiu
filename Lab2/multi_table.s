; multi_table.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araujo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 02/12/2024


; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ========================

; ================== DEFINICAO DA TABELA ===================

MULTI_HEAD	EQU 0x20000A00

; -------------------------------------------------------------------------------
; Area de Codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

        EXPORT  create_table
        EXPORT  multi_table
        EXPORT  create_table

; Funcao create_table
; Configura o espaço de memória para armazenar os números da tabuada e dígito 'atual'
create_table
    LDR     R3, =MULTI_HEAD
    MOV     R1, #10              ; Qtd de numeros a serem armazenados + 1
    MOV     R2, #9              ; Digito inicial armazenado

store_loop
    STRB    R2, [R3], #1
    SUBS    R1, R1, #1
    CMP     R1, #0
    BNE     store_loop

    BX      LR

; Funcao multi_table
; input: R1 -> Valor da tecla pressionada
; Saida: R2 -> Fator multiplicativo atualizado do numero
multi_table
    LDR     R0, =MULTI_HEAD     
    ADD     R0, R0, R1
    LDRB    R2, [R0]            ; Carrega o valor atual da tabuada do dígito em R2
    
    ADD     R2, R2, #1          ; Incrementa o contador do dígito

    CMP     R2, #9              ; Checa se o valor ultrapassa 9
    IT      HI
    MOVHI   R2, #0

    STRB    R2, [R0]            ; Armazena o valor atualizado na memória
    
    MUL     R2, R2, R1          ; Multiplica o dígito pelo contador para determinar o resultado

    BX      LR 


    ALIGN
    END