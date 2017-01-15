;Prints on the screen the context of a file

assume DS:data, CS:code

data segment

	msg DB 'Fisierul din care vrei sa citesti: $'
	maxFileName DB 12
	lFileName DB ?
	fileName DB 12 dup (?)
	buffer DB 1 dup (?), '$'

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

	;print msg on the screen
	mov AH, 09h
	mov DX, offset msg
	int 21h

	;read the name of the file from keyboard
	mov AH, 0Ah
	mov DX, offset maxFileName
	int 21h

	;transform the file name into an ASCIIZ string
	mov AL, lFileName
	xor AH, AH
	mov SI, AX
	mov fileName[si], 0

	;open the file
	mov AH, 3Dh
	mov AL, 2
	mov DX, offset fileName
 	int 21h

	mov BX, AX

	call newLine

	Repeta:
		mov AH, 3Fh
		mov CX, 1
		mov DX, offset buffer
		int 21h
		
		mov SI, AX
		CMP SI, 1
		JNE Sfarsit
	
		mov AH, 09h
		mov DX, offset buffer
		int 21h

		JMP Repeta

	Sfarsit:
		mov AX, 4C00h
		int 21h
code ends
end start