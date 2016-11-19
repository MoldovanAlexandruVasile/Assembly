;8. Two byte strings S1 and S2 are given, having the same length. 
;Obtain the string D so that each element of D represents
;the maximum of the corresponding elements from S1 and S2.
;Exemple:
;S1: 1, 3, 6, 2, 3, 7
;S2: 6, 3, 8, 1, 2, 5
;D: 6, 3, 8, 2, 3, 7

assume DS: data, CS: code

data segment

	s1 DB 1, 3, 6, 2, 3, 7
	l EQU $-s1 
	s2 DB 6, 3, 8, 1, 2, 5
	 d DB l dup (?)

data ends
code segment

start:
	mov AX, data
	mov DS, AX
 	
	mov CX, l		;CX = length of s1
	mov SI, 0		;SI = 0
	
	JCXZ Sfarsit

	Repeta:

	CMP SI, l
	JGE Sfarsit

	mov AL, byte ptr s1[si]			;AL = s1[si]
	mov BL, byte ptr s2[si]			;BL = s2[si]

	CMP AL, BL				;Compare AL with BL

	JGE label1				;Jump if greater or equal
	JLE label2				;Jump if less

	loop Repeta

	label1: 
		mov byte ptr d[si], AL		;d[si] = AL
		inc SI				;SI = SI + 1	
		loop Repeta

	label2: 
		mov byte ptr d[si], BL		;d[si] = BL
		inc SI				;SI = SI + 1
		loop Repeta					

	Sfarsit:	

	mov AX, 4c00h
	int 21h

code ends
end start