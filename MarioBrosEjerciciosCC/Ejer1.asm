TITLE *MASM Template	(MultiShf.asm)*

; Descripcion general:
; Tarea MultiShf

; Fecha de modificacion:
; 20/10/18

; Librerias 
INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaracion de datos
dirTmp DWORD ?

n DWORD ?
number DWORD 4 DUP(?)
shift DWORD ?

messageBegin BYTE "DWORD ", 0
messageEnd BYTE ": ", 0
messageN BYTE "N: ", 0
messageBits BYTE "Bits a desplazar: ", 0
messageAntes BYTE "Antes", 0
messageDespues BYTE "Despues", 0
messageFin BYTE "ADIOS.", 0

.CODE
; Procedimiento principal
main PROC
    push OFFSET messageN
    push OFFSET n
    call getN

    mov EBX, 0
    .WHILE EBX < n
        mov EDX, OFFSET messageBegin
        call WriteString
        mov EAX, EBX
        inc EAX
        call WriteInt
        mov EDX, OFFSET messageEnd
        call WriteString
        call ReadInt
        mov number[EBX * TYPE number], EAX
        inc EBX
    .ENDW

    mov EAX, 0
    .WHILE (EAX < 1) || (EAX > 4)
        mov EDX, OFFSET messageBits
        call WriteString
        call ReadInt
        mov shift, EAX
    .ENDW

    mov EDX, OFFSET messageAntes
    call WriteString
    call CrLf
    push n
    push OFFSET number
    call printBinary

    push n
    push OFFSET shift
    push OFFSET number
    call shiftNumber

    mov EDX, OFFSET messageDespues
    call WriteString
    call CrLf
    push n
    push OFFSET number
    call printBinary

    mov EDX, OFFSET messageFin
    call WriteString
exit  
main ENDP
; Termina el procedimiento principal

printBinary PROC
    pop dirTmp
    pop ESI
    pop EBX
    dec EBX
    .WHILE SDWORD PTR EBX >= 0
        mov EAX, [ESI + EBX*TYPE ESI]
        call WriteBin
        dec EBX
    .ENDW
    call CrLf
    push dirTmp
    ret
printBinary ENDP

getN PROC
    pop dirTmp
    pop ESI
    pop EDI
    .WHILE (EAX < 2) || (EAX > 8)
        mov EDX, EDI
        call WriteString
        call ReadInt
        mov DWORD PTR [ESI], EAX
    .ENDW
    push dirTmp
    ret
getN ENDP

shiftNumber PROC
    pop dirTmp
    pop ESI
    pop EDX
    pop EAX
    mov EBX, 0
    .WHILE EBX < [EDX]
        mov ECX, EAX
        dec ECX
        shr DWORD PTR [ESI], 1
        .WHILE SDWORD PTR ECX >= 0
            rcr DWORD PTR [ESI + ECX*TYPE ESI], 1
            dec ECX
        .ENDW
        inc EBX
    .ENDW
    push dirTmp
    ret
shiftNumber ENDP

END main
; Termina el área de Ensamble
