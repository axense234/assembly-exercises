bits 32

global start        

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; Problem Statement
; Given N strings, for each string print to the console "Yes" if string is a palindrome, and "No" otherwise.
; ex: n = 2
;     s = reviver
;     Yes
;     s = horse
;     No

segment data use32 class=data
    printf_format_n db "n = ", 0
    scanf_format_n db "%d", 0
    
    printf_format_s db "s = ", 0
    scanf_format_s db "%s", 0
    
    printf_format_yes db "Yes", 10, 0
    printf_format_no db "No", 10, 0
    
    printf_format_char db "%c", 10, 0
    
    n resd 1
    
    current resd 1
    

segment code use32 class=code
    start:
        push dword printf_format_n
        call [printf]
        add esp, 1 * 4
        
        push dword n
        push dword scanf_format_n
        call [scanf]
        add esp, 2 * 4
        
        mov ecx, [n]
        
        program:
            push ecx
        
            push dword printf_format_s
            call [printf]
            add esp, 1 * 4
            
            push dword current
            push dword scanf_format_s
            call [scanf]
            add esp, 2 *4
            
            mov esi, current
            push esi
            
            mov edi, esi
            mov ecx, -1
            xor al, al
            repne scasb
            
            dec edi
            pop esi
            
            palindrome:
                cmp esi, edi
                jge yes_palindrome
            
            
                movsb
                cmp al, [edi]
                jne not_palindrome
                
                inc esi
                dec edi
            
            pop ecx
            
            loop program
            
            
        yes_palindrome:
            push dword printf_format_yes
            call [printf]
            add esp, 1 * 4
        
            push    dword 0      
            call    [exit]
            
        not_palindrome:
            push dword printf_format_no
            call [printf]
            add esp, 1 * 4
        
            push dword 0
            call [exit]
        
