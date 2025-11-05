bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

; 1. Given the words A and B, compute the doubleword C as follows:
; the bits 0-4 of C are the same as the bits 11-15 of A
; the bits 5-11 of C have the value 1
; the bits 12-15 of C are the same as the bits 8-11 of B
; the bits 16-31 of C are the same as the bits of A


segment data use32 class=data
    ; ...
    a dw 0101110001101001b ; 0x5C69
    b dw 1011010100111000b ; 0xB538
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, 0; ecx = 0*32 = il store the computation here
        
        ; the bits 0-4 of C are the same as the bits 11-15 of A
        mov ax, [a] ; ax = a = 01011 10001101001b = 0x5C69
        and ax, 1111100000000000b ; ax = 0x5800
        cwde; ax -> eax = 0x00005800 = 0000 0000 0000 1011
        ror eax, 11; eax rotates by 11 positions to the right => eax = 0x0000000B
        or ecx, eax; ecx = 0x0000000B
        
        ; the bits 5-11 of C have the value 1
        or ecx, 0x00000FE0; ecx = 0x00000FEB
        
        ; the bits 12-15 of C are the same as the bits 8-11 of B
        mov eax, 0 ; eax = 0
        mov ax, [b] ; ax = 0xB538
        and ax, 0x0F00 ; ax = 0x0500
        cwde; ax -> eax = 0x00000500
        rol eax, 4 ; eax rotates by 4 positions to the left => eax = 0x00005000
        or ecx, eax ; ecx = 0x00005FEB
        
        ; the bits 16-31 of C are the same as the bits of A
        mov eax, [a] ; eax = 0x????5c69
        and eax, 0x00005C69 ; eax = 0x00005C69
        rol eax, 16 ; eax = 0x5C690000
        or ecx, eax ; ecx = 0x5C695FEB
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
