;8. Print of the screen, for each number between 32 and 126,
;the value of the number (in base 10) 
;and the character whose ASCII code the number is.

assume CS:code, DS:data

data segment public
                             
    msg1 DB 'The current ASCII code is: $'
    msg DB 'The character is: $' 
    k DB ?

data ends

code segment public

extrn	character:proc

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
	mov k, 0

	Repeta:        
	    ; print the message msg1 on the screen
	    ;mov AH, 09h 
	    ;mov DX, offset msg1
	    ;int 21h     
	
	    ; print the message msg the screen  
	    ;mov AH, 09h
	    ;mov DX, offset msg
	    ;int 21h
	
	    ; print the character
	    call character
	    call newLine 
	    loop repeta
	
	mov AX,4C00h
	int 21h

code ends
end start