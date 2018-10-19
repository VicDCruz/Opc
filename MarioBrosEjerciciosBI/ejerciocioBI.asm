TITLE *MASM Template	(CodigoBase.asm)*

; Descripción general:
; 

; Última fecha de modificación:
; 

; Librerías 
INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaración de datos
n byte ?
temperaturas dword ?
i byte 0
menorTemp dword 0
iMenor byte 0
paridad byte ?

msjInicio byte "Dato n: ", 0
msjMinIni byte "Minimo de las temperaturas: ", 0
msjMinFin byte "en: ", 0

msjRevesInicio byte "Temperatura ", 0
msjRevesMitad byte ": ", 0
msjRevesFin byte ", ", 0

msjAdios byte "ADIOS.", 0

msjErrorGetN byte "Numero fuera de rango [1, 10], re-introduce N", 0

.CODE
; Procedimiento principal
main PROC

    ; Obtener el dato N
    getN:
        mov EDX, offset msjInicio
        call WriteString
        call ReadInt
        ; mov n, EAX
        .IF EAX < 1 || EAX > 10
            mov EDX, offset msjErrorGetN
            call WriteString
            call CrLf
            JMP getN
        .ENDIF
            JMP getTemperaturas
    getTemperaturas:
        ; MARIO
    printMenorTemp:
        ; MARIO
    printTempInv:
        mov ESI, LENGTHOF temperaturas
        mov EAX, ESI
        call WriteInt
        dec ESI
        .WHILE ESI >= 0
            mov EBX, temperaturas[ESI*TYPE temperaturas]
            test BL, 00000001b
            .IF PARITY?
                mov paridad, "I"
            .ELSE
                mov paridad, "P"
            .ENDIF
            dec ESI
            mov EDX, OFFSET msjRevesInicio
            call WriteString
            mov EAX, ESI
            inc EAX
            call WriteInt
            mov EDX, OFFSET msjRevesMitad
            call WriteString
            mov EAX, temperaturas[ESI*TYPE temperaturas]
            call WriteInt
            mov EDX, OFFSET msjRevesFin
            call WriteString
            mov EDX, OFFSET paridad
            call WriteString
            call CrLf
        .ENDW
    fin:
        mov EDX, OFFSET msjAdios
        call WriteString
        call CrLf


exit  
main ENDP
; Termina el procedimiento principal

END main
; Termina el área de Ensamble
