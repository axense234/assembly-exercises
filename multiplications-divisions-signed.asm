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
    ; a,c-byte; b-word; d-doubleword; x-qword
    ; d-(7-a*b+c)/a-6+x/2
    a db 10
    b dw -15
    c db -27
    d dd 35
    x dq -19

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; a * b = -150
        mov ax, [b] ; ax = b
        imul byte [a] ; ax = a * b
        mov bx, ax; bx = ax = a * b
        
        ; x / 2 = - 9
        mov eax, [x] ; eax = low part = FFFFFFED in the registry
        mov edx, [x+4] ; edx = high part = FFFFFFFF in the registry
        mov ecx, 2; ecx = 2
        idiv dword ecx ; edx:eax / ecs <=> x / 2 -> eax = / (-9), edx = % (-1)
        mov ecx, eax ; ecx = eax = x / 2
        
        ; (7 - a*b + c) = 130
        mov al, [c]; al = cx
        cbw; ax = cx;
        neg bx ; bx = - bx = (- a*b)
        add bx, 7 ; bx = - a * b + 7
        add bx, ax ; bx = - a * b + 7 + ax = - a * b + 7 + c = 7 - a * b + c
        
        ; (7 - a*b + c) / a = 13
        mov ax, bx ; ax = bx = (7 - a * b + c)
        idiv byte [a] ; ax / a <=> (7 - a*b + c) / a) -> al = / (13), ah = %
        
        ; d-(7-a*b+c)/a-6+x/2 = 35 - 13 - 6 + (-9) = 35 - 28 = 7
        cbw ; ax = al = 13
        cwde ; eax = ax = 13
        neg eax; eax = - eax = -(7-a*b+c)/a
        add eax, [d] ; eax = -(7-a*b+c)/a + d
        sub eax, 6 ; eax = -(7-a*b+c)/a + d - 6
        add eax, ecx; eax = -(7-a*b+c)/a + d - 6 + x / 2
        ; -(7-a*b+c)/a + d - 6 + x / 2 = d-(7-a*b+c)/a-6+x/2
        
        
        

        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
