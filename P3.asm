;3. The words A and B are given. Obtain the word C in the following way:
;- the bits 0-2 of C are the same as the bits 12-14 of A
;- the bits 3-8 of C are the same as the bits 0-5 of B
;- the bits 9-15 of C are the same as the bits 3-9 of A
; Final result should be => c = 1011001101011101b

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
 	
	mov BX, 0 			;BX = 0 -> will be the final result
	
	mov AX, a			;AX = 0
	and AX, 0000000000001010b	;We keep the bits 12-14 intact
	;AX = 0000000000001010b

	mov CL, 4
	ror AX, CL			;rotate to right 4 bits
	;AX = 1010000000000000b

	or BX, AX			;BX = AX
	;BX = 1010000000000000b

	mov AX, b			;AX = b
	and AX, 1001100000000000b	;We keep the bits 0-5 intact
	;AX = 1001100000000000b		

	mov CL, 3			;CL = 3
	ror AX, CL			;We rotare to right with 3 bits, AX
	;AX = 0001001100000000b

	or BX, AX			;We add the bits from 0-5 to BX
	;BX = 1011001100000000b

	mov AX, a			;AX = a
	and AX, 000101110100000b	;We keep bits 3-9 intact
	;AX = 000101110100000b

	mov CL, 5			;CL = 5
	ror AX, CL			;We rotate to right with 5 bits
	;AX = 000000001011101b

	or BX, AX			;We add the bits 9-15 to BX
	;BX = 1011001101011101b

	mov c, BX			;c = BX
	;c = 1011001101011101b

	mov AX, 4c00h
	int 21h

code ends
end start