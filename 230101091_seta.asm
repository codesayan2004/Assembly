; merge_sorted.asm
; Merge two sorted arrays into one sorted array (x86 32-bit, Linux)

section .data
    msg1 db "Enter first sorted array:", 10
    len1 equ $-msg1

    msg2 db "Enter second sorted array:", 10
    len2 equ $-msg2

    msg3 db "Merged sorted array:", 10
    len3 equ $-msg3

    space db " "
    newline db 10

    n equ 5

section .bss
    arr1 resb n
    arr2 resb n
    arr3 resb 2*n
    temp resb 2

section .text
    global _start

_start:

    ; Print msg1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; Read arr1
    mov esi, arr1
    mov ecx, n
read_arr1:
    call read_digit
    mov [esi], al
    inc esi
    loop read_arr1

    ; Print msg2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; Read arr2
    mov esi, arr2
    mov ecx, n
read_arr2:
    call read_digit
    mov [esi], al
    inc esi
    loop read_arr2

    ; Merge arrays
    mov esi, arr1
    mov edi, arr2
    mov ebp, arr3
    mov ecx, n
    mov edx, n

merge:
    cmp ecx, 0
    je copy_arr2
    cmp edx, 0
    je copy_arr1

    mov al, [esi]
    mov bl, [edi]
    cmp al, bl
    jle take_arr1

    mov [ebp], bl
    inc edi
    dec edx
    jmp next

take_arr1:
    mov [ebp], al
    inc esi
    dec ecx

next:
    inc ebp
    jmp merge

copy_arr1:
    cmp ecx, 0
    je done_merge
    mov al, [esi]
    mov [ebp], al
    inc esi
    inc ebp
    dec ecx
    jmp copy_arr1

copy_arr2:
    cmp edx, 0
    je done_merge
    mov al, [edi]
    mov [ebp], al
    inc edi
    inc ebp
    dec edx
    jmp copy_arr2

done_merge:

    ; Print msg3
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 0x80

    ; Print merged array
    mov esi, arr3
    mov ecx, 2*n

print_loop:
    mov al, [esi]
    add al, '0'
    mov [temp], al

    push ecx            ; save loop counter

    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    pop ecx             ; restore counter

    inc esi
    loop print_loop

    ; newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

; --------------------
; Read single digit
; --------------------
read_digit:
    push ecx          ; save loop counter

    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 2
    int 0x80

    mov al, [temp]
    sub al, '0'

    pop ecx           ; restore loop counter
    ret

