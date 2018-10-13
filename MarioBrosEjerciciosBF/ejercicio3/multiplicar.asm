TITLE *MASM Template	(multiplicar.asm)*

; Operacion de multiplicar sin usar MUL

INCLUDE \masm32\Irvine\Irvine32.inc

INCLUDELIB \masm32\Irvine\Irvine32.lib
includelib \masm32\Irvine\User32.lib
includelib \masm32\Irvine\Kernel32.lib

.DATA
m       DWORD ?
n       DWORD ?

logM    BYTE "Inserta M: ", 0
logN    BYTE "Inserta N: ", 0
res     BYTE "RESULTADO: ", 0
err     BYTE "Alguno de los datos NO cumplen con las condiciones (M>=1, N>=0; ENTEROS)", 0
mStr    BYTE "M: ", 0
nStr    BYTE "N: ", 0

.CODE
main PROC
    getM:
        mov EDX, OFFSET logM
        call WriteString
        call ReadInt
        mov m, EAX
        call CrLf
        cmp m, 1
        JL error
        JMP getN

    getN:
        mov EDX, OFFSET logN
        call WriteString
        call ReadInt
        mov n, EAX
        call CrLf
        cmp n, 0
        JL error
        mov EAX, 0
        mov EBX, m
        JMP mult

    error:
        mov EDX, OFFSET err
        call WriteString
        call CrLf
        mov EDX, OFFSET mStr
        call WriteString
        mov EAX, m
        call WriteInt
        call CrLf
        mov EDX, OFFSET nStr
        call WriteString
        mov EAX, n
        call WriteInt
        call CrLf
        JMP finish

    mult:
        add EAX, n
        dec EBX
        cmp EBX, 0
        JG mult
        JMP showRes

    showRes:
        mov EDX, OFFSET res
        call WriteString
        call WriteInt
        call CrLf

    finish:
        exit
main ENDP
END main