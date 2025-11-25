bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, fwrite      
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll

; Problem statement:
; Mutate a string by inserting uppercase letters after each lowercase letter and vice versa. The inserted letters
; must be of the same type as the original one.
; ex: "aBcD" -> "aABbcCDd"

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    fin_name db "ul_strings_in.txt", 0
    fout_name db "ul_strings_out.txt", 0
    
    fin_mode db "r", 0
    fout_mode db "w", 0
    
    fin dd 0
    fout dd 0
    
    LEN equ 255
    buffer_in resb LEN + 1
    buffer_out resb (LEN * 2) + 1
    
    nb_of_bytes dd 0
    

; our code starts here
segment code use32 class=code
    start:
        ; open fin and fout
        push fin_mode
        push fin_name
        call [fopen]
        add esp, 2 * 4
        test eax, eax
        jz read_end
        mov [fin], eax
        
        push fout_mode
        push fout_name
        call [fopen]
        add esp, 2 * 4
        test eax, eax
        jz read_end
        mov [fout], eax
        
        ; read from the fin and write to fout
        read_start:
            ; read
            push dword [fin]
            push LEN
            push 1
            push buffer_in
            call [fread]
            add esp, 4 * 4
            
            ; exit reading if no more data to read
            cmp eax, 0
            jle read_end
            
            ; store the length of the read buffer
            mov [nb_of_bytes], eax
            
            ; mutate the string
            call mutate_string
            
            ; write to fout the mutated string
            push dword [fout]
            push dword [nb_of_bytes]
            push 1
            push buffer_out
            call [fwrite]
            add esp, 4 * 4
            
            jmp read_start
        read_end:
        
        push dword [fin]
        call [fclose]
        add esp, 1 * 4
        
        push dword [fout]
        call [fclose]
        add esp, 1 * 4
        
        ; exit(0)
        push    dword 0
        call    [exit]
    
    
    mutate_string:
    
        mov esi, buffer_in
        mov edi, buffer_out
        mov ecx, [nb_of_bytes]
        mov edx, 0 ; length of newly mutated string
        
        mutate_start:
            lodsb ; load byte from [esi] into AL, ++ESI
            stosb ; store AL into [edi], ++EDI
            inc edx ; ++edx
            
            ; check if char is lowercase
            cmp al, 'a'
            jb check_uppercase
            
            cmp al, 'z'
            ja check_uppercase
            
            ; letter is lowercase
            ; we convert it to uppercase
            sub al, 32
            stosb ; store AL into [edi], ++EDI
            inc edx ; ++edx
            jmp next_char
            
            
            check_uppercase:
                cmp al, 'A'
                jb next_char
                
                cmp al, 'Z'
                ja next_char
                
                ; letter is uppercase
                ; we convert it to lowercase
                add al, 32
                stosb ; store AL into [edi], ++edi
                inc edx ; ++edx
                jmp next_char
             
            
        next_char:
            loop mutate_start
        
        mov [nb_of_bytes], edx ; update length of string
        
        ret
            
        
    
