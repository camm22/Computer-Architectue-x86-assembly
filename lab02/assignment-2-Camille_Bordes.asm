.global _start

.data
str1: .asciz "0000\n"
str2: .asciz "     1111\n"

.extern _printf

.text
.global _main
_main:

    movl $3, %ecx
      
    l1:
        push %ecx
        
        movl $3, %ecx
        
        l2:
            push %ecx
            push $str1
            call _printf
            addl $4, %esp
            pop %ecx
            loop l2
        
        pushl $str2
        call _printf
        addl $4, %esp
        
        pop %ecx
        loop l1
        
    xorl  %eax, %eax
    ret
