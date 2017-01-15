;Afiseaza pe ecran pe rand cate 2 biti dintr-un fisier

assume DS:data, CS:code

data segment
	msg DB 'The name of the file: $'
	maxFileName DB 12
	lFileName DB ?
	fileName DB 12 dup (?)
	buffer DB 2 dup (?), '$'
	space DB 1 dup (?), '$'
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

	;prints a message on the screen
	mov AH, 09h
	mov DX, offset msg
	int 21h

	;read the file name from the keyboard
	mov AH, 0Ah
	mov DX, offset maxFileName
	int 21h

	;make the filename an asciiz
	mov AL, lFileName
	xor AH, AH
	mov SI, AX
	mov fileName[si], 0

	;prints a message on the screen
	mov AH, 09h
	mov DX, offset msg2
	int 21h

	;open the file
	mov AH, 3Dh
	mov AL, 2
	mov DX, offset fileName
	int 21h

	mov BX, AX

	call newLine

	Repeta: 		
		;read the number
		mov AH, 3Fh
		mov CX, 2
		mov DX, offset buffer
		int 21h
		
		mov SI, AX
		CMP SI, 0
		JE Sfarsit
		
		;print it on the screen
		mov AH, 09h
		mov DX, offset buffer
		int 21h
	
		;we read the space between the numbers
		mov AH, 3Fh
		mov CX, 1
		mov DX, offset space
		int 21h
		
		;we also print the space, to have all the numbers on the same line
		mov AH, 09h
		mov DX, offset space
		int 21h

		JMP Repeta

	Sfarsit:	
		mov AX, 4C00h
		int 21h
code ends
end start