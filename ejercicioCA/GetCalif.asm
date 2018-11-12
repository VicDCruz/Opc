TITLE *MASM Template	(getCalif.asm)*

; Descripcion general:
; Tarea ejercicioCA

; Fecha de modIFicacion:
; 12/11/18

; Librerias 
INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaracion de datos
n DWORD 0
grades DWORD 100 DUP(?)
newGrades DWORD 100 DUP(?)

messageBegin BYTE "Cuantas calificaciones? ", 0
messageGetGrade BYTE "Calificacion ", 0
messageNewGrade BYTE "Calificacion convertida ", 0
messageDots BYTE ": ", 0
messageGrade BYTE ?, 0

.CODE
    ; Procedimiento principal
main PROC

    mov EAX, 0
    .WHILE SDWORD PTR EAX <= 0
        mov EDX, OFFSET messageBegin
        call WriteString
        call ReadInt
    .ENDW
    mov n, EAX
    mov EBX, 0
    .WHILE EBX < n
        mov EDX, OFFSET messageGetGrade
        call WriteString
        mov EAX, EBX
        inc EAX
        call WriteInt
        mov EDX, OFFSET messageDots
        call WriteString
        call ReadInt
        mov grades[EBX * TYPE EBX], EAX
        inc EBX
    .ENDW
    mov EBX, 0
    .WHILE EBX < n
        mov ECX, grades[EBX * TYPE EBX]
        .IF (ECX >= 90) && (ECX <= 100)
            mov messageGrade, "A"
        .ELSEIF (ECX >= 75) && (ECX <= 89)
            mov messageGrade, "B"
        .ELSEIF (ECX >= 60) && (ECX <= 74)
            mov messageGrade, "S"
        .ELSEIF (ECX >= 0) && (ECX <= 59)
            mov messageGrade, "D"
        .ENDIF
        mov EDX, OFFSET messageNewGrade
        call WriteString
        mov EAX, EBX
        inc EAX
        call WriteInt
        mov EDX, OFFSET messageDots
        call WriteString
        mov EDX, OFFSET messageGrade
        call WriteString
        call CrLf
        inc EBX
    .ENDW
exit  
main ENDP
; Termina el procedimiento principal

END main
; Termina el área de Ensamble
