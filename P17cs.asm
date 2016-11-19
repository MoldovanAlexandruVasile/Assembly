;(a*a+b)/(a+c/a)
;a,c-byte; b-doubleword
;Cu semn

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
	imul a			;AX = AL * a
	cwd			;Convert word to doubleword
	mov BX, word PTR b	;BX = 1/2 word from B
	mov CX, word PTR b+2	;CX = the other half word from B
	; => CX:BX

	add BX, AX		;BX = BX + AX
	adc CX, DX		;CX = CX + DX
	; CX:BX = CX:BX + DX:AX
	
	mov AL, c		;AL = c = 2
	cbw 			;convert byte to word
	idiv a			;AL = AX / a
	add AL, a		;AL = AL + a
	cbw			;converts byte to word
	mov DS,AX		;DS = AX
	mov AX, BX		;AX = BX
	mov DX, CX		;DX = CX
	mov BX, DS		;BX = DS
	idiv BX			;AX = DX:AX / BX

	mov AX, 4c00h
	int 21h

code ends
end start
