TITLE *MASM Template	(funcSer.asm)*

; Descripcion general:
; Tarea funcSer

; Librerias 
INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaracion de datos
    x REAL8 0.0
    sign REAL8 1.0
    cont DWORD ?

    messageGetN BYTE "Valor de N: ", 0
    messageGetX BYTE "Valor de X: ", 0
    messageBye BYTE "ADIOS.", 0

.CODE
; Procedimiento principal
main PROC
    finit

    mov EDX, OFFSET messageGetN
    call WriteString
    call ReadInt
    push EAX

    mov EDX, OFFSET messageGetX
    call WriteString
    call ReadFloat
    fst x

    call funcSer
    call WriteFloat
    call CrLf

    mov EDX, OFFSET messageBye
    call WriteString
exit  
main ENDP
; Termina el procedimiento principal

funcSer PROC
    push EBP
    mov EBP, ESP

    mov EBX, 1
    .WHILE EBX < [EBP + 8]
        inc EBX
        mov cont, EBX
        fld x
        fidiv cont
        fld sign
        fchs
        fst sign
        fmul
        fadd
    .ENDW

    pop EBP
    ret
funcSer ENDP

END main
; Termina el área de Ensamble
