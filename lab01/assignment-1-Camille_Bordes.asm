.data

msg1:.asciz "#################################\n"
msg2:.asciz "#  GNU ASM EFREI AGH FALL 2023  \n"
msg3:.asciz "################################\n"

.extern _printf

.text
.global _main
_main:
    movl %esp, %ebp
    
    pushl $msg1
    call _printf
    
    pushl $msg2
    call _printf
    
    pushl $msg3
    call _printf    
    
    addl $12, %esp
                
    xorl  %eax, %eax
    ret
