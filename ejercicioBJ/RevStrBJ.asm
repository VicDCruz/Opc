TITLE Program Template          (RevStr.asm)

; Este programa revierte (invierte) un String.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
texto BYTE "Las quince letras", 0
mnsg BYTE 0Ah, 0Dh, "Texto invertido: ", 0
lonTxt WORD LENGTHOF texto - 1

nc WORD ?
vc word 0


.CODE
main PROC

    ; Imprime el texto.
    mov edx, OFFSET texto
	call WriteString
	call CrLf

    ; Invertir el texto del String.
    mov eax, 0
    mov ax, lonTxt
    mov dx, 0
    mov bx, 2
    div bx
    mov nc, ax
    mov edx, 0
    mov ebx, 0
    mov ecx, 0
    mov bx, vc
    mov cx, nc
    .WHILE ebx < ecx
        mov edx, 0
        mov dl, texto[ebx * TYPE texto]
        mov eax, 0
        mov ax, lonTxt
        dec ax
        sub ax, bx
        mov dh, texto[eax * TYPE texto]
        mov texto[ebx * TYPE texto], dh
        mov texto[eax * TYPE texto], dl
        inc bx
    .ENDW
    ;  mov texto, "Z"    ; una prueba de modificacion

    ; Despliega el texto invertido.
	mov edx,OFFSET mnsg
	call Writestring
	mov edx,OFFSET texto
	call Writestring
	call CrLf

	exit
main ENDP

END main