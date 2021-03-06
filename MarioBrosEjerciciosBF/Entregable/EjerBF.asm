TITLE *MASM Template	(ejerBF.asm)*

; Uso de instrucciones, Directivas data y operadores.

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
val3	BYTE 32
val4	WORD 400

arrB	BYTE  10h,20h,30h, 40h, 50h
arrW	WORD  100h,200h,300h

arrSW	SWORD  -140,200,-300
arrSD	SDWORD 11000h, 22000h

array1	WORD 2, 4, 6
rever1	DWORD 3 DUP(?)

resStr 	BYTE "Suma de (1): ", 0
resBefore BYTE "(2) Antes del intercambio", 0
resAfter BYTE "(2) Despues del intercambio", 0

.CODE
main PROC
; Pte. 1
	mov EAX, 0 ; EAX = 0
	mov AL, val3 ; EAX = val3
	add AX, val4 ; EAX += val4
	add AX, [arrSW + 4] ; EAX += [arrSW + 2]
	add EAX, [arrSD + 4] ; EAX += [arrSD + 1]

	mov EDX, OFFSET resStr
    call WriteString
	call WriteInt
	call CrLf
	call CrLf

; Pte. 2
	mov  edx, OFFSET resBefore
	call WriteString
	call CrLf
	mov  esi, OFFSET arrW  ; Desde donde empezar
    mov  ecx, 6         ; Cuantos quiero imprimir
    mov  ebx, TYPE arrW    ; De cuanto en cuanto brincarse
    call DumpMem
    call CrLf

	mov ebx, SDWORD PTR [arrW]
	xchg ebx, SDWORD PTR [arrSW]
	xchg ebx, DWORD PTR [arrW]

	mov bx, [arrW + 4]
	xchg bx, [arrSW + 4]
	xchg bx, [arrW + 4]

	mov  edx, OFFSET resAfter
	call WriteString
	call CrLf
	mov  esi, OFFSET arrW  ; Desde donde empezar
    mov  ecx, 6         ; Cuantos quiero imprimir
    mov  ebx, TYPE arrW    ; De cuanto en cuanto brincarse
    call DumpMem
    call CrLf

	exit
main ENDP
END main