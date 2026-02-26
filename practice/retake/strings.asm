bits 32

global start        

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    printf_format_s db "string = %s", 10, 0
    printf_format_char db "char = %c", 10, 0
    
    printf_format_palindrome db "Palindrome", 10, 0
    printf_format_not_palindrome db "Not Palindrome", 10, 0
    
    random_string db "reviver", 0

segment code use32 class=code
    start:
        mov esi, random_string
        push esi
        
        mov edi, esi
        mov ecx, -1
        xor al, al
        repne scasb
        
        dec edi ; null
        dec edi ; last char
        
        pop esi ; first char
        
        cld
        
        search:
            cmp esi, edi
            je palindrome
        
            lodsb
            cmp al, [edi]
            jne not_palindrome
            
            dec edi
            
            jmp search
            
        palindrome:
        push dword printf_format_palindrome
        call [printf]
        add esp, 1 * 4
        
        push dword 0
        call [exit]
            
        not_palindrome:
        push dword printf_format_not_palindrome
        call [printf]
        add esp, 1 * 4
        
        push    dword 0      
        call    [exit]