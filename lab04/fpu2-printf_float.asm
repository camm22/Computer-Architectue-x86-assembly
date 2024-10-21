#
# Program show basic FP number represenation (.float and .double).
# print float type varibele with _printf function call
#
# Date: 10/04/2023
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
	.asciz	"The size of double is %d .\n"	# another message to print

msg2:	
	.asciz	"The size of float is %d .\n"	# another message to print

msg3:	
	.asciz	"Enter any non-integer number:"	# another message to print

msg4:	
	.asciz	"You entered: %f .\n"	# another message to print

msg5:	
	.asciz	"Your .float number is represented by: %x HEX value.\n"	# another message to print

float_fmt: 
	.asciz	"%f"    	# format string for reading .float value

double_fmt: 
	.asciz	"%lf"    	# format string for reading .double value

user_float:	
	.float 4.17					# user single precision float value
    
float_len = . - user_float      # "float_len" will calculate the current
                                # offset minus the "user_float" offset.
                                # this should give us the size of
                                # "user_float".
user_double:	
	.double 4.17				# user user double precision float value

double_len = . - user_double    # "double_len" will calculate the current
                                # offset minus the "user_double" offset.
                                # this should give us the size of
                                # "user_double".

.extern _printf
.extern _scanf

.text                   # .text section declaration

.global _main
_main:

/* printing info message with printf function form C library */
/* printf ("Float and double representation. \n");*/

	pushl $info_msg		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf			# 

# clean up the stack after calling printf

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

/* printing lenght of float i memory using  printf function form C library */
/* printf ("The size of float is %d .\n",float_len); */

	movl $float_len,%eax

	pushl %eax
	pushl $msg2		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

# clean up the stack after calling printf witch parameter

	addl $8,%esp 	# we put 2 longword (8 bytes) on the stack, now we must take them out

/* printing prompt message with printf function form C library */
/* printf ("Enter any non-integer number:"); */

	pushl $msg3		# put pfintf parameter (pointer to the msg3 string) on the stack
	call _printf		# 

/*  call "scanf ("%f",userval)" to read integer value and place them as userval   */

	pushl $user_float	# parameter 2 - pointer to place user value
	pushl $float_fmt 	# parameter 1 - pointer to format string
	call _scanf

# clean up the stack after calling scanf 

	addl $8,%esp 			# we put 2 longword (8 bytes) on the stack,
							# now we must take them out

# printing user_float value - %f format string expects .double value (not .float) as argument
/* printf ("You entered: %f .\n", user_float); */

# remember to place printf args on the stack in reverse order

#  	single precision float number must be converted to double before it can be printed by printf (%f);
#	FPU is used to do this conversion

	flds (user_float)		# load user_float variable into FPU %st(0) register 
					# (it's automaticaly converted from 32-bit single precision float
					# into internal FPU 80-bit extended double)

	fstl (%esp)			# store value form FPU %st(0) as double directly at the top of the stack
					# (it's automaticaly converted from  
					# internal FPU 80-bit extended double into 64-bits double)

# alternate version - user_double variable will be used to store converted user_float value
#	flds (user_float)		# load user float to FPU %st(0) register 
#					# (it's automaticaly converted from 32-bit single precision float
#					# into internal FPU 80-bit extended double)
#	fstl (user_double)		# store value form FPU %st(0) as user_double
#					# (it's automaticaly converted from  
#					# internal FPU 80-bit extended double into 64-bits double)
#							
## double type value ocuppies 64 bits (8 bytes) in memory
## to put them into the stack it must be splited into two 32-bits parts
#
#	movl (user_double+4),%eax	# less significant 32 bits (word)
#	pushl %eax
#	movl (user_double),%eax		# most significant 32 bits (lword)
#	pushl %eax
	
	pushl $msg4		# put pfintf parameter (pointer to the msg4 string) on the stack
	call _printf		# 

# clean up the stack after calling printf (%f);

	addl $12,%esp 			# we put 3 longword (12 bytes) on the stack,
							# now we must take them out

# printing hexadecimal representation of user_float value
# printf ("Your .float number is represented by: %x HEX value.\n", user_float)

	movl (user_float),%eax			# 
	pushl %eax
	
	pushl $msg5		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

# clean up the stack after calling printf %x

	addl $8,%esp 			# we put 2 longword (8 bytes) on the stack,
							# now we must take them out
        ret
        
/* end program */

end_program:

        movl $0x00, %eax
        ret
