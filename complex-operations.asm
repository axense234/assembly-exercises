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
    a dq 1122334455667788h
	b dq 0abcdef1a2b3c4d5eh
	r resq 1 ; save the result in r
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; 11223344  55667788 h -> EDX : EAX 
        mov eax, dword [a + 0]
        mov edx, dword [a + 4]
        
        ; abcdef1a 2b3c4d5e h  -> ECX : EBX 
	    mov ebx, dword [b + 0] 
	    mov ecx, dword [b + 4] 
      
        ; a + b 
	    ; edx : eax + 
	    ; ecx : ebx 
	    clc ; clear Carry Flag (punem 0 in CF) 
	    add eax, ebx  ; eax = eax + ebx, could produce a carry
	    adc edx, ecx ; edx = edx + ecx + CF 
        
        ; edx:eax -> r
        mov dword [r + 0], eax
        mov dword [r + 4], edx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
