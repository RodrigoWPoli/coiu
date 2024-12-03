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

create_table
    LDR     R3, =MULTI_HEAD
    MOV     R1, #9
    MOV     R2, #9

store_loop
    STRB    R2, [R3], #1
    SUBS    R1, R1, #1
    CMP     R1, #1
    BNE     store_loop
    BX      LR

        
; input R1 -> Numero a alterar o fator multiplicativo
; Saida: R2 -> Retorna o fator multiplicativo atualizado do numero


multi_table
    LDR     R3, =MULTI_HEAD
    MOV     R4, #4
    ;MULS    R1, R4
    LDRB    R2, [R3, R1]
    CMP     R2, #9
    ITE    EQ
        MOVEQ     R2, #0
        ADDSNE    R2, R2, #1
    STRB    R2, [R3, R1]
    BX      LR 


    ALIGN
    END