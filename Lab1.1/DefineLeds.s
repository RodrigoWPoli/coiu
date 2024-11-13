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
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    MOV R4, R2                          ; Salva o valor de R2 em R4


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2

    CMP R4, #1                          ; Compara o valor de R4 com 1
    IT EQ
    ORREQ R5, R5, #0x1                  ; Se for igual, seta o bit para ligar o led (a)

    BX LR

DefineLedB
; Define o led (b) do display       ; MNOP
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    MOV R4, R2                          ; Salva o valor de R2 em R4


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2

    CMP R4, #1                          ; Compara o valor de R4 com 1
    IT EQ
    ORREQ R5, R5, #0x10                 ; Se for igual, seta o bit para ligar o led (b)

    BX LR

DefineLedC
; Define o led (c) do display       ; MNOP
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    MOV R4, R2                          ; Salva o valor de R2 em R4


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1 

    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2

    CMP R4, #1                          ; Compara o valor de R4 com 1
    IT EQ
    ORREQ R5, R5, #0x100                ; Se for igual, seta o bit para ligar o led (c)

    BX LR

DefineLedD
; Define o led (d) do display       ; MNOP
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    MOV R4, R2                          ; Salva o valor de R2 em R4


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1 

    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2


    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2

    CMP R4, #1                          ; Compara o valor de R4 com 1
    IT EQ
    ORREQ R5, R5, #0x100                ; Se for igual, seta o bit para ligar o led (d)


    BX LR

DefineLedE
; Define o led (e) do display       ; MNOP
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x4                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 3 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    MOV R4, R2                          ; Salva o valor de R2 em R4


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 1 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x8                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2

    CMP R4, #1                          ; Compara o valor de R4 com 1
    IT EQ
    ORREQ R5, R5, #0x100                ; Se for igual, seta o bit para ligar o led (e)


    BX LR

DefineLedF
; Define o led (f) do display       ; MNOP
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    MOV R4, R2                          ; Salva o valor de R2 em R4


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2

    CMP R4, #1                          ; Compara o valor de R4 com 1
    IT EQ
    ORREQ R5, R5, #0x1                  ; Se for igual, seta o bit para ligar o led (f)


    BX LR

DefineLedG
; Define o led (g) do display       ; MNOP
    AND R0, R0, #0xF                    ; Filtra os LSB de R0
    
    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    MOV R4, R2                          ; Salva o valor de R2 em R4


    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x1                    ; Filtra o bit 1 de R0
    EOR R3, R1, #0                      ; Comparação para saber se o bit 4 é 1 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2
    

    AND R1, R0, #0x8                    ; Filtra o bit 4 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 1 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x4                    ; Filtra o bit 3 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 2 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    
    AND R1, R0, #0x2                    ; Filtra o bit 2 de R0
    EOR R3, R1, #1                      ; Comparação para saber se o bit 3 é 0 (lógica negada)
    AND R2, R3, #1                      ; 
    ORR R4, R4, R2                      ; Faz o OR de R4 com R2

    CMP R4, #1                          ; Compara o valor de R4 com 1
    IT EQ
    ORREQ R5, R5, #0x1                  ; Se for igual, seta o bit para ligar o led (a)

    BX LR

;
    ALIGN                           ; garante que o fim da seï¿½ï¿½o estï¿½ alinhada 
    END          