;Scrie dintr-un fisier in altul, pe rand cate 2 biti

assume DS:data, CS:code

data segment
	msg2 DB 'The name of the file where you want to write: $'
	maxFileName2 DB 12
	lFileName2 DB ?
	fileName2 DB 12 dup (?)
	msg DB 'The name of the file: $'
	maxFileName DB 12
	lFileName DB ?
	fileName DB 12 dup (?)
	buffer DW 2 dup (?), '$'
	space DW 1 dup (?), '$'
	aux DW ?
	aux2 DW ?
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

	;read the file name from the keyboard
	mov AH, 0Ah
	mov DX, offset maxFileName2
	int 21h

	;make the filename an asciiz
	mov AL, lFileName2
	xor AH, AH
	mov SI, AX
	mov fileName2[si], 0

	;open the file
	mov AH, 3Dh
	mov AL, 2
	mov DX, offset fileName
	int 21h

	mov BX, AX
	mov aux, BX

	;open the file
	mov AH, 3Dh
	mov AL, 2
	mov DX, offset fileName2
	int 21h
	
	mov BX, AX
	mov aux2, BX
 
	call newLine

	Repeta: 		
		mov BX, aux
		;read the number
		mov AH, 3Fh
		mov CX, 2
		mov DX, offset buffer
		int 21h
		
		mov SI, AX
		CMP SI, 0
		JE Sfarsit
		
		mov BX, aux2
 
		;print it on the screen
		mov AH, 40h
		mov DX, offset buffer
		int 21h
	
		mov BX, aux
	
		;we read the space between the numbers
		mov AH, 3Fh
		mov CX, 1
		mov DX, offset space
		int 21h

		mov BX, aux2
		
		;we also print the space, to have all the numbers on the same line
		mov AH, 40h
		mov DX, offset space
		int 21h

		JMP Repeta
		

	Sfarsit:	
		mov AX, 4C00h
		int 21h
code ends
end start