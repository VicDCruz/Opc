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
    sum REAL8 0.0
    cont REAL8 1.0
    increment REAL8 1.0

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
exit  
main ENDP
; Termina el procedimiento principal

funcSer PROC
    push EBP

    mov EBP, ESP
    add EBP, 8
    mov EBX, 1
    inc DWORD PTR [EBP]
    .WHILE EBX < DWORD PTR [EBP]
        fld cont
        fdiv 
        call ShowFPUStack
        fadd sum
        fchs
        fstp sum
        fld x
        fld cont
        fadd increment
        fstp cont
        inc EBX
    .ENDW

    fld sum
    pop EBP
    ret
funcSer ENDP

END main
; Termina el área de Ensamble
