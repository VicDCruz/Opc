TITLE Program Template          (LabelDi.asm)

; Ejemplo de uso de la Directiva Label.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

.DATA
; Mismos offsets
dwList  LABEL DWORD
wList  LABEL WORD
bList BYTE 01h, 10h, 02h, 20h, 03h, 30h, 04h, 40h

; Mensajes a imprimir
textr BYTE "DumpRegs", 0
textd BYTE "DumpMem por doublewords:", 0
textw BYTE "DumpMem por words:", 0
textb BYTE "DumpMem por bytes:", 0

.CODE
main PROC
    ; Limpiando registros
        mov EBX, 0EEEEEEEEh
        mov ECX, 0EEEEEEEEh
        
    ; Guardar en registros los contenidos de las tres variables
        mov EAX, dwList
        mov BX, wList
        mov CL, blist
    
    ; Guardar en registros los offsets de las 3 variables
        mov ESI, OFFSET dwList
        mov EDI, OFFSET wList
        mov EBP, OFFSET bList

    ; DumpRegs de 3 contenidos
        mov EDX, OFFSET textr
        call WriteString
        call DumpRegs

    ; DumpMem de dwlist
        mov EDX, OFFSET textd
        call WriteString
        mov ESI, OFFSET dwList
        mov EBX, OFFSET dwList
        mov ECX, LENGTHOF bList / TYPE dwList
        call DumpRegs

    ; DumpMem de wlist
        mov EDX, OFFSET textw
        call WriteString
        mov ESI, OFFSET wList
        mov EBX, OFFSET wList
        mov ECX, LENGTHOF bList / TYPE wList
        call DumpRegs

    ; DumpMem de blist
        mov EDX, OFFSET textb
        call WriteString
        mov ESI, OFFSET bList
        mov EBX, OFFSET bList
        mov ECX, LENGTHOF bList
        call DumpRegs

	exit
main ENDP
END main