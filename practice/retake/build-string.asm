bits 32

global start        

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; Problem Statement
; Given N double word strings from the console, for each one print to the console the original string, a string formed from the high word of the double word string,
; and a string formed from the low word of the double word string.
; ex: n = 2
;     0FF32139h = 0FF3h, 2139h
;     03FEAD88h = 03FEh, AD88h


segment data use32 class=data
    printf_format_n db "n = ", 0
    scanf_format_n db "%d", 0
    
    scanf_format_dword db "%s", 0
    
    printf_format_out db "%s = %s, %s", 10, 0
    
    n resd 1        
    
    og_string resb 10
    high_string resb 6
    low_string resb 6

segment code use32 class=code
    start:
        ; printf(printf_format_n);
        push dword printf_format_n
        call [printf]
        add esp, 1 * 4
        
        ; scanf(scanf_format_n, &n)
        push dword n
        push dword scanf_format_n
        call [scanf]
        add esp, 2 * 4
        
        _for_init:
            mov ecx, 0
           
        _for_cond:
            cmp ecx, [n]
            jge _for_end
            
        _for_body:
            push ecx
        
            ; scanf(scanf_format_dword, &og_string);
            push dword og_string
            push dword scanf_format_dword
            call [scanf]
            add esp, 2 * 4
            
            ; high word string
            mov esi, og_string
            mov edi, high_string
            mov ecx, 4
            rep movsb
            
            mov al, 'h'
            stosb
            mov al, 0
            stosb
            
            ; low word string
            mov esi, og_string + 4
            mov edi, low_string
            mov ecx, 4
            rep movsb
            
            mov al, 'h'
            stosb
            mov al, 0
            stosb
            
            ; printf(printf_format_out, og_string, high_string, low_string);
            push dword low_string
            push dword high_string
            push dword og_string
            push dword printf_format_out
            call [printf]
            add esp, 4 * 4
            
            pop ecx
            
        _for_next:
            inc ecx
            jmp _for_cond
            
        _for_end:
        
        ; exit
        push dword 0
        call [exit]
        
        
        
        
        
        
        