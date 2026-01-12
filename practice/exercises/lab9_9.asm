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
    printf_format db "(%d + %d)/(%d - %d) = %d", 10, 0
    
    a dd 0
    b dd 0
    res dd 0

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
        
        ; eax = a + b
        mov eax, [a]
        add eax, [b]
        cdq ; eax -> edx:eax
        
        ; ecx = a - b
        mov ecx, [a]
        sub ecx, [b]
        
        ; edx:eax / ecx -> eax:edx
        div ecx
        
        ; printf
        push eax ; quotient
        ; (a - b)
        push dword [b]
        push dword [a]
        ; (a + b)
        push dword [b]
        push dword [a]
        push printf_format
        call [printf]
        add esp, 6 * 4
        

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
