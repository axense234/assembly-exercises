bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

; Two byte strings S1 and S2 are given. Obtain the string D by concatenating the elements of S1 from the left hand side to the right hand side and the elements of S2 from the right hand side to the left hand side.

; for int i = 0, i < len_s2 + len_s1, ++i
;    if c > 0:
;       d += s1[i]
;       c--;
;    else:
;       d += s2[len_s2 - i]

segment data use32 class=data
    ; ...
    LEN_S1 equ 4
    LEN_S2 equ 3
    S1 db 1, 2, 3, 4
    S2 db 5, 6, 7
    D db 0, 0, 0, 0, 0, 0, 0
    c db LEN_S1
    

; our code starts here
segment code use32 class=code
    ; i = eax
    
    start:
        ;...
        for_init:
            mov eax, 0
        for_cond:
            cmp eax, LEN_S2 + LEN_S1
            jge for_end
        for_body:
        
            if_cond:
                ; c > 0
                cmp byte [c], 0
                jle if_cond_false
          
            ; d = 1, 2, 3, 4
            if_cond_true:
                ; ebx = s1[i]
                mov ebx, [S1 + eax]
                ; d += s1[i]
                mov [D + eax], ebx;
                dec byte [c]
            
            ; d = 1, 2, 3, 4, 7, 6, 5
            if_cond_false:
                ; ebx = s2[len_s2 - i]
                mov ebx, [S2 - (LEN_S2 - eax)]
            
                ; s1 at the next pos starting from it's end
                mov [D + (eax + LEN_S1)], ebx
            
        for_post:
            inc eax
            jmp for_cond
        for_end:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
