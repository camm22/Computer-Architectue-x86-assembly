#Author: Camille Bordes



.section .data
StringForPrintf: .string "Sum = %ld\n"  
StringForScanf:  .string "%ld"
msg_startVal: .string "Please write the startVal: \n"
msg_endVal: .string "Please write the endVal: \n"
msg_incVal: .string "Please write the incVal: \n"
startVal: .long 0
endVal:   .long 0
incVal:   .long 0
sum:      .long 0

.extern _printf
.extern _scanf

.section .text
.global _main
_main:
    pushl %ebp
    movl %esp, %ebp

    pushl $msg_startVal
    call _printf
    addl $4, %esp

    pushl $startVal
    pushl $StringForScanf
    call _scanf
    addl $8, %esp

    pushl $msg_endVal
    call _printf
    addl $4, %esp

    pushl $endVal
    pushl $StringForScanf
    call _scanf
    addl $8, %esp

    pushl $msg_incVal
    call _printf
    addl $4, %esp

    pushl $incVal
    pushl $StringForScanf
    call _scanf
    addl $8, %esp

    movl $0, sum
    movl startVal, %eax

cntrloop:
    cmpl endVal, %eax
    jge end_loop

    addl %eax, sum
    addl incVal, %eax
    jmp cntrloop

end_loop:
    pushl sum
    pushl $StringForPrintf
    call _printf
    addl $8, %esp

    movl %ebp, %esp
    popl %ebp
    ret
