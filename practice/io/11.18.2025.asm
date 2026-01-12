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
    ; ...
    scanf_str db "$s", 0
    user_name resb 100
    greeting db "Hello, world!", 10, 0

; our code starts here
segment code use32 class=code
    start:
        ; scanf("%s", user_name)
        push user_name
        push scanf_str
        call [scanf]
        add esp, 2 * 4
        
        ; printf("Hello, %s!\n");
        push scan_str
        push greeting
        call [printf]
        add esp, 2 * 4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
