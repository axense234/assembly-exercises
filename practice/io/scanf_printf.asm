bits 32

global start        

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    scanf_str db "%s", 0
    user_name resb 100
    greeting db "Hello, %s!", 10, 0

segment code use32 class=code
start:
    ; scanf("%s", user_name)
    push user_name
    push scanf_str
    call [scanf]
    add esp, 2 * 4

    ; printf("Hello, %s!\n", user_name);
    push user_name
    push greeting
    call [printf]
    add esp, 2 * 4

    ; exit(0)
    push dword 0
    call [exit]