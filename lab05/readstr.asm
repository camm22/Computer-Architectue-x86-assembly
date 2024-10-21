##########################################################################
#
# Program: readstr
#
# Date: 10/10/2023
#
# Author: WZ
#
# Purpose: read string demo in x86 assembly for GAS
#
##########################################################################

.data                            # .data section declaration
msg:
.asciz "Type any text. \n" 	# Declare a label "msg" which has
                                	# string we want to print.
msg2:
.ascii "Your text: %s" 	        # Declare a label "msg" which has

msg3:
.asciz "Your text: %s"                             
                                                                
                                                                                                
                                                                                                                                                                	# string we want to print.
str_fmt: 
	.asciz	"%s"             # format string for reading string value
               

.bss
buffer: .space 100              # 100 bytes buffer for user string

.extern _printf
.extern _scanf

.text                            # .text section declaration
.global _main # entry point 
_main:
        movl %esp, %ebp # for correct debugging

        pushl $msg      # put pfintf() function parameter (pointer to the msg string) on the stack
        call _printf    # invoking the printf() function

        addl $4, %esp   # before calling printf we put 1 longword (4 bytes) on the stack,
                        # now we must take them out 

        push $buffer    # 2nd argument for scanf - buffer for user string 
        push $str_fmt   # 1st argument of scanf - format string 
        call _scanf     # invoking the scanf() function

        addl $8, %esp   # before calling scanf we put 2 longword (8 bytes) on the stack,
                        # now we must take them out 

        push $buffer
        push $msg2
        call _printf

        addl $8, %esp   # before calling printf we put 2 longword (8 bytes) on the stack, now we must take them out 

# end program
        movl $0x00, %eax
        ret
