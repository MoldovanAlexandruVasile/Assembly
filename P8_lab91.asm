; The character procedure will print out on the screen the character of the current ASCII code

assume CS:code, DS:data

data segment public
	k DB ?
data ends

code segment public
public character
character:
	mov DL, 32
	add DL, k
	mov AH, 02h
	int 21h 
	add k, 1
	ret
code ends
end