TITLE *MASM Template	(CodigoBase.asm)*

; Descripción general:
; 

; Última fecha de modificación:
; 

; Librerías 
INCLUDE \masm32\Irvine32\Irvine32.inc
INCLUDELIB \masm32\Irvine32\Irvine32.lib
includelib \masm32\Irvine32\User32.lib
includelib \masm32\Irvine32\Kernel32.lib


.DATA
; Declaración de datos
n byte ?
temperaturas dword ?
i byte 0
menorTemp dword 0
iMenor byte 0
paridad byte ""

msjInicio byte "Dato n: "
msjMinIni byte "Minimo de las temperatras: "
msjMinFin byte "en: "

msjRevesInicio byte "Temperatura "
msjRevesMitad byte ": "
msjRevesFin byte ", "

msjAdios byte "ADIOS."

.CODE
; Procedimiento principal
main PROC




exit  
main ENDP
; Termina el procedimiento principal

END main
; Termina el área de Ensamble
