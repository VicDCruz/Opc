TITLE *MASM Template	(Factorial.asm)*

; Descripción general:
; Segundo problema del EjercicioCA

; Última fecha de modificación:
; 12/11/18

; Librerías 
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaración de datos

cont DWORD 1
mensaje1 BYTE "Ingrese un valor no negativo: ", 0
mensaje2 BYTE "ERROR. Favor de ingresar un dato valido.", 0
mensaje3 BYTE "El factorial de n = ", 0
mensaje4 BYTE " es: ", 0
n DWORD 0


.CODE
; Procedimiento principal
main PROC

ingresa:
    call Crlf
    MOV EBX, 1
    MOV EDX, OFFSET mensaje1
    call WriteString
    call ReadInt
    MOV n, EAX
    JMP valida

valida:
    MOV EDX, n
    CMP EDX, 0
    JE imprime
    JLE negativo
    JAE positivo

positivo:
        MOV ECX, 0
        MOV EBX, 0
        MOV EAX, 0
        MOV EBX, cont
        INC cont
        MOV ECX, cont
            .WHILE ECX <= n
                MOV EAX, EBX
                MUL ECX
                MOV EBX, EAX
                INC ECX
            .ENDW
        MOV cont, 1
        JMP imprime
            
    negativo:
        call Crlf
        MOV EDX, OFFSET mensaje2
        call WriteString
        call Crlf
        JMP ingresa

    imprime:
    
    call Crlf
    MOV EDX, OFFSET mensaje3
    call WriteString
    MOV EAX, n
    call WriteInt
    MOV EDX, OFFSET mensaje4
    call WriteString
    MOV EAX, EBX
    call WriteInt
    call Crlf

exit  
main ENDP
; Termina el procedimiento principal

END main
; Termina el área de Ensamble
