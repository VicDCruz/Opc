TITLE *MASM Template	(ex1.asm)*

; Descripcion:
; Ejercio: R = -A + 9 - B + D + 1
;

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
A sdword 7
B sdword ?
D sdword -15
R sdword ?
dato byte "Dato:", 0
res byte "El Resultado R=", 0
resH byte "El Resultado Rh=", 0
fin byte "Hasta la vista", 0

.CODE
; Procedimiento principal
main PROC
    mov EDX, OFFSET dato
    call WriteString
    
    call ReadInt
    mov B, EAX
    call CrLf

    neg EAX
    inc EAX
    add EAX, 9
    add EAX, D
    sub EAX, A
    mov R, EAX 

    mov EDX, OFFSET res
    call WriteString
    call WriteInt
    call CrLf
    call CrLf


    mov EDX, OFFSET resH
    call WriteString
    call WriteHex
    call CrLf

    mov  esi, OFFSET A  : Desde donde empezar
    mov  ecx, 4         ; Cuantos quiero imprimir
    mov  ebx, TYPE A    ; De cuanto en cuanto brincarse
    call DumpMem
    call CrLf

    mov EDX, OFFSET fin
    call WriteString
    call CrLf

    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main
