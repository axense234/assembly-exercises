bits 32

global start        

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

%include "factorial.asm"

segment data use32 class=data
    printf_format db "factorial=%d", 10, 13, 0


segment code use32 class=code
    start:
        push dword 6
        call factorial
        add esp, 1 * 4
    
        push eax
        push printf_format
        call [printf]
        add esp, 2 * 4

        push 0
        call [exit]