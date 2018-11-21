TITLE *MASM Template	(MultiBin.asm)*

; Descripción general:
; Programa que ejecuta una multiplicacion binaria dados dos numeros M y N
; Última fecha de modificación:
; 20/11/18

; Librerías 
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaración de datos
numero DWORD 4
mensaje1 BYTE "Introduzca el valor de M: ", 0
mensaje2 BYTE "Introduzca el valor de N: ", 0
mensaje3 BYTE "M: ", 0
mensaje4 BYTE "N: ", 0
mensaje5 BYTE "Producto: ", 0
mensaje6 BYTE "ADIOS", 0
M DWORD 0
N DWORD 0
alfa DWORD 0
residuo DWORD 0
producto DWORD 0

.CODE
; Procedimiento principal
main PROC
    call Crlf
    MOV EDX, OFFSET mensaje1
    call WriteString
    call ReadInt
    MOV M, EAX
    MOV alfa, EAX

    call Crlf
    MOV EDX, OFFSET mensaje2
    call WriteString
    call ReadInt
    MOV N, EAX
    MOV residuo, EAX

    .IF EAX>M
        MOV EBX, M
        MOV M, EAX
        MOV alfa, EAX
        MOV N, EBX
        mov residuo, EBX
    .ENDIF
    
    call multiplica
exit  
main ENDP

multiplica PROC
calcula:
    
    MOV EAX, 1
    MOV CL, 0
    
    .IF residuo==1
        INC CL
        JMP evalua
    .ENDIF
    
    .WHILE EAX<=residuo
        INC CL
        MOV EAX, 1
        SHL EAX, CL
    .ENDW
    JMP evalua
    
evalua: 
    DEC CL
    MOV EAX, 0
    MOV AL, CL
    
    SHL alfa, CL
    MOV EAX, alfa 
    MOV EDX, alfa
    ADD producto, EDX
    MOV EBX, M
    MOV alfa, EBX

    MOV EBX, residuo
    MOV EAX, 1
    SHL EAX, CL
    SUB EBX, EAX
    MOV residuo, EBX
    
    .IF residuo==0
        JMP imprime
    .ELSE
        JMP calcula
    .ENDIF

imprime:

    call Crlf
    MOV EDX, OFFSET mensaje3
    call WriteString
    MOV EAX, M
    call WriteInt
    
    call Crlf
    MOV EDX, OFFSET mensaje4
    call WriteString
    MOV EAX, N
    call WriteInt
    
    call Crlf
    MOV EDX, OFFSET mensaje5
    call WriteString
    MOV EAX, producto
    call WriteInt 

    call Crlf
    MOV EDX, OFFSET mensaje6
    call WriteString
RET
multiplica ENDP

; Termina el procedimiento principal

END main
; Termina el área de Ensamble
