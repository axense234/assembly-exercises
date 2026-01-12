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
    printf_fmt db "Largest number: %d", 10, 0
    numbers dd 5, 4, 3, 2, 1
    NUMBERS equ ($-numbers) / 4

; our code starts here
segment code use32 class=code
    start:
        ; max_n(numbers, numbers_len)
        push NUMBERS
        push numbers
        call max_n
        add esp, 2 * 4 ; eax = max
        
        
        ; printf(printf_fmt, ...)
        push eax
        push printf_fmt
        call [printf]
        add esp, 2 * 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

      
; int max_n(int* numbers, int len) {...}
; returns the largest integer in the array
; or 0 if the array is empty      
max_n:
    ; int * numbers
    mov edx, [esp + 4]
    ; int len
    mov ecx, [esp + 8]
    
    ; if array is empty return 0
    cmp ecx, 0
    jnz while_start
    
    mov eax, 0
    ret
    
    ; eax = max
    mov eax, 0
    
    while_start:
        
        cmp eax, [edx + ecx * 4]
        ; a > b ? a : b
        jg while_end
        
        mov eax, [edx + ecx * 4]
            
        while_end:
            loop while_start
    
    ret
    
    
    
    