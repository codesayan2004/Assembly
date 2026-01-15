; sum_libc.asm
; Read two integers and print their sum using scanf & printf
; x86 32-bit, Linux, NASM

extern printf
extern scanf

section .data
    msg1    db "Enter first number: ", 0
    msg2    db "Enter second number: ", 0
    fmt_in  db "%d", 0
    fmt_out db "Sum = %d", 10, 0

section .bss
    n1 resd 1
    n2 resd 1
    sum resd 1

section .text
    global main

main:
    ; printf("Enter first number: ");
    push msg1
    call printf
    add esp, 4

    ; scanf("%d", &n1);
    push n1
    push fmt_in
    call scanf
    add esp, 8

    ; printf("Enter second number: ");
    push msg2
    call printf
    add esp, 4

    ; scanf("%d", &n2);
    push n2
    push fmt_in
    call scanf
    add esp, 8

    ; sum = n1 + n2
    mov eax, [n1]
    add eax, [n2]
    mov [sum], eax

    ; printf("Sum = %d\n", sum);
    push dword [sum]
    push fmt_out
    call printf
    add esp, 8

    ; return 0
    xor eax, eax
    ret
