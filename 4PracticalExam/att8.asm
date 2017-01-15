;Print on the screen the binary value of the number from a file.

assume DS:data, CS:code

data segment

	msg DB 'Numele fisierului: $'
	maxfileName DB 12
	lFileName DB ?
	fileName DB 12 dup (?)
	buffer DB 2 dup (?), '$'

data ends

code segment

newLine proc
	mov AH, 0Eh
	mov AL, 0Dh
	int 10h
	mov AL, 0Ah
	int 10h
	ret
newLine endp
start:
	mov AX, data
	mov DS, AX

	;we print on the screen: "Numele fisierului:"
	mov AH, 09h
	mov DX, offset msg
	int 21h

	;we read the file name
	mov AH, 0Ah
	mov DX, offset maxFileName
	int 21h

	;We transform it into ASCIIz
	mov AL, lFileName
	xor AH,	AH
	mov SI, AX
	mov fileName[SI], 0

	;we open the file
	mov AH, 3Dh
	mov DX, offset fileName
	mov AL, 2
	int 21h

	mov BX, AX

	call newLine
	
	mov AH, 3Fh
	mov CX, 2
	mov DX, offset buffer
	int 21h

	CMP AX, 0
	JE Sfarsit

	mov DI, 0
	mov SI, 1
	
	add DI, 48
	add SI, 48
			
	mov BL, buffer

	mov CX, 8

	Repeta2:
		rcl BL, 1
			
		JC unu
	
		mov AH, 02h
		mov DX, offset DI
		int 21h
		loop Repeta2

		unu:
			mov AH, 02h
			mov DX, offset SI
			int 21h
			loop Repeta2

	Sfarsit:
		mov AX, 4C00h
		int 21h
code ends
end start