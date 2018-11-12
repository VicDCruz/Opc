TITLE SgExm18.asm

; Esqueleto para el segundo examen.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; DATA del procedimiento "main"
arrInd DWORD 7, 2, 8, 11
       DWORD 14, 3, 10, 6, 0
       DWORD 16, 9, 1, 4, 5
totInd SDWORD ?
arrPot DWORD 1000, 2000, 3000, 4000
       DWORD 5000, 0, 12000, 11000
       DWORD 10000, 9000, 8000, 7000
totPot SDWORD ?

; DATA del procedimiento "ID"
textoID BYTE "Soy 157948VictorC", 0

; DATA del CtaElemArrD
countVect SDWORD 0
topVect DWORD 0

; DATA del ImprimirArrD
count1 SDWORD 0
count2 SDWORD 0
elem1 DWORD 0
dirVect2 DWORD 0
messageImpBegin BYTE "Posicion ", 0
messageImpEnd BYTE " con valor: ", 0
lenType DWORD 4

dirProc DWORD ?
bye BYTE "HASTA LUEGO.", 0

messageImpInd BYTE "Total de indices: ", 0
messageImpPot BYTE "Total de potencias: ", 0

.CODE
main PROC

    call ID
    call CrLF

    mov totInd, -1
    PUSH OFFSET arrInd
    call CtaElemArrD
    POP totInd

    mov totPot, -1
    PUSH OFFSET arrpot
    call CtaElemArrD
    POP totPot

    mov EDX, OFFSET messageImpInd
    call WriteString
    mov EAX, totInd
    call WriteInt
    call CrLF

    mov EDX, OFFSET messageImpPot
    call WriteString
    mov EAX, totPot
    call WriteInt
    call CrLF
    call CrLF


    PUSH OFFSET arrInd
    PUSH OFFSET arrPot
    PUSH totInd
    PUSH totPot
    call ImprimirArrD

    call CrLF
    mov EDX, OFFSET bye
    call WriteString
    
    EXIT
main ENDP

; Procedimiento para imprimir mi ID
; No hay argumentos. El string es local.
; No hay resultado a regresar.
ID PROC
    call CrLF
    mov EDX, oFFSET textoID
    call WriteString
    call CrLF
    RET
ID ENDP

; Procedimiento para contar el número de elementos de un vector
; Argumentos: Dirección del incio del vector.
; Resultado: La cuenta del número de elementos.
CtaElemArrD PROC
    POP dirProc
    POP EDI ; Contiene la direccion del vect[0]

    mov countVect, 0
    mov EAX, [EDI]
    mov topVect, -1
    .WHILE SDWORD PTR EAX > topVect
        INC countVect
        add EDI, TYPE EAX
        mov EAX, [EDI]
    .ENDW

    PUSH countVect
    PUSH dirProc
    ret
CtaElemArrD ENDP

ImprimirArrD PROC
    POP dirProc
    POP count2
    POP count1
    POP dirVect2
    POP EDI

    mov EBX, 0
    mov elem1, 0
    .WHILE SDWORD PTR EBX < count1
        mov EDX, [EDI]
        mov elem1, EDX
        .IF SDWORD PTR EDX < count2
            mov ESI, dirVect2
            mov EAX, elem1
            mul lenType
            add ESI, EAX
            mov EDX, OFFSET messageImpBegin
            call WriteString
            mov EAX, elem1
            call WriteInt
            mov EDX, OFFSET messageImpEnd
            call WriteString
            mov EAX, DWORD PTR [ESI]
            call WriteInt
            call CrLF
        .ENDIF
        add EDI, TYPE EAX
        inc EBX
    .ENDW

    PUSH dirProc
    ret
ImprimirArrD ENDP

END main