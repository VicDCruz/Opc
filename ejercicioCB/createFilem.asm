TITLE Creating a File              (createFile.asm)

Comment !
Use of File procedures.
!

; Irvine Library procedures and functions
INCLUDE \masm32\Irvine\Irvine32.inc
INCLUDELIB \masm32\Irvine\Irvine32.lib
INCLUDELIB \masm32\Irvine\User32.lib
INCLUDELIB \masm32\Irvine\Kernel32.lib
; End Irvine

mCr=0dh
mLf=0ah
mNul=00h

.DATA
fHandle DWORD ?
fName BYTE "two.txt",mNul
alfa DWORD 1633837924
beta BYTE 64h, 63h, 6h, 61h
delta BYTE "1633837924",0
txt1 BYTE mCr,mLf, "Hola que tal.",mNul
txt2 BYTE mCr,mLf, "Nos vemos.",mNul
hlv BYTE mCr,mLf, "HASTA LA VISTA.",mNul

.CODE
main PROC

; Create the file
	mov	edx, OFFSET fName
	call	CreateOutputFile
	mov	fHandle, EAX

; Write into the file
	mov	EAX, fHandle
	mov	EDX, OFFSET txt1
	mov	ECX, SIZEOF txt1
	call	WriteToFile
		
; alfa: Write into the file
	mov	EAX, fHandle
	mov	EDX, OFFSET alfa
	mov	ECX, SIZEOF alfa
	call	WriteToFile

; Write into the file
	mov	EAX, fHandle
	mov	EDX, OFFSET txt2
	mov	ECX, SIZEOF txt2
	call	WriteToFile

; beta: Write into the file
	mov	EAX, fHandle
	mov	EDX, OFFSET beta
	mov	ECX, SIZEOF beta
	call	WriteToFile

; Write into the file
	mov	EAX, fHandle
	mov	EDX, OFFSET hlv
	mov	ECX, SIZEOF hlv
	call	WriteToFile

; delta: Write into the file
	mov	EAX, fHandle
	mov	EDX, OFFSET delta
	mov	ECX, SIZEOF delta
	call	WriteToFile

; Close the file
	mov	EAX, fHandle
	call	CloseFile

	EXIT
main ENDP

END main