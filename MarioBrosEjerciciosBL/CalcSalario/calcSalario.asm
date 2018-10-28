TITLE CalcSalario          (.asm)

; Programa capaz de calcular el total de N salarios.

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine


.DATA
; PROC main
strGetN BYTE "Teclea el dato n: ", 0
strOutput BYTE "Resultado: ", 0
strBye BYTE "ADIOS", 0

n DWORD 0
salario0 DWORD 0

contFila BYTE 8
contCol BYTE 14

; PROC salarios, variables locales
nDir DWORD 0
totSalario DWORD 0
i DWORD 0
salario1 DWORD 0
dirRet1 DWORD 0

; PROC possal, variables locales
strGetSalarioInicio BYTE "Teclee el ", 0
strGetSalarioFin BYTE " salario: ", 0
iDir DWORD 0
salario2 DWORD 0
dirRet2 DWORD 0

.CODE
main PROC
    call Clrscr

    mov dh, contFila ; fila
    inc contFila
    mov dl, 14 ; columna
    call Gotoxy
    mov EDX, OFFSET strGetN
    call WriteString
    call ReadInt
    mov n, EAX

    push OFFSET n
    call salarios
    pop salario0

    mov dh, contFila ; fila
    inc contFila
    mov dl, 14 ; columna
    call Gotoxy
    mov EDX, OFFSET strOutput
    call WriteString
    mov EAX, salario0
    call WriteInt
    call CrLf

    mov dh, contFila ; fila
    inc contFila
    mov dl, 14 ; columna
    call Gotoxy
    mov EDX, OFFSET strBye
    call WriteString

	exit
main ENDP

salarios PROC
; salarios(n)
; Obtener 'n' salarios y sumarlos
; Recibe
;   Stack: nDir
; Regresa
;   Stack: suma de todos los salarios
; Variables automáticas y locales

    pop dirRet1
; Obtener nDir
    pop nDir
    mov ESI, nDir

    mov EAX, 0
    .WHILE EAX < [ESI]
        mov i, EAX
        push OFFSET i
        call possal
        pop salario1
        mov EBX, salario1

        add totSalario, EBX
        mov EAX, i
        inc EAX
    .ENDW
    push totSalario

    push dirRet1
    ret
salarios ENDP

possal PROC
; possal(i)
; Obtener el siguiente salario
; Recibe
;   Stack: iDir
; Regresa
;   Stack: el valor del nuevo salario
; Variables automáticas y locales

    pop dirRet2
; Obtener iDir
    pop iDir
    mov EDI, iDir

    mov dh, contFila ; fila
    inc contFila
    mov dl, 14 ; columna
    call Gotoxy
    mov EDX, OFFSET strGetSalarioInicio
    call WriteString
    mov EAX, [EDI]
    inc EAX
    call WriteInt
    mov EDX, OFFSET strGetSalarioFin
    call WriteString

    call ReadInt
    mov salario2, EAX
    push salario2

    call CrLf
    
    push dirRet2
    ret
possal ENDP

END main