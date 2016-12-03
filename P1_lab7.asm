;1. Being given two alphabetical ordered strings of characters, s1 and s2, 
;build using merge sort the ordered string of bytes that contain all characters from s1 and s2.
assume cs:code, ds:data

data segment

	s1 DB 'a', 'd', 'e', 'g', 'l', 'z'
	l1 EQU $-s1
	s2 DB 'c', 'f', 'h', 'i', 'j', 'p', 'x', 'y'
	l2 EQU $-s2
	s3 DB l1+l2 dup(?)

data ends

code segment

start:

	mov AX, data
	mov DS, AX
	mov ES, AX
	
	cld			;DF = 0 => we pass the string from left to right

	mov CX,l1+l2

	lea AX,s1    		;AX = the address of string 1
	lea BX,s2    		;BX = the address of string 2
	lea DX,s3    		;DX = the address of string 3

	mov CX, l1+l2		;In CX we have the max length of string 3 (length string 1 + length string 2)

	mov BP,0    		;The current position in string 1
	mov SP,0   		;The current position in string 2

	repeat:

		cmp BP,l1   	;Check if the end of string 1 was reached
		jae get_from_2 	;If it was, get elements from string 2
		cmp SP,l2   	;Check if the end of string 2 was reached
		jae get_from_1  ;If it was, get elements from string 1
		mov SI,AX
		mov DI,BX
		cmpsb     	;Compares the element in the string 1 with the element from the string 2
		ja get_from_2
		jna get_from_1

		get_from_1:
			mov DI,DX
			mov SI,AX
			movsb   	;Moves the element from string 1 to string 3
			mov DX,DI
			mov AX,SI
			inc BP
			JCXZ finish  	;If CX = 0 we jump to finish
			loop repeat	;Otherwise we go in loop

		get_from_2:
			mov DI,DX
			mov SI,BX
			movsb   	;Moves the element from string 2 to string 3
			mov DX,DI
			mov BX,SI
			inc SP
			JCXZ finish 	;If CX = 0 we jump to finish
			loop repeat	;Otherwise we go in loop

	finish:				;End of the program
		mov AX, 4C00h
		int 21h

code ends
end start