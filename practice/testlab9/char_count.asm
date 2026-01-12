bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    b_str db "random string aaa", 0
    b_count db "Number of b's: %d", 10, 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program


; count_b(const char* b, str) -> returns how many times b appears in the given string
count_b:
    mov ebx, [esp + 4] ; ebx = char
    mov edx, [esp + 8] ; edx = string
    
    mov esi, edx ; esi -> string
    
    mov ecx, 0 ; ecx = 0
    
    while_start:
        lodsb
        
        ; check if we are at the end of the string
        cmp al, 0:
        jz while_end
        
        ; compare them
        cmp al, ebx
        jne while_start
        
        
    
    while_end
        
        
    ret
            
            
        
        
        
    
    
    
    