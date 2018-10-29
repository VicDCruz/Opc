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
txt WORD 0
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
    mov EAX, 0
    .WHILE EAX < lonTxt
        PUSH WORD PTR texto[EAX * TYPE texto]
        inc EAX
    .ENDW

    mov EAX, 0
    .WHILE EAX < lonTxt
        POP txt
        mov BL, BYTE PTR txt
        mov texto[EAX * TYPE texto], BL
        inc EAX
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