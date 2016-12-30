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