.global _start

.data

msgX:.asciz "Type value of x : %d\n"
msgY:.asciz "Type value of y : %d\n"
msgZ:.asciz "Type value of z : %d\n"

val_fmt:.asciz "%d"

uservalX:.int 0
uservalY:.int 0
uservalZ:.int 0

ResMsgA:.asciz "Result for equation A : %d\n"
ResMsgB:.asciz "Result for equation B : %d\n"
ResMsgC:.asciz "Result for equation C : %d\n"
ResMsgD:.asciz "Result for equation D : %d\n"

.extern _printf
.extern _scanf

.text
.global _main
_main:
    movl %esp, %ebp
       
    call askValueXYZ
    call equationA
    
    xorl  %eax, %eax
    ret


equationA: #a)	((2x^2+ 3y)/2 +4z)*3
    movl $0, %edx
    
    movl (uservalX), %eax
    movl $2, %ebx
    mull %ebx
    mull %eax
    
    movl %eax, %ebx
    movl (uservalY), %eax
    movl $3, %ecx
    mull %ecx
    addl %ebx, %eax
    
    movl $2, %ebx
    divl %ebx
    movl %eax, %ebx 
    
    movl (uservalZ), %eax
    movl $4, %ecx 
    mull %ecx
    addl %ebx, %eax
    
    mov $3, %ebx
    mull %ebx
    
    pushl %eax
    pushl $ResMsgA
    call _printf
    addl $8, %esp
    
    ret

askValueXYZ:
    pushl $uservalX
    pushl $val_fmt
    call _scanf
    addl $8, %esp
   
    pushl uservalX
    pushl $msgX
    call _printf
    addl $8, %esp
    
    
    pushl $uservalY
    pushl $val_fmt
    call _scanf
    addl $8, %esp
   
    pushl uservalY
    pushl $msgY
    call _printf
    addl $8, %esp
    
    
    pushl $uservalZ
    pushl $val_fmt
    call _scanf
    addl $8, %esp
   
    pushl uservalZ
    pushl $msgZ
    call _printf
    addl $8, %esp
    
    ret
