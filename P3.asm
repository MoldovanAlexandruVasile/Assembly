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
 	
	mov BX, 0 			;BX = 0 -> we will work in BX
	
	mov AX, a			;AX = 0
	
	and AX, 0111000000000000b	;We isolate the bits 12-14
	;AX = 0111000000000000b

	mov CL, 4			;CL = 4
	rol AX, CL			;We rotate AX with 4 bits to left
	;AX = 0000000000000111b

	or BX, AX			;We move the result in BX
	;BX = 0000000000000111b
		
	mov AX, b			;AX = b

	and AX, 0000000000111111b	;We isolate the bits 0-5
	;AX = 0000000000111111b

	mov CL, 3			;CL = 3
	rol AX, CL			;We rotate AX with 3 bits to left
	;AX = 0000000111111000b

	or BX, AX
	;BX = 0000000111111111b

	mov AX, a			;AX = a
	
	and AX, 0000001111111000b	;We isolate the bits 3-9
	;AX = 0000001101010000b

	mov CL, 6			;CL = 6
	rol AX, CL			;We rotate AX with 6 bits to left
	;AX = 1101010000000000b

	or BX, AX		
	;BX = 1101010111111111b

	mov c, BX
	;c = 1101010111111111b

	mov AX, 4c00h
	int 21h

code ends
end start