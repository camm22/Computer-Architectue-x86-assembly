# quadric-equation.asm
# Program show simple FP addition
#
# Date: 18/11/2023
#
# Author: Camille Bordes


.global _start

.data

info_msg:.asciz "Solves quadratic equation.\n"

msg_a:.asciz    "\nenter a value for a :"
msg_b:.asciz    "\nenter a value for b :"
msg_c:.asciz    "\nenter a value for c :"

msg_printf:.asciz "\n\nThe equation is : %fx^2 + %fx + %f = 0\n"
msg_delta: .asciz "\nThe value of delta is : %f\n"

double_fmt:.asciz "%lf"

delta: .double  0.0
temp: .double 0.0

val_a:	.double 0.0
val_b:	.double 0.0
val_c:	.double 0.0
val_x0:	.double	0.0
val_x1:	.double	0.0
val_x2:	.double	0.0

msg_0_solution: .asciz "\nSo no solution for this equation\n"
msg_1_solution: .asciz "\nSO the solution is : %f\n"
msg_2_solution: .asciz "\nSo the solutions are : %f and %f\n"

two: .int 2
four: .int 4
zero: .int 0
one: .int -1

.extern _printf
.extern _scanf

.text
.global _main
_main:
    ###### info #######
    movl %esp, %ebp
    
    pushl $info_msg
    call _printf
    addl $4, %esp  
      
    ###### a #######
    pushl $msg_a
    call _printf
    addl $4, %esp
    
    pushl $val_a
    pushl $double_fmt
    call _scanf
    addl $8,%esp 
    ###### b #######
    pushl $msg_b
    call _printf
    addl $4, %esp 
    
    pushl $val_b
    pushl $double_fmt
    call _scanf
    addl $8,%esp 
    ###### c #######
    pushl $msg_c
    call _printf
    addl $4, %esp 
    
    pushl $val_c
    pushl $double_fmt
    call _scanf
    addl $8,%esp 
    
    ####### printf######
    movl (val_c+4), %eax
    pushl %eax
    movl (val_c), %eax
    pushl %eax
    movl (val_b+4), %eax
    pushl %eax
    movl (val_b), %eax
    pushl %eax
    movl (val_a+4), %eax
    pushl %eax
    movl (val_a), %eax
    pushl %eax
    pushl $msg_printf
    call _printf
    addl $28, %esp 
    
    finit
    fldl (val_b)
    fldl (val_b)
    fmul %st(1),%st(0)
    fstl (delta)
        
    finit
    fildl (four)
    fldl (val_a)
    fldl (val_c)
    fmul %st(1),%st(0)
    fmul %st(2),%st(0)
    fstl (temp)
    
    finit
    fldl (temp)
    fldl (delta)
    fsub %st(1),%st(0)
    fstl (delta)
    
    movl (delta+4), %eax
    pushl %eax
    movl (delta), %eax
    pushl %eax
    pushl $msg_delta
    call _printf
    addl $12, %esp 
    
    finit
    fildl (zero)
    fldl (delta)
    fcomi %st(1), %st(0)
    
    ja greater
    je equal

lower:  
    pushl $msg_0_solution
    call _printf
    addl $4, %esp  
    jmp end_compare 

equal:
    
    finit
    fildl (one)
    fldl (val_b)
    fmul %st(1),%st(0)
    fstl (val_x0)
        
    finit
    fildl (two)
    fldl (val_a)
    fmul %st(1),%st(0)
    fstl (temp)
    
    finit
    fldl (val_x0)
    fldl (temp)
    fdiv %st(1),%st(0)
    fstl (val_x0)
    
    movl (val_x0+4), %eax
    pushl %eax
    movl (val_x0), %eax
    pushl %eax
    pushl $msg_1_solution
    call _printf
    addl $12, %esp 
    
    jmp end_compare

greater:
    ##### x1 ####
    
    finit
    fildl (one)
    fldl (val_b)
    fmul %st(1),%st(0)
    fstl (val_x1)
    
    finit
    fldl (delta)
    fsqrt
    fstl (temp)
    
    finit
    fldl (temp)
    fldl (val_x1)
    fadd %st(1),%st(0)
    fstl (val_x1)

    finit
    fildl (two)
    fldl (val_a)
    fmul %st(1),%st(0)
    fstl (temp)
    
    finit
    fldl (temp)
    fldl (val_x1)
    fdiv %st(1),%st(0)
    fstl (val_x1)
    
    ##### x2 ####
    
    finit
    fildl (one)
    fldl (val_b)
    fmul %st(1),%st(0)
    fstl (val_x2)
    
    finit
    fldl (delta)
    fsqrt
    fstl (temp)
    
    finit
    fldl (temp)
    fldl (val_x2)
    fsub %st(1),%st(0)
    fstl (val_x2)

    finit
    fildl (two)
    fldl (val_a)
    fmul %st(1),%st(0)
    fstl (temp)
    
    finit
    fldl (temp)
    fldl (val_x2)
    fdiv %st(1),%st(0)
    fstl (val_x2)
    
    movl (val_x1+4), %eax
    pushl %eax
    movl (val_x1), %eax
    pushl %eax
    movl (val_x2+4), %eax
    pushl %eax
    movl (val_x2), %eax
    pushl %eax
    pushl $msg_2_solution
    call _printf
    addl $20, %esp 

end_compare:


/* end program */

end_program:

        movl $0x00, %eax
        ret
