.data               

msg:.asciz "EAX value is %d in decimal which is %X in HEX."


.extern _printf

.text
.global _main
_main:
    
        movl %esp, %ebp
    
        movl $0x55AB, %eax
        
        pushl %eax
        pushl %eax
        pushl $msg
        call _printf
        
        addl $12, %esp
                
    xorl  %eax, %eax
    ret
