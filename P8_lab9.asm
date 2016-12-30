;8. Print of the screen, for each number between 32 and 126,
;the value of the number (in base 10) 
;and the character whose ASCII code the number is.

assume CS:code, DS:data

data segment public
                             
    msg1 DB 'The character of the ASCII code $'
    msg DB ' is: $' 
    k0 DB ?
    k1 DB ?
    k2 DB ?

data ends

code segment public

extrn	character:proc
extrn   variabila:proc

newLine proc
	
	;print new line sequence
	mov AH, 0Eh       
	mov AL, 0Dh
	int 10h
	mov AL, 0Ah
	int 10h
	ret

newLine endp

start:
	mov AX, data
	mov DS, AX 
	mov CX, 95 
	mov DL, 32 
	mov k0, 0
	mov k1, 3
	mov k2, 2

	Repeta:        
	    	; print the message msg1 on the screen
	    	mov AH, 09h 
	    	mov DX, offset msg1
	    	int 21h
		
		CMP k0, 1
		JE DA

		DA:
			mov DL, k0
			add DL, 48
			mov AH, 2h
			int 21h 

		mov DL, k1
		add DL, 48
		mov AH, 2h
		int 21h 

		mov DL, k2
		add DL, 48
		mov AH, 2h
		int 21h     

	    	; print the message msg the screen  
	    	mov AH, 09h
	    	mov DX, offset msg
	    	int 21h
		
		add k2, 1
	
		CMP k2, 9
		JNE goOn

		new:
			mov k2, 0
			CMP k1, 9
			JG change
			add k1, 1	
			JMP goOn
			change:
				mov k1, 0
				mov k0, 1
							
	    	goOn:
			; print the character
	    		call character
	    		call newLine 
	    		loop repeta
	
	mov AX,4C00h
	int 21h

code ends
end start