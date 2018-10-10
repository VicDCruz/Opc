TITLE *MASM Template	(ex1.asm)*

; Descripcion:
; Ejercio: ¡como Hola estan! -> ¡Hola como estan!
;

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
texto BYTE "!como Hola estan!", 0
adios BYTE "ADIOS", 0

.CODE
; Procedimiento principal
main PROC
    mov EDX, OFFSET texto
    call WriteString
    call CrLf

    mov EBX, DWORD PTR [texto + 6]
    xchg EBX, DWORD PTR [texto + 1]

    xchg EBX, DWORD PTR [texto + 6]

    mov EDX, OFFSET texto    ;en este ejemplo no se requiere.
    call WriteString
    call CrLf

    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main
