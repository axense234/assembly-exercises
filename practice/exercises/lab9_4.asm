bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    scanf_format db "%d: ", 0
    printf_format db "%d * %d = %lld", 10, 0
    
    a dd 0
    b dd 0
    
    res dq 0

; our code starts here
segment code use32 class=code
    start:
        ; get a from console
        push dword a
        push scanf_format
        call [scanf]
        add esp, 2 * 4
        
        ; get b from console
        push dword b
        push scanf_format
        call [scanf]
        add esp, 2 * 4
        
        ; edx:eax = a * b
        mov eax, [a]
        mov ebx, [b]
        mul ebx
        
        ; res = edx:eax
        mov [res], eax
        mov [res + 4], edx
        
        ; print a * b = edx:eax
        push dword [res + 4]
        push dword [res]
        push dword [b]
        push dword [a]
        push printf_format
        call [printf]
        add esp, 5 * 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
