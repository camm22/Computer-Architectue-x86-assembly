.global _start

.data

msg1:.asciz "Pleas enter any FP number : " # + %.3f
msg2:.asciz "\nThe number is represented by %X."

val_ff:.asciz "%f"
user_val:.float 0.0

.extern _printf
.extern _scanf


.text
.global _main
_main:
    movl %esp, %ebp
    
        
    pushl $msg1
    call _printf
    addl $4, %esp


    pushl $user_val
    pushl $val_ff
    call _scanf
    addl $8, %esp
    
    movl (user_val),%eax
    

    pushl %eax
    pushl $msg2
    call _printf
    addl $8, %esp
    
    xorl  %eax, %eax
    ret
