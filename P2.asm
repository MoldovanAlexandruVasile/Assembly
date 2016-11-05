;2. The words A and B are given. Obtain the word C in the following way:
;- the bits 0-3 of C are the same as the bits 5-8 of B
;- the bits 4-8 of C are the same as the bits 0-4 of A
;- the bits 9-15 of C are the same as the bits 6-12 of A
; Final result should be => c = 1011011101110101b

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
	
	mov AX, b			;AX = b
	mov CL, 4			;CL = 4
	rol AX, CL			;rotate 4 positions to left AX
	;AX = 1011011111111001b
	
	and AX, 1011000000000000b 	;We keep the bits 0-3 intact
	;AX = 1011000000000000b

	or BX, AX			;we put the bits in BX
	;BX = 1011000000000000b

	mov AX, a			;AX = a
	and AX, 0111000000000000b	;We keep the bits 0-4 intact
	mov CL, 12			;CL = 12
	rol AX, CL
	;AX = 0000011100000000b

	or BX, AX			;we but the bits in BX
	;BX = 1011011100000000b

	mov AX, a 			;AX = a
	mov CL, 4			;CL = 5
	rol AX, CL			;Rotate 4 positions to left AX
	;AX = 0111010101110111b

	and AX, 0111010100000000b	;We keep the bits 0-7 intact
	;AX = 0111010100000000b
	
	mov CL, 8
	rol AX, CL			;We rotate 8 positions to left AX
	;AX = 0000000001110101b

	or BX, AX			;We add the last 8 bits from AX to BX
	;BX = 1011011101110101b
	
	mov c, BX			;We put the final result in c
	;c = 1011011101110101b

	mov AX, 4c00h
	int 21h

code ends
end start