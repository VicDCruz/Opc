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
; printBinary(n, dirNumber): void
; Desplegar los 'N' numeros que se requirieron al principio del programa
; con o sin modificación en memoria
; Recibe
;   Stack: n y offset de number
; Variables automáticas y locales
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
; getN(dirMessage, dirN): void
; Obtener el valor de 'n' dado por el usuario e insertarlo en la
; dirección de memoria de 'n'
; Recibe
;   Stack: dirección de memoria de donde está el mensaje para pedir
;           el valor de n y dirN implica la dirección en memoria donde
;           se almacenará el valor de 'N'
; Variables automáticas y locales
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
; shiftNumber(n, dirShift, dirNumber): void
; Hacer una rotación bit a bit del arreglo de los números DWORD, hasta
; cumplir con el número de cambios dado por el usuario (shift)
; Recibe
;   Stack: n, la cantidad de números que se recibieron por el usuario
;           la dirección en memoria de el número de cambios que iba a
;           sufrir el número, hacia la derecha y la dirección del
;           conjunto del arreglo de números DWORD
; Variables automáticas y locales
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
