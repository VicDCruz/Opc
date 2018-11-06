TITLE *MASM Template	(ejercicioBI.asm)*

; Descripcion general:
; Tarea ejercicioBI

; Fecha de modificacion:
; 20/10/18

; Librerias 
INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaracion de datos
n DWORD ?
nDiv DWORD ?
nTemp DWORD ?
messageGetN BYTE "Dato n: ", 0
messageWrongN BYTE "Ingresar n de [1, 10]", 0

temperatures SDWORD 10 DUP(?)
messageNextTempBegin BYTE "Ingresa la ", 0
messageNextTempEnd BYTE " temperatura: ", 0

dirMinTemperature SDWORD ?
messageMinTemperature BYTE "Minimo de las temperaturas: ", 0
messageDirMinTemperature BYTE "Dir. de Minimo de las temperaturas: ", 0

parityNum BYTE ?, 0
messageInverseTemperatureBegin BYTE "Temperatura ", 0
messageInverseTemperatureMiddle BYTE ": ", 0
messageInverseTemperatureEnd BYTE ", ", 0

dirRet DWORD ?
nVect DWORD ?
dirVect DWORD ?

goodbye BYTE "ADIOS", 0
.CODE
; Procedimiento principal
main PROC
    getN:
        mov EDX, OFFSET messageGetN
        call WriteString
        call ReadInt
        mov n, EAX
        .IF n < 1 || n > 10
            mov EDX, OFFSET messageWrongN
            call WriteString
            call CrLf
            JMP getN
        .ENDIF
        dec n
    setTemperatures:
        mov EBX, 0
        mov ESI, OFFSET temperatures
        .WHILE EBX <= n
            mov EDX, OFFSET messageNextTempBegin
            call WriteString
            mov EAX, EBX
            inc EAX
            call WriteInt
            mov EDX, OFFSET messageNextTempEnd
            call WriteString
            call ReadInt
            mov [ESI], EAX
            inc EBX
            add ESI, TYPE temperatures
        .ENDW
        call CrLf
    mov EDI, 0
    mov EAX, temperatures
    getMinTemperature:
        cmp EDI, n
        JAE printMinTemperature
        inc EDI
        cmp EAX, temperatures[EDI * TYPE temperatures]
        JLE getMinTemperature
        mov EAX, temperatures[EDI * TYPE temperatures]
        mov dirMinTemperature, EDI
        JMP getMinTemperature
    printMinTemperature:
        mov EDX, OFFSET messageMinTemperature
        call WriteString
        call WriteInt
        call CrLf
        mov EDX, OFFSET messageDirMinTemperature
        call WriteString
        mov EAX, dirMinTemperature
        inc EAX
        call WriteInt
        call CrLf
        call CrLf
    printInverseTemperature:
        PUSH OFFSET temperatures
        PUSH n
        call VecSelDir

        mov EBX, 0
        mov ESI, OFFSET temperatures
        .WHILE EBX <= n
            mov EAX, [ESI]
            test EAX, 1
            .IF PARITY?
                mov parityNum, "P"
            .ELSE
                mov parityNum, "I"
            .ENDIF
            mov EDX, OFFSET messageInverseTemperatureBegin
            call WriteString
            mov EAX, EBX
            inc EAX
            call WriteInt
            mov EDX, OFFSET messageInverseTemperatureMiddle
            call WriteString
            mov EAX, [ESI]
            call WriteInt
            mov EDX, OFFSET messageInverseTemperatureEnd
            call WriteString
            mov EDX, OFFSET parityNum
            call WriteString
            call CrLf
            inc EBX
            add ESI, TYPE temperatures
        .ENDW
        call CrLf
    mov EDX, OFFSET goodbye
    call WriteString
    
exit  
main ENDP
; Termina el procedimiento principal

VecSelDir PROC
    POP dirRet
    POP nVect
    POP dirVect

    mov EAX, dirVect
    mov EBX, nVect
    mov nTemp, EBX
    dec nTemp
    add nTemp, EAX
    add nVect, EAX
    .WHILE EAX <= nTemp
        mov EBX, EAX
        add EBX, 4
        .WHILE EBX <= nVect
            mov ECX, [EAX]
            .IF SDWORD PTR ECX > [EBX]
                XCHG ECX, [EBX]
                mov [EAX], ECX
            .ENDIF
            add EBX, 4
        .ENDW
        add EAX, 4
    .ENDW

    PUSH dirRet
    ret
VecSelDir ENDP

END main
; Termina el área de Ensamble
