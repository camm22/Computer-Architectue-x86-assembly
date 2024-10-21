#
# Program show basic FP number represenation (.float and .double).
#
# Date: 26/10/2023
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

info_msg:
    .asciz	"Float and double representation. \n"	# Declare a null terminated 
											# label "msg" which has string we want to print.
msg1: 
        .asciz "The size of float is %d .\n"     # another message to print

msg2:	
	.asciz	"The size of double is %d .\n"	# another message to print

msg3:	
	.asciz	"Enter any non-integer number:"	# another message to print

msg4:	
	.asciz	"\nYou entered: %f .\n"	# another message to print

msg5:	
	.asciz	"Your .double number is represented by: %x %x HEX value.\n"	# another message to print

msg6:	
	.asciz	"Your .float number is represented by: %x HEX value.\n"

float_fmt: 
	.asciz	"%f"    	# format string for reading .float value

double_fmt: 
	.asciz	"%lf"    	# format string for reading .double value

user_float:	
	.float 12.3				# user single precision float value
    
float_len = . - user_float      # "len" will calculate the current
                                # offset minus the "msg" offset.
                                # this should give us the size of
                                # "msg".msg:
user_double:	
	.double 12.3		# user user double precision float value

double_len = . - user_double    # "len" will calculate the current
                                # offset minus the "msg" offset.
                                # this should give us the size of
                                # "msg".msg:
.extern _printf
.extern _scanf
.text                   # .text section declaration

.global _main
_main:
        movl %esp, %ebp # for correct debugging    

/* printing info message with printf function form C library */

	pushl $info_msg		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf			# 

# clean up the stack after calling 

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

/* printing lenght of float i memory using  printf function form C library */

	movl $float_len,%eax
	
	pushl %eax
	pushl $msg1		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

# clean up the stack after calling printf witch parameter

	addl $8,%esp 	# we put 2 longword (8 bytes) on the stack, now we must take them out

/* printing lenght of float i memory using  printf function form C library */

	movl $double_len,%eax
	
	pushl %eax
	pushl $msg2		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

# clean up the stack after calling printf witch parameter

	addl $8,%esp 






/* printing prompt message with printf function form C library */

	pushl $msg3		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 
	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

/*  call "scanf ("%lf",userval)" to read integer value and place them as userval   */

	pushl $user_double	# parameter 2 - pointer to place user value
	pushl $double_fmt 	# parameter 1 - pointer to format string
	call _scanf

# clean up the stack after calling scanf 

	addl $8,%esp 			# we put 2 longword (8 bytes) on the stack,
							# now we must take them out

# printing user_double value - %f format string expects .double value (not .float) as argument

# remember to place printf args on the stack in reverse order
# double value ocuppies 8 bytes, to put them into the stack we split it into 2 32-bit parts


	movl (user_double+4),%eax		# most significant word 
	pushl %eax
	movl (user_double),%eax			# less significant word first
	pushl %eax
	
	pushl $msg4		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

# clean up the stack after calling printf %f

	addl $12,%esp 			# we put 3 longword (12 bytes) on the stack,
							# now we must take them out

# printing hexadecimal representation of user_double value
# printf ("Your .double number is represented by: %x %x HEX value.\n", MSW, LSW)

	movl (user_double),%eax			# less significant lword 
	pushl %eax
	movl (user_double+4),%eax		# this time most significant lword first
	pushl %eax
	
	pushl $msg5		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

# clean up the stack after calling printf %x %x

	addl $12,%esp 			# we put 3 longword (12 bytes) on the stack,
							# now we must take them out
	movl (user_float + 8),%eax		# most significant word 
	pushl %eax
	movl (user_float),%eax			# less significant word first
	pushl %eax
	
	pushl $msg4		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf
	addl $12,%esp 	


	movl (user_float),%eax				
	pushl %eax
	pushl $msg6		
	call _printf		
	addl $8,%esp 	



/* end program */

end_program:

        movl $0x00, %eax
        ret



