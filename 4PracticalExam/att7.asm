;Print on the screen the binary value of the numbers from a file.

assume DS:data, CS:code

data segment

	msg DB 'Numele fisierului: $'
	maxfileName DB 12
	lFileName DB ?
	fileName DB 12 dup (?)
	buffer DB 2 dup (?), '$'
	space DB 1 dup (?), '$'
	handler DW ?
	zece DB 10

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

	mov handler, AX

	call newLine
	
	Repeta:
		;save in BX the file handler
		mov BX, handler 

		;we read the number of 2 digits
		mov AH, 3Fh
		mov CX, 2
		mov DX, offset buffer
		int 21h

		;We see how many digits were read
		CMP AX, 0
		JE Sfarsit

		;In DI we will have 0 and in SI 1
		;Depends what we'll have in CF
		mov DI, 0
		mov SI, 1
	
		add DI, 48
		add SI, 48
		
		;we transform the string into number
		mov AL, buffer[0]
		mov BL, buffer[1]
		
		sub AL, '0'
		sub BL, '0'

		mul zece

		add AL, BL

		mov BL, AL

		;The number it's Byte and we need to loop 8 times
		mov CX, 8

		Repeta2:
			;Rotate to left with carry, one position
			rcl BL, 1
			
			;If CF = 1 we print 1
			JC unu
		
			;else we print 0
			mov AH, 02h
			mov DX, offset DI
			int 21h
			loop Repeta2
			JMP goOn

			unu:
				mov AH, 02h
				mov DX, offset SI
				int 21h
				loop Repeta2

		goOn:
			;we put the file handler back in BX
			mov BX, handler

			;We read the space from the file
			mov AH, 3Fh
			mov CX, 1
			mov DX, offset space
			int 21h
			call newLine
			JMP Repeta

	Sfarsit:
		mov AX, 4C00h
		int 21h
code ends
end start