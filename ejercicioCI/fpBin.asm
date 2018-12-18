TITLE *MASM Template	(fpBin.asm)*

; Descripcion general:
; Tarea ejercicioCI

; Fecha de modificacion:
; 17/12/18

; Librerias 
INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaracion de datos
    num REAL4 -1.75
    stringSign BYTE "+1."
    stringDecimal BYTE 23 DUP('0')
    stringExponent BYTE " E", 0
    exponent DWORD 0
.CODE
; Procedimiento principal
main PROC
    finit
    getSign:
        mov EAX, num
        shl EAX, 1
        .IF CARRY?
            mov stringSign, '-'
        .ENDIF

    getExponent:
        shld exponent, EAX, 8
        shl EAX, 8
        sub exponent, 127 ; Exponente
        
    getDecimal:
        mov EBX, 0
        .WHILE EBX < 23
            shl EAX, 1
            .IF CARRY?
                mov stringDecimal[EBX], "1"
            .ENDIF
            inc EBX
        .ENDW

    mov EDX, OFFSET stringSign
    call WriteString
    mov EAX, exponent
    call WriteInt
exit  
main ENDP
; Termina el procedimiento principal
END main
; Termina el área de Ensamble
