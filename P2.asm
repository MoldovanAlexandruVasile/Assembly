;2. The words A and B are given. Obtain the word C in the following way:
;- the bits 0-3 of C are the same as the bits 5-8 of B
;- the bits 4-8 of C are the same as the bits 0-4 of A
;- the bits 9-15 of C are the same as the bits 6-12 of A

assume DS: data, CS: code

data segment

	a DW 0111011101010111b
	b DW 1001101101111111b
	c DW ?

data ends
code segment

start:
	mov AX, data
	mov DS, AX
 	
	mov BX, 0 			;BX = 0 -> we will work in BX
	
	mov AX, b			;AX = b
	
	and AX, 0000000111100000b	;We isolate the bits 5-8
	;AX = 0000000101100000b

	mov CL, 5			;CL = 5
	ror AX, CL			;rotate AX to right with 5 bits
	;AX = 0000000000001011b

	or BX, AX			;We move the result into BX
	;BX = 0000000000001011b

	mov AX, a			;AX = a

	and AX, 0000000000011111b	;We isolate the bits 0-4
	;AX = 0000000000010111b

	mov CL,4			;CL = 4
	rol AX, CL			;Rotate AX to left with 4 bits
	;AX = 0000000101110000b

	or BX, AX;			;We put the result in BX
	;BX = 0000000101111011b

	mov AX, a			;AX = a
	
	and AX, 0001111111000000b	;We isolate the bits 6-12
	;AX = 0001011101000000b

	mov CL, 3			;CL = 3
	rol AX, CL			;We rotate to left with 3 bits
	;AX = 1011101000000000b

	or BX, AX
	;BX = 1011101101111011b

	mov c, BX
	;c = 1011101101111011b

	mov AX, 4c00h
	int 21h

code ends
end start