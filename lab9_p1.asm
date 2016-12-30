[bits 32]

section .text 

extern  _printf
extern _exit

global  _main 

_main: 
		mov EAX, [nr1]
		mov EBX, [nr2]
		add EAX, EBX
		
		push 	DWORD EAX
        push    DWORD text 
        call    _printf
	
        add     ESP, 8
        push    0
        call    _exit
        ret 

section .data

text:	db	'The sum is = %d',0
nr1 	dd	20
nr2 	dd  30	