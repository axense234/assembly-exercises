bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll
                          

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    printf_format db "%d + %d = %d", 10, 0
    
    a dd 5
    b dd 10

; our code starts here
segment code use32 class=code
    start:
        mov eax, [a]
        add eax, [b]
        ; eax = a + b
        
        push eax
        push dword [a]
        push dword [b]
        push printf_format
        call [printf]
        add esp, 4 * 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
