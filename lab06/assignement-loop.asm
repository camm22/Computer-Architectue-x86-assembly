.global _start  
.data

msg1: .asciz "sum of natural numbers from %d to %d is %d \n"
msg2: .asciz "enter start, end and step values :\n"

long_fmt: .asciz "%d"

loopcntr:  .long 0
startVal: .long 0
endVal:   .long 10
incVal:   .long 1

sum:      .long 0

.extern _printf
.extern _scanf

.text
.global _main
_main:
    pushl %ebp
    xorl  %eax, %eax
    
    pushl $msg2
    call _printf
    addl $4, %esp
    
    pushl $startVal
    pushl $long_fmt
    call _scanf
    addl $8,%esp 
    
    pushl $endVal
    pushl $long_fmt
    call _scanf
    addl $8,%esp 
    
    pushl $incVal
    pushl $long_fmt
    call _scanf
    addl $8,%esp 
    
    movl startVal, %ecx
    movl %ecx, loopcntr
    
cntrloop:
    addl sum, %ecx
    movl %ecx, sum

    xorl %ecx, %ecx
    movl loopcntr, %ecx
    cmpl %ecx, endVal
    jle end_loop
    
    addl incVal, %ecx
    movl %ecx, loopcntr
    movl loopcntr, %ecx

    jmp cntrloop

end_loop:
    pushl sum
    pushl endVal
    pushl startVal
    pushl $msg1
    call _printf
    addl $16, %esp
    
    popl %ebp    
    xorl  %eax, %eax
    ret
