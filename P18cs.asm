;(a+b*c+2/c)/(2+a)+e
;a,b-byte; c-word; e-doubleword
;Cu semn

assume DS: data, CS: code

data segment

	a DB 1
	b DB 4
	c DW 2
	e DD 300

data ends
code segment

start:
	mov AX, data
	mov DS, AX
 	
	mov AL, b		;AL = b
	cbw			;AX = AL
	imul c			;DX:AX = AX * c 
	mov CX, DX		;CX = DX
	mov BX, AX		;BX = AX
	;CX:BX = b * c
	
	mov AL, 2		;AL = 2	
	cbw			;Converts byte to word
	cwd			;Convers word to doubleword
	idiv c			;AX = DX:AX / c
	;AX = 2/c

	cwd			;Converts word to doubleword
	add BX, AX		;BX = BX + AX
	adc CX, DX		;CX = CX + DX
	;CX:BX = b*c+2/c

	mov AL, a		;AL = a
	cbw			;Converts byte to word AL -> AX
	cwd			;Convers word to doubleword AX -> DX:AX
	add BX, AX		;BX = BX + AX
	adc CX, DX		;CX = CX + DX

	;CX:BX = (a+b*c+2/c)

	mov AL, a		;AL = a
	add AL, 2		;AL = AL + 2
	cbw			;AX = AL
	mov DX, CX		;DX = CX
	mov CX, AX		;CX = AX
	mov AX, BX		;AX = CX
	;DX:AX = (a+b*c+2/c)
	;CX = (2+a) 	

	idiv CX			;AX = DX:AX / CX
	;AX = (a+b*c+2/c)/(2+a)

	cwd			;DX:AX = AX
	add DX, word PTR e+2
	add AX, word ptr e
	;DX:AX = (a+b*c+2/c)/(2+a)+e

	mov AX, 4c00h
	int 21h

code ends
end start