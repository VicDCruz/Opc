TITLE *MASM Template	(fibonacci.asm)*

; Descripcion general:
; Tarea ejercicioCA

; Fecha de modIFicacion:
; 12/11/18

; Librerias 
INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaracion de datos
n DWORD 0
f1 DWORD 0
f2 DWORD 1

sumTot DWORD 0

messageBegin BYTE "ESCRIBE N > 0: ", 0
messageSumTot BYTE "Acumulado: ", 0

.CODE
    ; Procedimiento principal
main PROC

    mov EAX, 0
    .WHILE SDWORD PTR EAX <= 0
        mov EDX, OFFSET messageBegin
        call WriteString
        call ReadInt
    .ENDW
    mov n, EAX
    mov EBX, 1
    mov EAX, f1
    call WriteInt
    call CrLf
    mov EAX, f2
    call WriteInt
    call CrLf
    add sumTot, EAX
    .WHILE EBX <= n
        mov EAX, f1
        add EAX, f2
        call WriteInt
        call CrLf
        mov ECX, f2
        mov f1, ECX
        mov f2, EAX
        inc EBX
        add sumTot, EAX
    .ENDW
    mov EDX, OFFSET messageSumTot
    call WriteString
    mov EAX, sumTot
    call WriteInt
exit  
main ENDP
; Termina el procedimiento principal

END main
; Termina el área de Ensamble
