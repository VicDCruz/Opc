TITLE *MASM Template	(ejer2.asm)*

; Descripcion general:
; Tarea ejer2

; Librerias 
INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib


.DATA
; Declaracion de datos
    n DWORD 0
    factor DWORD 10
    arrLista REAL8 10 DUP(?)

    messageGetN BYTE "Valor de n: ", 0
    messageGetFactor BYTE "Valor de Factor: ", 0
    messageGetArrLista BYTE ". Valor de ArrLista: ", 0
    coma BYTE ", ", 0

    dirTmp DWORD ?

    m DWORD 0
    f DWORD 10

    menor REAL8 ?
    menorIndex DWORD ?

.CODE
; Procedimiento principal
main PROC
    finit
    ; pide el dato factor
    .IF factor < 0 || factor > 9
        mov EDX, OFFSET messageGetFactor
        call WriteString
        call ReadInt
        mov factor, EAX
    .ENDIF
    ; pide el dato n 
    .IF n < 1 || n > 10
        mov EDX, OFFSET messageGetN
        call WriteString
        call ReadInt
        mov n, EAX
    .ENDIF
    push n
    push OFFSET arrLista
    CALL LeerLista

    push n
    push factor
    push OFFSET arrLista
    CALL FacLista

    push n
    push OFFSET arrLista
    CALL MenorLista
    CALL WriteFloat
    mov EDX, OFFSET coma
    call WriteString
    fstp menor
    pop EAX
    CALL WriteInt
    call CrLf

    push n
    push OFFSET arrLista
    CALL Imprime
    ; imprime “Adios”

exit  
main ENDP
; Termina el procedimiento principal

LeerLista PROC
    pop dirTmp
    pop ESI
    pop m

    mov EBX, 0
    .WHILE EBX < m
        mov EAX, EBX
        inc EAX
        call WriteInt
        mov EDX, OFFSET messageGetArrLista
        call WriteString
        call ReadFloat
        fstp REAL8 PTR [ESI + EBX * 8]
        inc EBX
    .ENDW

    push dirTmp
    ret
LeerLista ENDP

FacLista PROC
    pop dirTmp
    pop ESI
    pop f
    pop m

    mov EBX, 0
    .WHILE EBX < m
        fild f
        fmul REAL8 PTR [ESI + EBX * REAL8]
        fstp REAL8 PTR [ESI + EBX * REAL8]
        inc EBX
    .ENDW

    push dirTmp
    ret
FacLista ENDP

MenorLista PROC
    pop dirTmp
    pop ESI
    pop m

    mov EBX, 0
    fld REAL8 PTR [ESI + EBX * REAL8]
    fst menor
    .WHILE EBX < m
        fcomp REAL8 PTR [ESI + EBX * REAL8]
        fld menor
        fnstsw ax
        sahf
        .IF !Zero? && !Parity? && !Carry?
            fstp menor
            fld REAL8 PTR [ESI + EBX * REAL8]
            fst menor
            mov menorIndex, EBX
        .ENDIF
        inc EBX
    .ENDW

    inc menorIndex
    push menorIndex
    push dirTmp
    ret
MenorLista ENDP

Imprime PROC
    pop dirTmp
    pop ESI
    pop m

    mov EBX, 0
    .WHILE EBX < m
        fld REAL8 PTR [ESI + EBX * REAL8]
        call WriteFloat
        call CrLf
        fstp REAL8 PTR [ESI + EBX * REAL8]
        inc EBX
    .ENDW

    push dirTmp
Imprime ENDP

END main
; Termina el área de Ensamble
