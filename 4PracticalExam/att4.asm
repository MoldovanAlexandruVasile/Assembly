;Write in a text document the input of the user

assume DS:data, CS:code

data segment

	msg DB 'What you want to write in file: $'

	msg2 DB 'File you want to write in: $'
	maxFileName DB 12
	lFileName DB ?
	fileName DB 12 dup (?)

	string DB 12 dup (?), '$'

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

	;write the msg2
	mov AH, 09h
	mov DX, offset msg2
	int 21h

	;read the file name
	mov AH, 0Ah
	mov DX, offset maxFileName
	int 21h

	;tranform the string in asciiz
	mov AL, lFileName
	xor AH, AH
	mov SI, AX
	mov fileName[SI],0

	call newLine

	;print on the screen the message msg
	mov AH, 09h
	mov DX, offset msg
	int 21h
	
	;read the string
	mov AH, 3Fh
	mov DX, offset string
	int 21h

	;open the file
	mov AH, 3Dh
	mov AL, 2
	mov DX, offset fileName
	int 21h

	mov BX, AX

	mov AH, 40h
	mov DX, offset string
	int 21h

	call newLine

	mov AX, 4C00h
	int 21h
code ends
end start