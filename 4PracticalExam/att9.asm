;Citeste de la tastatura un sir de numere in baza 10, de cate 2 cifre fiecare
;si scriele in fisier in baza 16

assume DS: data, CS: code

data segment
	
	msg DB 'Citeste sirul: $'
	maxSir DB 100
	lSir DB ?
	sir DB 100 dup (?)

	msg2 DB 'Fisierul: $'
	maxFileName DB 12
	lFileName DB ?
	fileName DB 12 dup (?)
	fileHandler DW ?

	unByte DB 2 dup (?)

	saispe DB 16
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

	;Print on the screen: 'Citeste sirul: '
	mov AH, 09h
	mov DX, offset msg
	int 21h

	;Read the string
	mov AH, 0Ah
	mov DX, offset maxSir
	int 21h

	call newLine

	mov AH, 09h
	mov DX, offset msg2
	int 21h

	mov AH, 0Ah
	mov DX, offset maxFileName
	int 21h

	mov AL, lFileName
	xor AH, AH
	mov SI, AX
	mov fileName[SI], 0

	mov AH, 3Dh
	mov AL, 2
	mov DX, offset fileName
	int 21h

	mov fileHandler, AX

	mov SI, 0

	Repeta:
		;we convert in hexa the number
		mov AL, sir[SI]
		mov BL, sir[SI + 1]
		sub AL, '0'
		sub BL, '0'
		mul saispe
		;in AL we have the result
		add AL, BL
		mov AH, 0
		div zece
		
		add AL, '0'
		add AH, '0'

		mov BX, fileHandler
		mov unByte[0], AL
		mov unByte[1], AH
		mov AH, 40h
		mov CX, 2
		mov DX, offset unByte
		int 21h
		
		add SI, 3
	
		;loop Repeta
		
	Sfarsit:
		mov BX, fileHandler
		mov AH, 3Eh
		mov DX, offset fileName
		int 21h
		mov AX, 4C00h
		int 21h
code ends
end start