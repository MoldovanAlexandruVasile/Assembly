;(a+b*c+2/c)/(2+a)+e
;a,b-byte; c-word; e-doubleword
;Fara semn

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
	mov AH, 0		;AH = 0 => AX = b
	mul c			;DX:AX = AX * c
	mov CX, DX		;CX = DX
	mov BX, AX		;BX = AX
	;CX:BX = b * c

	mov AX, 2		;AX = 2
	mov DX, 0		;DX = 0  => DX:AX
	div c			;AX = (2/c)
	mov DX, 0		;DX:AX = AX

	add BX, AX		;BX = BX + AX
	adc CX, DX		;CX:BX = b*c+2/c

	mov AL, a		;AL = a
	mov AH, 0		;AH = 0 => AX = a
	mov DX, 0		;DX:AX = a

	add BX, AX
	adc CX, DX		;CX:BX = (a+b*c+2/c)

	
	mov BL, a		;AL = a
	add BL, 2		;AL = AL +2
	mov BH, 0		;BX = 3
	div BX			;AX = DX:AX / BX
	;AX = (a+b*c+2/c)/(2+a)

	mov DX, 0		;DX:AX = AX
	mov BX, word PTR e	;BX = 1/2 bytes from e
	mov CX, word PTR e+2	;CS = the other 1/2 bytes from e				
	add AX, BX		;AX = AX + BX 
	adc DX, CX		;DX = DX + CX

	;DX:AX = (a+b*c+2/c)/(2+a)+e

	mov AX, 4c00h
	int 21h

code ends
end start