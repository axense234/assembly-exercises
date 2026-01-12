bits 32

global start        

extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll

; PROBLEM:
; Read the input.txt file in 5-byte chunks.
; The file is in the same directory as the asm file.
; For each chunk, print its 1-based index and its contents.
; Remember to free unused resources.
;
; EXAMPLE:
; Input file:
; ABCDEfghijKLMNO
;
; Resulting output:
; Chunk 1: ABCDE
; Chunk 2: fghij
; Chunk 3: KLMNO
;
; DOCUMENTATION:
; - x86 instructions: https://mrlini.github.io/instr/
; - C functions: https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/crt-alphabetical-function-reference?view=msvc-160#s

segment data use32 class=data
    CHUNK_LEN equ 5 
    
    printf_format db "Chunk %d: %s", 10, 0
    
    fin_name db "input.txt", 0
    fin_mode db "r", 0
    
    fin dd 0
    buffer db CHUNK_LEN + 1
    

segment code use32 class=code
start:
    ; GOOD LUCK! >:]
    
    ; open input.txt
    push fin_mode
    push fin_name
    call [fopen]
    add esp, 2 * 4
    test eax, eax
    jz program_end
    
    mov [fin], eax
    
    ; ecx = 0
    mov ecx, 0
    
    read_start:
        push ecx
       
        ; read first chunk from the opened input file
        push dword [fin]
        push CHUNK_LEN
        push 1
        push buffer
        call [fread]
        add esp, 4 * 4
        
        ; when we dont have anything else to read, we exit the loop
        cmp eax, 0
        jle program_end
        
        pop ecx
        inc ecx ; ++ecx
        
        push ecx
        ; we print the chunk to the console
        push dword buffer
        push ecx
        push printf_format
        call [printf]
        add esp, 3 * 4
        
        pop ecx
        
        ; loop
        jmp read_start
        
    program_end:
        ; close the input file
        push dword [fin]
        call [fclose]
        add esp, 1 * 4

    push dword 0
    call [exit]
    
    
    
    
    
