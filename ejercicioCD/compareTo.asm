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
string1 BYTE 20 DUP(?)
string2 BYTE 20 DUP(?)
length1 DWORD 0
length2 DWORD 0

messageEnd BYTE "ADIOS", 0

; PROC: compareTo
difPosition DWORD 0
; PROC: getN
messageGetString BYTE "Escribe la cadena ", 0
messageComplement BYTE ": ", 0
offsetStr DWORD ?
; GENERAL
dirTmp DWORD ?
.CODE
; Procedimiento principal
main PROC
    push OFFSET string1
    push 1
    call getString

    push OFFSET string2
    push 2
    call getString

    push OFFSET string1
    push OFFSET string2
    call compareTo
    pop EAX
    call WriteInt

exit  
main ENDP
; Termina el procedimiento principal

getString PROC
    pop dirTmp
    pop EAX
    pop offsetStr

    mov EDX, OFFSET messageGetString
    call WriteString
    call WriteInt
    mov EDX, OFFSET messageComplement
    call WriteString
    mov EDX, offsetStr
    mov ECX, 20
    call ReadString
    push EAX

    push dirTmp
    ret
getString ENDP

compareTo PROC
    pop dirTmp
    pop ESI ; OFFSET string2
    pop EDI ; OFFSET string1
    pop length2 ; del proc GETSTRING
    pop length1 ; del proc GETSTRING

    mov EAX, length2
    .IF length1 != EAX
        .IF length1 < EAX
            mov EBX, length1
        .ELSE
            mov EBX, EAX
        .ENDIF
        inc EBX
        push EBX
        push dirTmp
        ret
    .ENDIF

    mov EBX, 0
    mov ECX, 0
    .WHILE EBX < length1
        mov CH, BYTE PTR [EDI + EBX] ; string1
        mov CL, BYTE PTR [ESI + EBX] ; string2
        .IF CH != CL
            inc EBX
            .IF CH < CL
                neg EBX
            .ENDIF
            push EBX
            push dirTmp
            ret
        .ENDIF
        inc EBX
    .ENDW

    push 0
    push dirTmp
    ret
compareTo ENDP

END main
; Termina el área de Ensamble
