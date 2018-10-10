TITLE EjerBF

; Uso de instrucciones, Directivas data y operadores.

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
val3	BYTE 32
val4	WORD 400

arrB	BYTE  10h,20h,30h, 40h, 50h
arrW	WORD  100h,200h,300h

arrSW	SWORD  -140,200,-300
arrSD	SDWORD 11000h, 22000h

array1	WORD 2, 4, 6
rever1	DWORD 3 DUP(?)

.CODE
main PROC
; Escriba comentarios
	mov EAX, 0
	mov EAX, val3
	add EAX, val4
	
	mov bl, LENGTHOF arrSW

	iniWhl:
		dec bl
		cmp bl, 0
		J

	exit
main ENDP
END main