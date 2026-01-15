extern scanf
extern printf

section .data
    msg_in db "Enter number: ",0
    msg_prime db "Prime Number: ",10,0
    msg_comp db "Composite Number: ",10,0
    msg_fact db "Factors are :",10,0
    msg_num db "%d ",0
    fmt_in db "%d",0
    msg db "cnt = %d",10,0
    cnt dd 0
    newline db 10,0

section .bss
    n resd 1
    
section .text
    global main

main:
    ; n - stdin
    push msg_in
    call printf
    add esp, 4
    mov esi, 1

    push n
    push fmt_in
    call scanf
    add esp, 8

    push msg_fact
    call printf
    add esp, 4
    mov esi, 1

loop_prime:
    cmp esi, [n]
    jg finish
    mov eax, [n]
    xor edx, edx
    div esi
    inc esi
    cmp edx, 0
    jne loop_prime
    inc dword [cnt]

    dec esi
    push esi
    push msg_num
    call printf
    add esp, 8
    inc esi
    jmp loop_prime

finish:
    push newline
    call printf
    add esp, 4

    push dword [cnt]
    push msg
    call printf
    add esp, 8

    mov eax, [cnt]
    cmp eax, 2
    je prime
    jmp comp

prime:
    push msg_prime
    call printf
    add esp, 4
    jmp end
comp:
    push msg_comp
    call printf
    add esp, 4
    jmp end

end:
    xor eax, eax
    ret