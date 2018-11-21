TITLE *MASM Template	(Ejer3.asm)*

; Descripcion general:
; Tarea Ejer3

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
number DWORD ?

messageGetNumber BYTE "Entero de 32 bits: ", 0
messageHex BYTE "El equivalente HEX a 32 bits es: ", 0
messageBye BYTE "ADIOS.", 0

numberStr BYTE 8 DUP(?), 0
numberToHex BYTE 8 DUP(?), 0

.CODE
; Procedimiento principal
main PROC
    mov EDX, OFFSET messageGetNumber
    call WriteString
    call ReadInt
    mov number, EAX

    mov EDX, OFFSET messageHex
    call WriteString
    push OFFSET number
    call toHex
    pop EDX
    call WriteString
    call CrLf

    mov EDX, OFFSET messageBye
    call WriteString
exit  
main ENDP
; Termina el procedimiento principal

toHex PROC
; toHex(dirNumber): numberToHex
; Recibe:
;   Stack: la dirección del número entero de 32 bits a convertir
;           en hexadecimal
; Regresa:
;   Stack: numberToHex, el string con la representación del entero en
;           hexadecimal.
; Variables automáticas y locales
    pop dirTmp
    pop ESI
    mov EBX, 0
    .WHILE EBX < 8
        mov EAX, 0
        mov ECX, 0
        mov ECX, DWORD PTR [ESI]
        shld EAX, ECX, 4
        mov numberToHex[EBX], AL
        .IF AL <= 9
            add numberToHex[EBX], 48
        .ELSE
            add numberToHex[EBX], 65
            sub numberToHex[EBX], 10
        .ENDIF
        mov EAX, 0
        shld EAX, ECX, 8
        and AL, 00001111b
        mov numberToHex[EBX + 1], AL
        .IF AL <= 9
            add numberToHex[EBX + 1], 48
        .ELSE
            add numberToHex[EBX + 1], 65
            sub numberToHex[EBX + 1], 10
        .ENDIF
        dec ESI
        add EBX, 2
    .ENDW
    push OFFSET numberToHex
    push dirTmp
    ret
toHex ENDP

END main
; Termina el área de Ensamble
