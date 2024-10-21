##########################################################################
#
# Program: hello
#
# Date: 08/03/2023
#
# Author: WZ
#
# Purpose: A simple hello world program in x86 assembly for GAS
#
##########################################################################

.data                            # .data section declaration
msg:
.asciz "Hello, world!\n" 	# Declare a label "msg" which has
                                	# string we want to print.

.extern _printf

.text                            # .text section declaration
.global _main # entry point 
_main:
        movl %esp, %ebp # for correct debugging

        pushl $msg      # put pfintf() function parameter (pointer to the msg string) on the stack
        call _printf    # invoking the printf() function

        addl $4, %esp   # before calling printf we put 1 longword (4 bytes) on the stack, now we must take them out 

# end program
        movl $0x00, %eax
        ret
