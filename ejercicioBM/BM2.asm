TITLE *MASM Template	(ejercicioBI.asm)*

; Descripcion general:
; Tarea ejercicioBI

; Ultima fecha de modificacion:
; 20/10/18

; Libreri?as 
INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaracion de datos
n dword 0
nNueva byte 0
temperaturas dword 00,00,00,00,00,00,00,00,00
i byte 0
j byte 0
menorTemp dword 0
iMenor byte 0
paridad byte ?, 0

msjInicio byte "Dato n: ", 0
msjMinIni byte "Minimo de las temperaturas: ", 0
msjMinFin byte "en: ", 0
msjTecleeTemp1 byte "Teclee la ", 0
msjTecleeTemp2 byte " temperatura: ", 0

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
        
        .IF EAX < 1 || EAX > 10
            mov EDX, offset msjErrorGetN
            call WriteString
            call CrLf
            JMP getN
        .ENDIF
        
        mov n, EAX
        MOV EBX, n
        MOV EAX, 0
        MOV ECX, 0
        MOV EDI,0
        JMP getTemperaturas
        call CrLf
        
    getTemperaturas:
        mov EDX, OFFSET msjTecleeTemp1
        call WriteString 
        INC ECX
        mov EAX, ECX
        call WriteInt
        mov EDX, OFFSET msjTecleeTemp2
        call WriteString
        call ReadInt
        mov temperaturas[EDI*TYPE temperaturas], EAX
        INC EDI
        DEC EBX
     JNZ getTemperaturas
        
        mov EDX, 0
        mov ECX, n
        MOV EDI, 0
        JMP printMenorTemp
        mov EAX, menorTemp
        
    printMenorTemp:
        .WHILE EDX < ECX
            mov EBX, temperaturas[EDI*TYPE temperaturas]
            sub EBX, EAX
            .IF SIGN?
                mov EAX, temperaturas[EDI*TYPE temperaturas]
                mov menorTemp, EAX
            .ENDIF
            
            INC EDI
            INC EDX
            
        .ENDW

        Call CrLf
        mov EDX, OFFSET msjMinIni
        call WriteString
        mov EAX, menorTemp
        call WriteInt
        
        Call CrLf
    printTempInv:
        mov al, BYTE PTR n
        mov nNueva, al
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        call WriteInt
        .WHILE BL < nNueva
            mov DL, BL
            inc DL
            .WHILE DL < nNueva
                mov EAX, temperaturas[EBX*TYPE temperaturas]
                .IF EAX > temperaturas[EDX*TYPE temperaturas]
                    XCHG EAX, temperaturas[EDX*TYPE temperaturas]
                    mov temperaturas[EBX*TYPE temperaturas], EAX
                .ENDIF
                inc DL
            .ENDW
            inc BL
        .ENDW

        mov EBX, 0
        .WHILE BL < nNueva
            mov ECX, temperaturas[EBX*TYPE temperaturas]
            test CL, 1
            .IF PARITY?
                mov paridad, "P"
            .ELSE
                mov paridad, "I"
            .ENDIF
            inc BL

            mov EDX, OFFSET msjRevesInicio
            call WriteString
            mov EAX, EBX
            call WriteInt
            mov EDX, OFFSET msjRevesMitad
            call WriteString
            mov EAX, ECX
            call WriteInt
            mov EDX, OFFSET msjRevesFin
            call WriteString
            mov EDX, OFFSET paridad
            call WriteString
            call CrLf
        .ENDW
        call CrLf
    fin:
        mov EDX, OFFSET msjAdios
        call WriteString
        call CrLf


exit  
main ENDP
; Termina el procedimiento principal

END main
; Termina el ?rea de Ensamble