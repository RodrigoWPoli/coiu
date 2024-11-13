; -------------------------------------------------------------------------------
        THUMB                        ; InstruÃ§Ãµes do tipo Thumb-2
; -------------------------------------------------------------------------------


; -------------------------------------------------------------------------------
; Ãrea de CÃ³digo - Tudo abaixo da diretiva a seguir serÃ¡ armazenado na memÃ³ria de 
;                  cÃ³digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma funÃ§Ã£o do arquivo for chamada em outro arquivo	
        EXPORT DefineLedA
        EXPORT DefineLedB
        EXPORT DefineLedC
        EXPORT DefineLedD
        EXPORT DefineLedE
        EXPORT DefineLedF
        EXPORT DefineLedG

DefineLedA
; Define o led (a) do display       ; MNOP
    PUSH {R0}
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
	
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 4 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0x4                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedA


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0x1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedA
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedA
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0x4                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedA

SetaLedA
    IT EQ
    ANDEQ R5, R5, #2_11111110                  ; Se for igual, seta o bit para ligar o led (a)
    
    POP {R0}
    BX LR

DefineLedB
; Define o led (b) do display       ; MNOP
    PUSH {R0}
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedB


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1011
    BEQ SetaLedB
    

    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0x1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_0111
    BEQ SetaLedB
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0x1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1101
    BEQ SetaLedB

SetaLedB
    IT EQ
    ANDEQ R5, R5, #2_11111101                 ; Se for igual, seta o bit para ligar o led (b)

    POP {R0}
    BX LR

DefineLedC
; Define o led (c) do display       ; MNOP
    PUSH {R0}
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1110
    BEQ SetaLedC


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0x1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1101
    BEQ SetaLedC
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #0 

    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0x4                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0x1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedC

SetaLedC
    IT EQ
    ANDEQ R5, R5, #2_11111011                ; Se for igual, seta o bit para ligar o led (c)

    POP {R0}
    BX LR

DefineLedD
; Define o led (d) do display       ; MNOP
    PUSH {R0}
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 4 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0x4                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedD


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0x1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedD
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 

    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0x4                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0x1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedD


    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_0111
    BEQ SetaLedD

SetaLedD
    IT EQ
    ANDEQ R5, R5, #2_11110111               ; Se for igual, seta o bit para ligar o led (d)

    POP {R0}
    BX LR

DefineLedE
; Define o led (e) do display       ; MNOP
    PUSH {R0}
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x4                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x4                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_0111
    BEQ SetaLedE


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1110
    BEQ SetaLedE
    

    AND R1, R0, #0x8                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1001
    BEQ SetaLedE

SetaLedE
    IT EQ
    ANDEQ R5, R5, #2_11101111              ; Se for igual, seta o bit para ligar o led (e)

    POP {R0}
    BX LR

DefineLedF
; Define o led (f) do display       ; MNOP
    PUSH {R0}
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedF


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0x4                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1101
    BEQ SetaLedF
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1011
    BEQ SetaLedF
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0x4                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1110
    BEQ SetaLedF

SetaLedF
    IT EQ
    ANDEQ R5, R5, #2_11011111             ; Se for igual, seta o bit para ligar o led (f)

    POP {R0}
    BX LR

DefineLedG
; Define o led (g) do display       ; MNOP
    PUSH {R0}
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0x1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedG


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1111
    BEQ SetaLedG
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0x8                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    EOR R2, R3, #0                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0x4                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0x2                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    EOR R2, R3, R2                      ; 
    
    CMP R2, #2_1110
    BEQ SetaLedG

SetaLedG
    IT EQ
    ANDEQ R5, R5, #2_10111111            ; Se for igual, seta o bit para ligar o led (a)

    POP {R0}
    BX LR

;
    ALIGN                           ; garante que o fim da seï¿½ï¿½o estï¿½ alinhada 
    END          