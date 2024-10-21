.global _start    

.data
msg1:.asciz "message 1\n"
msg2:.asciz "message 2\n"


.extern _printf

.text
.global _main
_main:
    movl %esp, %ebp
    
    call print_msg1
    call print_msg2
    
    xorl  %eax, %eax
    #movl $0x00, %eax
    ret

print_msg1:
    pushl $msg1
    call _printf
    addl $4, %esp
    ret

print_msg2:
    pushl $msg2
    call _printf
    addl $4, %esp
    ret    
