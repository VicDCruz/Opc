TITLE Program Template          (.asm)

; Este programa llama un procedimiento con pasaje por stack.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

;SIMBOLOS
mcr=0dh
mlf=0ah
mnul=0h

.DATA
; PROC main
arrayi SDWORD 40h, 20h, 30h, 50h, 10h
nuni DWORD LENGTHOF arrayi
suma SDWORD ?
arrayr SDWORD 5 DUP(?)

txti BYTE mcr,mlf,"DumpMem de arrayi.",mnul
txtr BYTE mcr,mlf,"DumpMem de arrayr.",mnul
txts BYTE mcr,mlf,"Suma de elementos de arrayi = ",mnul
adios BYTE mcr,mlf,"ADIOS.",mnul

; PROC sycArrdw, variables locales
arr1d DWORD ?
unidades DWORD ?
arr2d DWORD ?
dirRet DWORD ?

.CODE
main PROC

    ; call sycArrdw(arrayi, nuni, arrayr)
    push OFFSET arrayi
    push nuni
    push OFFSET arrayr
    call sycArrdw
    pop suma

    ; Despliega un dump de memoria de arrayi.
	mov edx, OFFSET txti
	call WriteString
            mov ESI, OFFSET arrayi
            mov ECX, nuni
            mov EBX, TYPE arrayi
            call DumpMem
	call Crlf

    ; Despliega un dump de memoria de arrayi.
	mov edx, OFFSET txtr
	call WriteString
            mov ESI, OFFSET arrayr
            mov ECX, nuni
            mov EBX, TYPE arrayr
            call DumpMem
	call Crlf

    mov edx, OFFSET txts
	call WriteString
    mov EAX, suma
    call WriteHex
	call Crlf

	mov edx, OFFSET adios
	call WriteString
	call Crlf

	exit
main ENDP

sycArrdw PROC
; sycArrdw(arr1, unidades, arr2)
; Copia un arreglo dw en otro, restandole 30h a cada elemento del segundo arreglo,
; ademas suma todos los elementos del primer arreglo.
; Recibe
;     Stack: arr1d, unidades, arr2d
; Regresa
;     Stack: suma de los elementos del primer arreglo	
; Varibles automaticas y locales

;	Argumentos o parametros pasados
    pop dirRet
    pop arr2d
    pop unidades
    pop arr1d

    mov EAX, 0 ; acumulador
    mov EBX, 0 ; variable de control
    mov ESI, arr1d
    mov EDI, arr2d

	.WHILE ebx < unidades
        mov ECX, [ESI] ; arr1d
        add EAX, ECX ; acumulando
        sub ECX, 30h
        mov [EDI], ECX ; arr2d
        inc EBX
        add ESI, TYPE SDWORD
        add EDI, TYPE SDWORD
	.ENDW

    push EAX ; suma
    push dirRet
	
	ret
sycArrdw ENDP

END main