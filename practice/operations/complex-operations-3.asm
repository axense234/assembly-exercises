bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; Write a program in the assembly language that computes the following arithmetic expression, considering the following data types for the variables:
    ; a - doubleword; b, d - byte; c - word; e - qword
    ; a + b / c - d * 2 - e
    ; signed representation
    a dd 125
	b db 2
	c dw 15
	d db 200
	e dq 80

; our code starts here
segment code use32 class=code
    start:
        ; b / c
        mov al, [b]; al = b
        cbw; ax = al
        cwd; eax = ax
        idiv word [c] ; eax / c <=> b / c -> ax = /, dx = %
        mov dx, 0; dx = 0
        mov bx, ax ; bx = ax = b / c
        
        ; d * 2
        mov ah, 0; ah = 0
        mov al, 2; al = 2
        mul byte [d] ; ax = 2 * d
        mov cx, ax ; cx = ax = d * 2
        
        ; a + b / c
        mov edx, [a]; edx = a
        mov ax, bx ; ax = bx
        cwde ; eax = ax = bx
        add edx, eax ; edx = edx + eax = a + b / c
        
        ; a + b / c - d * 2
        mov ax, cx ; ax = cx = d * 2
        cwde ; eax = ax
        sub edx, eax ; ecx = ecx - eax = a + b / c - d * 2
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
