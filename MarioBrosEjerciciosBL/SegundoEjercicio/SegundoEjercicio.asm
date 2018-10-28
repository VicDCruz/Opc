TITLE *MASM Template	(SegundoEjercicio.asm)*

; Descripción general:
; Segundo ejercicio de programación de la tarea EjerciciosBL
; Última fecha de modificación:
; 27/octubre/18

; Librerías 
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaración de datos

    mensaje1 BYTE "String: ", 0 
    mensaje2 BYTE "Caracter ", 0
    mensaje3 BYTE " : ", 0
    mensaje4 BYTE " - MAYUSCULAS", 0
    mensaje5 BYTE " - minusculas", 0
    mensaje6 BYTE " - Char no alfa", 0
    mensaje7 BYTE "Ingrese una cadena de caracteres: ", 0
    mensaje8 BYTE "Conversion: ", 0
    cont DWORD 1
    sizeCad DWORD 0
    AA BYTE 01000000b
    BB BYTE 01011001b
    a BYTE 01100000b
    b BYTE 01111001b
    cadena BYTE 100 DUP('?')
    nulo BYTE '?'
    charCountR DWORD ?
    
.CODE

; Primer procedimiento. Aquí se lee la cadena ingresada por el usuario.
lectura PROC
    MOV EDX, OFFSET mensaje7
    CALL WriteString
    MOV EDX, OFFSET cadena
    MOV ECX, 100
    CALL ReadString
    MOV charCountR, EAX

    call CrlF
    
    MOV EDX, OFFSET mensaje1
    CALL WriteString
    MOV EDX, OFFSET cadena
    CALL WriteString
    MOV ESI, OFFSET cadena
    MOV AH, nulo 
    DEC sizeCad
    JMP calcula

calcula:
    INC sizeCad
    MOV AL, [ESI]
    INC ESI
    CMP AL, AH
    JNE calcula
    DEC sizeCad 

    CALL imprime
lectura ENDP
    
;Segundo procedimiento. Aquí se imprimen los caracteres de la cadena detallando el tipo al que pertenecen.
imprime PROC 
        MOV ESI, OFFSET cadena
        MOV EBP, sizeCad
        MOV EDI, 1
        call CrlF
        MOV BH, AA
        MOV BL, BB
        MOV CH, a
        MOV CL, b
        
    .WHILE EDI<EBP
        MOV EDX, OFFSET mensaje2
        CALL WriteString
        MOV EAX, cont
        CALL WriteInt
        MOV EDX, OFFSET mensaje3
        CALL WriteString
        
        MOV  AL, [ESI] 
        CALL WriteChar
        MOV EDX, OFFSET mensaje6

        .IF (AL>BH) && (AL<BL)
             MOV EDX, OFFSET mensaje4
        .ELSEIF (AL>CH) && (AL<CL)
            MOV EDX, OFFSET mensaje5
        .ENDIF

        call WriteString 
        INC cont
        INC EDI
        INC ESI
        call CrlF
    .ENDW  
    CALL convierte
imprime ENDP

;Tercer procedimiento. Aquí se invierte el tipo de todos los caracteres de la cadena.
convierte PROC
        MOV ESI, OFFSET cadena
        MOV EBP, sizeCad
        MOV EDI, 1
        call CrlF
        
     .WHILE EDI<EBP
        MOV  AL, [ESI] 
        .IF (AL>BH) && (AL<BL)
             OR AL, 00100000b
             MOV [ESI], AL
        .ELSEIF (AL>CH) && (AL<CL) 
             AND AL, 11011111b
             MOV [ESI], AL
        .ENDIF
        INC EDI
        INC ESI
     .ENDW

    call CrlF
    MOV EDX, OFFSET mensaje8 
    CALL WriteString
    MOV EDX, OFFSET cadena
    CALL WriteString 
    call CrlF
convierte ENDP

exit
; Terminan todos los procedimientos

END lectura
; Termina el área de Ensamble
