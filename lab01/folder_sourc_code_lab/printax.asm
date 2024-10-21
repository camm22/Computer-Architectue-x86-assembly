#
# Program print an integer value from %eax register on console.
#
# Date: 20/03/2023
#
# Author: WZ
#
#

.data                           # .data section declaration

msg:
    .asciz    "Now we can easy print value of EAX register. \n" # Declare a label "msg" which has
                                # string we want to print.
 msg2:	
	.asciz "EAX value is %d \n"                      

.extern _printf
.text
.global _main
_main:
    # write your code here
    
 /* print string msg using printf function form C library */

	pushl $msg		# put pfintf parameter (pointer to the msg string) on the stack
	call _printf		# 

# clean up the stack after calling 

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

# printing %EAX contetnt - a number stored in %eax register

	movl $0x5AAB,%eax 	# put a hex value 55AB  into %eax

# put printf parameters on the stack in reverse order

	pushl %eax		# Parameter 2 - value that we want to print
	pushl $msg2		# Parameter 1 - format string that tell what print
	call _printf
	
	addl $8,%esp	# Clean up the stack. This time we put 2 longwords (8 bytes)
					# so we need to take them out from stack
 # end program   
    xorl  %eax, %eax
    ret
