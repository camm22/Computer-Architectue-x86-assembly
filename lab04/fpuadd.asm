# fpuadd.asm
# Program show simple FP addition
#
# Date: 25/10/2023
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
    .asciz	"FP ADD demo. \n"	# Declare a null terminated 
											# label "msg" which has string we want to print.
msg1:
    .asciz	"First value: "	# Declare a null terminated 
											# label "msg" which has string we want to print.
msg2:
    .asciz	"Second value: "	# Declare a null terminated 
											# label "msg" which has string we want to print.

result_msg:
    .asciz	"Result of the oparation: %f \n"	# Declare a null terminated 
											# label "msg" which has string we want to print.

double_fmt: 
	.asciz	"%lf"    	# format string for reading .double value

val1:	.double 10.5			# first argument
val2:	.double 1022.6			# second argument
result:	.double -1.0			# result of the operation


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


/* get first value*/
	pushl $msg1		# pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

	# clean up the stack after calling printf

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

/*  call "scanf ("%lf",val1)" to read integer value and place them as val1   */

	pushl $val1		# parameter 2 - pointer to place user value
	pushl $double_fmt 	# parameter 1 - pointer to format string
	call _scanf

# clean up the stack after calling scanf 

	addl $8,%esp 			# we put 2 longword (8 bytes) on the stack,
							# now we must take them out

/* get second value*/
	pushl $msg2		# pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

	# clean up the stack after calling printf

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out
	
/*  call "scanf ("%lf",val2)" to read integer value and place them as val2   */

	pushl $val2		# parameter 2 - pointer to place user value
	pushl $double_fmt 	# parameter 1 - pointer to format string
	call _scanf

# clean up the stack after calling scanf 

	addl $8,%esp 			# we put 2 longword (8 bytes) on the stack,
							# now we must take them out

/* doing calculations using FP unit*/

	finit			# initialize FP unit - always remember to do it before executing any FPU instruction
	fldl	(val1)		# val1 -> %st(0) 
	fldl	(val2)		# val2-> %st(0) ; automaticaly  val1->%st(1)
						
	fadd %st(1),%st(0)	# %st(0)=%st(0)+ %st(1) 
	
	fstl (result)			#  result = %st(0)
	
# printing result value - %f format string expects .double value (not .float) as argument

# remember to place printf args on the stack in reverse order
# double value ocuppies 8 bytes, to put them into the stack we split it into 2 32-bit parts

	movl (result+4),%eax		# most significant lword of 'result'
	pushl %eax

	movl (result),%eax			# less significant lword of 'result' go first
	pushl %eax
	
	pushl $result_msg		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

# clean up the stack after calling printf %f

	addl $12,%esp 			# we put 3 longword (12 bytes) on the stack,
							# now we must take them out
	


/* end program */

end_program:


    movl $0x00, %eax
    ret
