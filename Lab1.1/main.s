; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Jhony Minetto Araújo, Ricardo Marthus Gremmelmaier, Rodrigo Wolsky Poli
; Última atualização: 11/11/2024
; Este programa deve esperar o usu�rio pressionar uma chave.
; Caso o usuário pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; Definições de Valores


; -------------------------------------------------------------------------------
; �rea de Dados - Declarações de vari�veis
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
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT  GPIO_Init
        IMPORT  Led_Output
		IMPORT  Switch_Input
		IMPORT  Display_Output
; -------------------------------------------------------------------------------
; Função main()
Start  
; Comece o código aqui <======================================================
    
    BL PLL_Init                     ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init                 ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init   	;Chama a subrotina que inicializa os GPIO
	
	MOV R1, #2_1
	MOV R0, #2_00000000
TestaDisplay	 
	BL Display_Output
	ADD R0, R1
	CMP R0, #99
	BEQ Acabou
	B TestaDisplay
; R0 -> Contador
; R3 -> Leitura da Switch
; R8 -> Valor da Switch anterior
; R9 -> Passo a ser incrementado no contador
; R2 -> Quantidade de ticks de ms
Acabou
	MOV R0, #0 						; Contador iniciando em 0
	MOV R2, #500                    ; Tempo para trocar o contador
	MOV R9, #1						; Passo iniciando em 0
	MOV R8, #2_11					; Inicia com as duas switches inativas

MainLoop
	BL Led_Output					; Grava na placa os Leds
;	BL Display_Output				; Grava na placa os displays
;	BL PrintValue					; Chamada pra mostrar os displays e leds
	BL Switch_Input					; Chamada pra ler o switch
	PUSH {R3}						; Salvar o valor da switch
CounterLoop
	CMP R3, #2_11					; Se nenhum switch for ativo, apenas incrementa ou decrementa o contador
	BNE Step_handler
	ADD R0, R9						; Incrementa o contador
	CMP R0, #0						; Compara para ver se nao ficou abaixo de zero
	BLT CheckUnderflow
	CMP R0, #99						; Compara para ver se nao ficou acima de 100
	BGT CheckOverflow

	B MainLoop

Step_handler
	CMP R3, #2_10					; Se tiver SW1 ativa, incrementa o passo ou decrementa
	BNE Neg_handler
	
	TST R8, #1						; Se o ultimo bit era 0, volta para o loop
	BEQ MainLoop					; Se nao, pode continuar
	
	CMP R9, #0 						; Verifica se é negativo e se for, decrementa o passo
	BMI DecrementStep
	B	IncrementStep				; Se nao for, incrementa o passo

Neg_handler
	CMP R3, #2_01					; Se tiver SW2 ativa, inverte o contador negativando o passo
	BNE Both_handler

	TST R8, #2						; Se o penúltimo bit era 0, volta para o loop
	BEQ MainLoop					; Se nao, pode continuar

	TST R8, #2_00					; Se o penultimo bit era 0, volta para o loop
	NEG R9, R9						; Negativa o passo
	POP {R8}						; Atualizo valor salvo da switch
	B MainLoop

Both_handler
	CMP R3, #2_00					; Se as duas SW forem ativas, realiza as duas ações
	BNE MainLoop

	TST R8, #3						; Se os ultimos 2 bits eram 0, volta para o loop
	BEQ MainLoop					; Se nao, pode continuar

	NEG R9, R9						; Negativa o valor
	CMP R9, #0 						; Verifica se é negativo e se for, decrementa o passo
	BMI DecrementStep
	B	IncrementStep				; Se nao for, incrementa o passo

CheckUnderflow
	MOV R0, #99
	B MainLoop

CheckOverflow
	MOV R0, #0
	B MainLoop
	
IncrementStep
	CMP R9, #9						; Compara se o passo está no limite superior (9)					
	ITE LT
	ADDLT R9, #1					; Caso seja menor que 9, adiciona 1
	MOVGE R9, #1					; Caso seja 9 ou maior, seta para 1
	POP {R8}						; Atualizo valor salvo da switch
	B MainLoop

DecrementStep
	NEG R9, R9						; Torna o valor positivo
	CMP R9, #1						; Compara se o passo está no limite inferior (1)
	ITE GT
	SUBGT R9, #1					; Caso seja maior que 1, reduz 1
	MOVLE R9, #9					; Caso seja igual ou menor a 1, seta para 9
	NEG R9, R9						; Torna o valor negativo novamente
	POP {R8}						; Atualizo valor salvo da switch
	B MainLoop
	
PrintValue
	PUSH {LR}						; Salva o Link Register
	BL Led_Output					; Grava na placa os Leds
	BL Display_Output				; Grava na placa os displays
	POP {LR}						; Volta o Link Register
	BX  LR
; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se��o est� alinhada 
    END                          ;Fim do arquivo
