bits 32

global start        

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    scanf_format db "%d", 0
    printf_format db "Sum is %d", 10, 0
    numbers resd 10
    n dd 0
    sum dd 0

segment code use32 class=code
start:
    while_start:
        ; eax = &numbers[n]
        ; base + index * scale + offset
        ; base = numbers
        ; index = [n]
        ; scale = 4
        ; offset = 0
        mov eax, [n]
        lea eax, [numbers + eax * 4]
        
        ; eax = scanf("%d", &numbers[n])
        ; eax - no. of values read successfully
        ; CTRL+Z + ENTER - stop inputting numbers
        ;
        ; eax, edx, ecx - not preserved
        push eax
        push scanf_format
        call [scanf]
        add esp, 2 * 4
        
        ; if (eax == 0) { break; }
        cmp eax, 0
        jle while_end
        
        inc dword [n]
        jmp while_start
    while_end:
    
    ; for (int i = 0; i < n; ++i) { sum += numbers[i]; }
    for_init:
        mov ecx, 0
    for_cond:
        cmp ecx, [n]
        jge for_end
    for_body:
        mov eax, [numbers + ecx * 4]
        add [sum], eax
    for_post_body:
        inc ecx
        jmp for_cond
    for_end:
    
    ; printf(printf_format, sum)
    push dword [sum]
    push printf_format
    call [printf]
    add esp, 2 * 4

    push dword 0
    call [exit]