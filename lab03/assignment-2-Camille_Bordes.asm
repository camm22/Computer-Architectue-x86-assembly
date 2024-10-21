.global _start

.data

msg1:.asciz "Enter a char\n"
msg2:.asciz "The char is %c"

number:.asciz "The char %c is a number\n"
capital:.asciz "The char %c is a capital letter\n"
letter:.asciz "The char %c is a letter\n"
somethingelse:.asciz "The char %c is not a letter or a number\n"

val_fmt:.asciz "%c"
userval:.asciz ""

.extern _printf
.extern _scanf

.text
.global _main
_main:
    movl %esp, %ebp
    
    pushl $msg1
    call _printf
    addl $4, %esp
    
    pushl $userval
    pushl $val_fmt
    call _scanf
    addl $8, %esp
    
    movl (userval), %eax
    cmp $'0', %eax
    jl not_number
    cmp $'9', %eax
    jg not_number
    
    pushl %eax
    pushl $number
    call _printf
    addl $8, %esp
    
    xorl  %eax, %eax
    ret

not_number:
    cmp $'A', %eax
    jl not_letter
    cmp $'Z', %eax
    jg not_letter
    
    pushl %eax
    pushl $capital
    call _printf
    addl $8, %esp
    
    xorl  %eax, %eax
    ret
    
not_letter:
    cmp $'a', %eax
    jl something_else
    cmp $'z', %eax
    jg something_else
    
    pushl %eax
    pushl $letter
    call _printf
    addl $8, %esp
    
    xorl  %eax, %eax
    ret

something_else:
    pushl %eax
    pushl $somethingelse
    call _printf
    addl $8, %esp
    
    xorl  %eax, %eax
    ret
