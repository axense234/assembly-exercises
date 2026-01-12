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
    a db 10
    b db 12
    c db 2
    d db 8

; our code starts here
segment code use32 class=code
    start:
        ; a + b -> al
        mov al, [a] ; al = a
        add al, [b] ; al = a + b
    
        ; (a + b) - c -> ah
        mov ah, al ; ah = al
        sub ah, [c] ; ah = al - c = (a + b) - c
        
        ; ((a + b) - c) * d -> ax (set location)
        mov bh, ah ; bh = ah = (a + b) - c
        mov al, bh ; al = bh = (a + b) - c
        mul byte [d] ; ax = al * d = ((a + b) - c) * d
        mov cx, ax ; cx = ax = ((a + b) - c) * d
        
        ; ((a + b) - c) * d)(160) - (c * d + b) / a (28 / 10 = 2, 8) -> bx (158)
        mov al, [c] ; al = c
        mul byte [d] ; ax = al * d = c * d
        add ax, [b] ; ax = ax + b = c * d + b
        mov ah, 0 ; ah = 0000 (i think if i don't do this it will make my cbw conversion wierd)
        div byte [a] ; al = ax / a = (c * d + b) / a
        ; i want al to convert to ax in order to do the final subtraction
        cbw ; ax = al (sign extended)
        sub cx, ax; cx = cx - ax(al) = ((a + b) - c) * d) - (c * d + b) / a
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
