TITLE Program Template          (RevStr.asm)

; Este programa revierte (invierte) un String.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
texto BYTE 31 DUP(0)
mnsg BYTE 0Ah, 0Dh, "Texto invertido: ", 0
lonTxt DWORD 0

nc DWORD ?
vc Dword 0

msjOracion BYTE "Ingresa oracion: ", 0

.CODE
main PROC
    mov eax, lonTxt
    .WHILE eax < 1 || eax > 30
        mov edx, OFFSET msjOracion
        call WriteString

        MOV EDX, OFFSET texto
        MOV ECX, 32
        call ReadString
        mov lonTxt, EAX

        call CrLf
    .ENDW

    ; Imprime el texto.
    mov edx, OFFSET texto
	call WriteString
	call CrLf

    ; Invertir el texto del String.
    mov eax, 0
    mov eax, lonTxt
    mov edx, 0
    mov ebx, 2
    div ebx
    mov nc, eax
    mov edx, 0
    mov ebx, 0
    mov ecx, 0
    mov ebx, vc
    mov ecx, nc
    .WHILE ebx < ecx
        mov edx, 0
        mov dl, texto[ebx * TYPE texto]
        mov eax, 0
        mov eax, lonTxt
        dec eax
        sub eax, ebx
        mov dh, texto[eax * TYPE texto]
        mov texto[ebx * TYPE texto], dh
        mov texto[eax * TYPE texto], dl
        inc ebx
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