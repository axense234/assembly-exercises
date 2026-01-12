bits 32

global printf_wrapper

extern printf
import printf msvcrt.dll


segment data use32 class=data

; void printf_wrapper (char *format, ...) {...}
printf_wrapper:
    push ebp
    mov ebp, esp
    
    push dword [ebp + 12]
    push dword [ebp + 8]
    call [printf]
    add esp, 2 * 4
    
    mov esp, ebp
    pop ebp
    
    ret
    
    



