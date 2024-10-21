###########################################################################
#
# Program: condition1
#
# Program reads an integer value from user and check if it is lower than zero.
#
# Date: 18/10/2023
#
# Author: WZ
#
###########################################################################


.global  _start                 # we must export the entry point to the
                                # ELF linker or loader. Conventionally,
                                # they recognize _start as their entry
                                # point but this can be overridden with
                                # ld -e "label_name" when linking.

.data                           # .data section declaration

msg:
    .asciz	"Type any integer value. \n" # Declare a null terminated 
                                # label "msg" which has string we want to print.
                            
msg2:	
	.asciz	"The value %d is lower than zero\n"	# another message to print

val_fmt: 
	.asciz	"%d"    # format string for reading int value

userval:	
	.int 0		# user 32-bit integer value


.extern _printf
.extern _scanf

.text                           # .text section declaration

.global _main
   
_main:

        movl %esp, %ebp # for correct debugging
        
/* printing prompt message with printf function form C library */

	pushl $msg		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

# clean up the stack after calling 

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

/*  call "scanf ("%d",userval)" to read integer value and place them as userval   */

	pushl $userval	# parameter 2 - pointer to place user value
	pushl $val_fmt 	# parameter 1 - format string
	call _scanf

# clean up the stack after calling scanf 

	addl $8,%esp 	# we put 2 longword (8 bytes) on the stack, now we must take them out

#####################################

	movl (userval),%eax # put user number  into %eax	

#   if (userval >0 )	

#	movl $0,%ebx
	cmpl $0,%eax			# compare %eax with %ebx=0 , set the condition flags
	
# 
	jge	end_program			# if %eax is greater or equal %ebx -> goto end_program

#   printing a message that the userval is less than zero.

# put printf parameters on the stack in reverse order
	movl (userval),%eax # put user number again into %eax
	
	pushl %eax		# parameter 2 - value that we want to print
	pushl $msg2		# parameter 1 - format string that tell what print
	call _printf
	
	addl $8,%esp	# clean up the stack. this time we put 2 longwords (8 bytes)
					# so we need to take them out from stack


end_program:
/* end program */
                          
        movl $0x00, %eax
        ret
                            
