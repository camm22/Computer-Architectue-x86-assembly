#
# Program reads an integer value from user and print them on console.
#
# Date: 20/03/2023
#
# Author: WZ
#
#

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
	.asciz	"The value is %d \n"	# another message to print

val_fmt: 
	.asciz	"%d"             # format string for reading int value

userval:	
	.word 0				# user integer

.extern _printf
.extern _scanf
.text                           # .text section declaration

.global _main

#_start:        

_main:

/* reading an integer with scanf function form C library */

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

#   printing user value  

	movl (userval),%eax # put user number  into %eax

# put printf parameters on the stack in reverse order

	pushl %eax		# parameter 2 - value that we want to print
	pushl $msg2		# parameter 1 - format string that tell what print
	call _printf
	
	addl $8,%esp	# clean up the stack. this time we put 2 longwords (8 bytes)
					# so we need to take them out from stack


/* end program */

    movl $0x00, %eax
    ret
