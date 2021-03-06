TITLE Ejercicio suma de arreglo

; Descripcion:
; Ejemplo de uso de direccionamiento indirecto con operandos indirectos,
; en la suma de elementos de un arreglo.
; Todas las impresiones enteras se haran en Hexadecimal.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; Variables
arraySD SDWORD 1001h, 2002h, 3003h, 4004h, 5005h        ; en Hexadecimal

; Textos para la Consola
mcr = 0dh
mlf = 0ah
mnul = 0h
prtit 	BYTE mcr, mlf, "Ejercicio suma op. indirecto", mcr, mlf, mnul
pradi 	BYTE mcr, mlf, "ADIOS.", mcr, mlf, mnul
prtot 	BYTE mcr, mlf, "Total: ", mnul

.CODE
; Procedimiento principal
main PROC
	mov edx,OFFSET prtit
	call WriteString

	mov esi, offset arraySD
	mov ecx, 0    ; acumulador
	mov ebx, 1    ; contador
	
      ; ***** COMPLETAR
      L2:
      CMP EBX, LENGTHOF arraySD
      JG l1

        ADD ECX, [ESI]
        MOV EAX, [ESI]
        
        call WriteHex
        call CrLf
        ADD ESI, TYPE arraySD
        INC EBX
        JMP L2

      l1:
      
	; Total
	mov edx, OFFSET prtot
	call WriteString
	mov eax, ecx
	call WriteHex
	call Crlf
	
	; ADIOS
	mov edx,OFFSET pradi
	call WriteString
	call Crlf

	exit
main ENDP
; Termina el procedimiento principal

; Termina el area de Ensamble
END main