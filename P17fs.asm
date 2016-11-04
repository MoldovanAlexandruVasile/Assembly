;(a*a+b)/(a+c/a)
;a,c-byte; b-doubleword
;Fara semn

assume DS: data, CS: code

data segment

	a DB 1
	b DD 300
	c DB 2

data ends
code segment

start:
	mov AX, data
	mov DS, AX
 	
	mov AL, a		;AL = a
	mul a			;AX = AL * a
	mov DX, 0		;DX = 0 => DX:AX := AX
	mov BX, word PTR b	;BX = 1/2 bytes from b
	mov CX, word PTR b+2	;CX = the other 1/2 bytes from b
	add CX, DX		;CX = DX
	add BX, AX		;BX = AX
	;CX:BX = (a*a+b)

	mov AL, c		;AL = c
	div a			;AL = AX / a
	add AL, a		;AL = AL + a
	mov AH, 0		;AH = 0 => AX = AL
	;AX = (a+c/a)
	
	mov DX, AX		;DX = AX
	mov AX, BX		;AX = BX
	mov BX, DX		;BX = DX
	mov DX, CX		;DX = CX
	;DX:AX = (a*a+b)
	div BX			;AX = DX:AX / BX		

	mov AX, 4c00h
	int 21h

code ends
end start