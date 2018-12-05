TITLE *MASM Template	(InfixPosfix.asm)*

; Descripción general:
; Este programa convierte una expresión infija a posfija y despúes la evalua
; Última fecha de modificación:
; 04/12/18

; Librerías 
INCLUDE \masm32\Irvine32.inc
INCLUDELIB \masm32\Irvine32.lib
includelib \masm32\User32.lib
includelib \masm32\Kernel32.lib


.DATA
; Declaración de datos

infija BYTE "(RA+SB)/TC*UD-RA+VE", 0
posfija BYTE "0000000000000000", 0
RA REAL8 2.0
SB REAL8 3.0
TC REAL8 -2.0
UD REAL8 10.0
VE REAL8 15.0
resultado REAL8 0.0
subcadena BYTE "00",0
simbolo BYTE '0', 0
espacio BYTE ' ', 0
suma BYTE '+', 0
resta BYTE '-', 0
multiplicacion BYTE '*', 0
division BYTE '/', 0
cont BYTE 0 
mensaje1 BYTE "Infijo: ", 0
mensaje2 BYTE "Posfijo: ", 0
mensaje3 BYTE "Resultado: ", 0
mensaje4 BYTE "ADIOS", 0

.CODE
; Procedimiento principal
main PROC

call Crlf
MOV EDX, OFFSET mensaje1
call WriteString
MOV EDX, OFFSET infija
call WriteString     

call Crlf
MOV EDI, 1
MOV ESI, 0
.WHILE ESI<16
    MOV AL, infija[EDI]
    .IF (AL==')') 
    .ELSEIF (AL!=suma) && (AL!=resta) && (AL!=multiplicacion) && (AL!=division) && (AL!='(') && (AL!=')') 
        MOV posfija[ESI], AL
    .ELSEIF (AL==suma) && (cont==0)
        MOV simbolo, '+'
        DEC ESI
        INC cont
    .ELSEIF (AL==suma) && (cont==1)
        MOV AH, simbolo
        MOV posfija[ESI], AH
        
        MOV simbolo, '+'
    .ELSEIF (AL==resta) && (cont==0)
        MOV simbolo, '-'
        DEC ESI
        INC cont
    .ELSEIF (AL==resta) && (cont==1)
        MOV AH, simbolo
        MOV posfija[ESI], AH
        MOV simbolo, '-'
    .ELSEIF (AL==multiplicacion) && (cont==0)
        MOV simbolo, '*'
        DEC ESI
        INC cont
    .ELSEIF (AL==multiplicacion) && (cont==1)
        MOV AH, simbolo
        MOV posfija[ESI], AH
        MOV simbolo, '*'
    .ELSEIF (AL==division) && (cont==0)
        MOV simbolo, '/'
        DEC ESI
        INC cont
    .ELSEIF (AL==division) && (cont==1)
        DEC ESI
        MOV AH, simbolo
        MOV posfija[ESI], AH
        MOV simbolo, '/'
    .ENDIF
   INC ESI
   INC EDI
 .ENDW
 
MOV AL, simbolo
MOV posfija[ESI], AL

call Crlf 
MOV EDX, OFFSET mensaje2
call WriteString
MOV EDX, OFFSET posfija
call WriteString

call evalua
call Crlf
MOV EDX, OFFSET mensaje4
call WriteString
call Crlf

exit  
main ENDP
; Termina el procedimiento principal

evalua PROC
    call Crlf
    MOV ESI, 0
    MOV EDI, 0
    .WHILE ESI<16
        MOV AL, posfija[ESI]
        .IF (AL!=suma) && (AL!=resta) && (AL!=multiplicacion) && (AL!=division) 
            MOV subcadena[ESI], AL
        .ELSEIF (AL==suma)
            FADD
        .ELSEIF (AL==resta)
            FSUB
        .ELSEIF (AL==multiplicacion)
            FMUL
        .ELSEIF (AL==division)
            FDIV
        .ENDIF

        .IF AL=='R'
               fld RA
          .ELSEIF AL=='S'
                fld SB
            .ELSEIF AL=='T'
                fld TC
            .ELSEIF AL=='U'
                fld UD
             .ELSEIF AL=='V'
                fld VE
            .ENDIF
     INC ESI      
.ENDW

call Crlf
MOV EDX, OFFSET mensaje3
call WriteString
call WriteFloat
call Crlf
call ShowFPUStack
  
RET
evalua ENDP

END main
; Termina el área de Ensamble
