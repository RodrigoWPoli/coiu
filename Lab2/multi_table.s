; multi_table.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araújo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Ver 1 02/12/2024


; -------------------------------------------------------------------------------
        THUMB                        ; Instrucoes do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declaracoes EQU - Defines
; ========================

; ================== DEFINIÇÃO DA TABELA ===================

        MULTI_HEAD	EQU 0x20000A00

; -------------------------------------------------------------------------------
; Area de Codigo
        AREA    |.text|, CODE, READONLY, ALIGN=2

        EXPORT  create_table
        EXPORT  multi_table

create_table:
    LDR     R3, =MULTI_HEAD
    MOV     R1, #9
    MOV     R2, #0

store_loop:
    STRB    R2, [R3], #1
    SUBS    R1, R1, #1
    BNE     store_loop
    bx      LR
        
; R0: Número a alterar o fator multiplicativo
; R1: Retorna o fator multiplicativo atualizado do número


multi_table:
    LDR     R3, =MULTI_HEAD
    MULS    R0, R0, #4
    LDRB    R0, [R3, R0]
    ADDS    R0, R0, #1
    STRB    R0, [R3] ; TODO: Verificar o offset

    LDR     R1, [R3]
    bx      LR

        END