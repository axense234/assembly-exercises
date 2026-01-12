bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    scanf_format db "%d", 0
    printf_format db "Quotient = %d, remainder = %d", 10, 0
    
    a dd 0
    b dd 0

; our code starts here
segment code use32 class=code
    start:
        ; read a from console
        push dword a
        push scanf_format
        call [scanf]
        add esp, 2 * 4
        
        ; read b from console
        push dword b
        push scanf_format
        call [scanf]
        add esp, 2 * 4
        
        ; a / d -> AX:DX
        mov eax, [a]
        cdq ; eax -> edx:eax
        mov ebx, [b]
        div ebx ; edx:eax / ebx -> eax:edx

        ; printf
        push edx
        push eax
        push printf_format
        call [printf]
        add esp, 3 * 4
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
