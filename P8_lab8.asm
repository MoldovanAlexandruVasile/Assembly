;8. Write a program which reads the name of a file and two characters from 
;the keyboard. The program should replace all occurrences of the 
;first character in that file with the second character given by the user.

assume CS:code, DS:data

data segment

	msg DB 'Name of the file: $'
	maxFileName DB 12
	lFileName DB ?
	fileName DB 12 dup (?)
	char1 DB ?
	char2 DB ?
	buffer db 1 dup (?), '$'
	msgChar1 DB 'Replace: $'
	msgChar2 DB 'Replace with: $'
	openErrorMsg DB 'File does not exist ! $'
	readErrorMsg DB 'Can not read the file ! $'

data ends

code segment

newLine proc
	
	;print new line sequence
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

	call newLine

	; print the string "msgChar1" on the screen using interrupt 21h, function 09h
	mov AH, 09h
	mov DX, offset msgChar1
	int 21h


	; read from the keyboard the character we want to replace, using interrupt 21h, function 01h
	mov AH, 01h
	int 21h	
	mov char1, AL	; we store the character in char1
	

	call newLine


	; print the string "msgChar2" on the screen using interrupt 21h, function 09h
	mov AH, 09h
	mov DX, offset msgChar2
	int 21h


	; read from the keyboard the character we will replace with, using interrupt 21h, function 01h
	mov AH, 01h
	int 21h
	mov char2, AL	; we store the character in char2
	

	call newLine


	; print the string "msg" on the screen using interrupt 21h, function 09h
	mov AH, 09h
	mov DX, offset msg
	int 21h


	; read from the keyboard the name of the file using interrupt 21, function 0ah
	mov AH, 0Ah
	mov DX, offset maxFileName
	int 21h


	; we transform the filename into an ASCIIZ string (put zero at the end)
	mov AL, lFileName
	xor AH, AH
	mov SI, AX
	mov fileName[si], 0


	; open the file using function 3dh of the interrupt 21h
	mov AH, 3Dh
	mov AL, 2 	 
	mov DX, offset fileName
	int 21h

	JC openError
	mov BX, AX	; We save the file handle


	Repeta:
		mov AH, 3Fh	; we read from the file
		mov CX, 1 	; we read 1 character
		mov DX, offset buffer
		int 21h

		JC readError	; the CPU sets CF=1 if an error occured	

		mov SI, AX	; in AX we will have how many characters there were read
		cmp SI, 1	; we see if there was read 1 character
		JNE Sfarsit	; if not, we go to the end

		mov CH, buffer 	;The character which we've read from the file
		mov CL, char1 	;The character with who we will compare
		CMP CH, CL
		JNE Repeta	;If are not equal, we go to the next character
				;otherwise we will change it

		;If we found what we've looking for, we move the pointer
		;back with a step, and change the character
		mov AH, 42h
		mov AL, 01h
		mov CX, -1
		mov DX, -1
		int 21h

		;we write in the file the character char2
		mov AH, 40h
		mov CX, 1
		mov DX, offset char2
		int 21h
		jmp Repeta


	; print the openErrorMsg using function 09h of interrupt 21h
	openError:
		call newLine
		mov AH, 09h			; we print on the screen the openErrorMsg using interrupt 21h, function 09h
		mov DX, offset openErrorMsg
		int 21h
		jmp Sfarsit


	; print the readErrorMsg using function 09h of interrupt 21h
	readError:
		call newLine		
		mov AH, 09h			; we print on the screen the readErrorMsg using interrupt 21h, function 09h
		mov DX, offset readErrorMsg
		int 21h 
		jmp Sfarsit

	Sfarsit:
		; we close the file
		mov AH, 3Eh
		mov BX, offset fileName
		int 21h
		
		; the program ends
		mov AX,4C00h
		int 21h

code ends
end start