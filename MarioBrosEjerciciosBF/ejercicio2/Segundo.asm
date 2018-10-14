TITLE *MASM Template	(Segundo.asm)*

; Descripcion:
; Inciso 2) de la tarea EjerciciosBF
; 
; Fecha de ultima modificacion:
; 14-oct-2018

INCLUDE \masm32\Irvine32.inc

INCLUDELIB \masm32\Irvine32.lib
includelib \masm32\User32.lib
includelib \masm32\Kernel32.lib

.DATA

cont DWORD 1
suma DWORD 0
alfa DWORD 3
mensaje BYTE 0dh,0ah,"Teclee un dato: ",0dh,0ah,0
mensaje2 BYTE 0dh,0ah,"Siguiente termino: ",0dh,0ah,0
mensaje3 BYTE 0dh,0ah,"TOTAL:  ",0dh,0ah,0

.CODE
; Procedimiento principal
main PROC

call Clrscr
mov edx,OFFSET mensaje
call WriteString

call ReadInt
MOV ECX, EAX
MOV EAX, 0
MOV EBX, 0
JNZ l1

l1:
    MOV EAX, cont
    MUL alfa
    SUB EAX, 2
    mov edx,OFFSET mensaje2
    call WriteString
    MOV EBX, EAX
    call WriteInt
    ADD suma, EBX
    MOV EAX, 0
    MOV EBX, 0
    INC cont
    DEC ECX
JNZ l1

    mov edx,OFFSET mensaje3
    call WriteString
    mov eax, suma
    call WriteInt

    exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main