;Write the first 10 bits from a file to the other

assume DS:data, CS:code

data segment
	msg DB 'Name of the file: $'
	msg2 DB 'Name of the second file: $'
	maxFileName DB 12
	lFileName DB ?
	fileName DB 12 dup (?)

	maxFileName2 DB 12
	lFileName2 DB ?
	fileName2 DB 12 dup (?)
	buffer DB 10 dup (?), '$'

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

	;print on the screen the message msg
	mov AH, 09h
	mov DX, offset msg
	int 21h	

	;read the file name from where we read	
	mov AH, 0Ah
	mov DX, offset maxFileName
	int 21h

	;we make the file name an ASCIIz
	mov AL, lFileName
	xor AH, AH
	mov SI, AX
	mov fileName[si], 0

	call newLine

	;print on the screen the message msg
	mov AH, 09h
	mov DX, offset msg2
	int 21h	

	;read the file name where we will write the content from first file	
	mov AH, 0Ah
	mov DX, offset maxFileName2
	int 21h

	;we make the file name an ASCIIz
	mov AL, lFileName2
	xor AH, AH
	mov SI, AX
	mov fileName2[si], 0
	
	;open the file
	mov AH, 3Dh			;Ne baga in AX handlerul fisierului
	mov AL, 2
	mov DX, offset fileName
	int 21h

	mov BX, AX 			;Cu BX lucra functia 3Fh

	call newLine

	;we read what we want to write in the other file
	mov AH, 3Fh
	mov CX, 10
	mov DX, offset buffer
	int 21h

	;open the file where we want to write
	mov AH, 3Dh			;3Dh baga in AX handlerul fisierului
	mov AL, 2
	mov DX, offset fileName2
	int 21h
	
	mov BX, AX			;Cu BX lucra functia 40h

	mov AH, 40h
	mov DX, offset buffer		;In buffer avem ce vrem sa scriem, si cu 
	int 21h				;functia 40h scriem ce avem in buffer

	mov AX, 4C00h
	int 21h
code ends
end start