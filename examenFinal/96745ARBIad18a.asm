TITLE Examen Final, 1er ejercicio, AD2018.

; Crear e imprimir una nueva lista a partir de otra inicial existente en memoria.
; Last Update: 18dic2018

.DATA
listi 	SDWORD 560, 450, 4 	;0-
		SDWORD 271, -105, 9 	;1-
		SDWORD 482, 3000, 8	;2-
		SDWORD 800, 4300, 5	;3-
		SDWORD 144, -310, 7 	;4-
		SDWORD 54, -900, -77 	;5 ultimo
		SDWORD 745, -1000, 2 	;6-
		SDWORD 342, 2000, 1 	;7-
		SDWORD 512, -700, 3	;8-
		SDWORD 637, 410, 6 	;9-
		
listn 	SDWORD 20 DUP(-999) 	;0-9

.CODE
main PROC

	exit
main ENDP

END main