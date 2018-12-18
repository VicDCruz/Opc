TITLE Examen Final, 1er ejercicio, AD2018.

; Crear e imprimir una nueva lista a partir de otra inicial existente en memoria.
; Last Update: 18dic2018

; Esqueleto para el examen final.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
list2i 	SDWORD 560, 450, 4 	;0-
		SDWORD 271, -105, 9 	;1-
		SDWORD 482, 3000, 8	;2-
		SDWORD 800, 4300, 5	;3-
		SDWORD 144, -310, 7 	;4-
		SDWORD 54, -900, -66 	;5 ultimo
		SDWORD 745, -1000, 2 	;6-
		SDWORD 342, 2000, 1 	;7-
		SDWORD 512, -700, 3	;8-
		SDWORD 637, 410, 6 	;9-
		
list2n 	SDWORD 20 DUP(-888) 	;0-9

; DATA del procedimiento "ID"
textoID BYTE "Soy VDCG157948", 0

; ONCE
indice SDWORD 0
limit SDWORD -66

; DOCE
messageHeader BYTE "IDentificador            Ganancia", 0
messageTab BYTE "	", 0

messageBze BYTE "ADIOS.", 0

.CODE
main PROC
	finit

	call ID

	push OFFSET list2n
	push OFFSET list2i
	call ONCE

	push OFFSET list2n
	call DOCE

	call CrLF
	mov EDX, OFFSET messageBze
	call WriteString

	exit
main ENDP

; Procedimiento para imprimir mi ID
; No hay argumentos. El string es local.
; No hay resultado a regresar.
ID PROC
    call CrLF
    mov EDX, OFFSET textoID
    call WriteString
    call CrLF
    RET
ID ENDP

ONCE PROC
	push EBP
	mov EBP, ESP
	mov ESI, DWORD PTR [EBP + 8] ; list2i
	mov EDI, DWORD PTR [EBP + 12] ; list2n
	mov indice, 0 ; Indice
	mov EBX, 0

	.WHILE SDWORD PTR EBX > limit
		mov EAX, indice
		cdq
		mov ECX, 12
		mul ECX
		mov indice, EAX

		add ESI, indice
		mov ECX, SDWORD PTR [ESI]
		mov SDWORD PTR [EDI], ECX

		add ESI, 4
		add EDI, 4
		mov ECX, SDWORD PTR [ESI]
		mov SDWORD PTR [EDI], ECX

		add ESI, 4
		mov ECX, SDWORD PTR [ESI]
		sub ESI, 8
		sub ESI, indice
		mov indice, ECX
		mov EBX, indice
		add EDI, 4
	.ENDW

	pop EBP
	ret 8
ONCE ENDP

DOCE PROC
	push EBP
	mov EBP, ESP
	mov ESI, DWORD PTR [EBP + 8] ; list2n

	mov EDX, OFFSET messageHeader
	call WriteString
	call CrLF

	mov EBX, 0
	.WHILE EBX < 10
		mov EDX, OFFSET messageTab
		call WriteString
		mov EAX, [ESI]
		call WriteInt
		mov EDX, OFFSET messageTab
		call WriteString
		mov EDX, OFFSET messageTab
		call WriteString
		fild SDWORD PTR [ESI + 4]
		call WriteFloat
		fistp SDWORD PTR [ESI + 4]
		call CrLF
		inc EBX
		add ESI, 8
	.ENDW

	pop EBP
	ret
DOCE ENDP
END main