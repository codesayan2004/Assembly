; array_input_print.asm
; Read array size n, read n integers, print the array
; x86 32-bit, Linux, NASM + libc

extern printf
extern scanf

section .data
    msg_n      db "Enter size of array: ", 0
    msg_in     db "Enter elements:", 10, 0
    msg_out    db "Array elements: ", 0
    fmt_int    db "%d", 0
    fmt_space  db "%d ", 0
    newline    db 10, 0

section .bss
    n     resd 1              ; int n
    arr   resd 100            ; max 100 integers

section .text
    global main

main:
    ; printf("Enter size of array: ");
    push msg_n
    call printf
    add esp, 4

    ; scanf("%d", &n);
    push n
    push fmt_int
    call scanf
    add esp, 8

    ; printf("Enter elements:\n");
    push msg_in
    call printf
    add esp, 4

    ; i = 0
    xor esi, esi              ; esi = index

read_loop:
    cmp esi, [n]
    jge print_array

    ; scanf("%d", &arr[i]);
    lea eax, [arr + esi*4]
    push eax
    push fmt_int
    call scanf
    add esp, 8

    inc esi
    jmp read_loop

print_array:
    ; printf("Array elements: ");
    push msg_out
    call printf
    add esp, 4

    xor esi, esi              ; i = 0

print_loop:
    cmp esi, [n]
    jge done

    ; printf("%d ", arr[i]);
    push dword [arr + esi*4]
    push fmt_space
    call printf
    add esp, 8

    inc esi
    jmp print_loop

done:
    ; newline
    push newline
    call printf
    add esp, 4

    ; return 0
    xor eax, eax
    ret
