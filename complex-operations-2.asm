bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    m  dq 1122334455667788h 
	n  dd 0ccddeeddh 
	d  resd 1 ; result quotient

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx, [n]; ebx = n
        
        ; m -> edx:eax
        mov eax, [m + 0] ; eax = 88776655
        mov edx, [m + 4] ; edx = 44332211
        
        div ebx ; edx:eax / ebx -> eax = /, edx = %
        
        mov dword [d], eax ; d = eax
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
