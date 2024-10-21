#
# fpucond.asm
# Program demonstarte conditional constructions with FPoperations
# It determines relation between 2 FP numbers  
#
## Date: 25/10/2023
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
    .asciz	"FP condition demo. \n"	# Declare a null terminated 
											# label "msg" which has string we want to print.
msg1:
    .asciz	"First value (val1): "	# Declare a null terminated 
											# label "msg" which has string we want to print.
msg2:
    .asciz	"Second value (val2): "	# Declare a null terminated 
											# label "msg" which has string we want to print.

result_msg:
    .asciz	"Result of the oparation: %f \n"	# Declare a null terminated 
												# label "msg" which has string we want to print.

msg_equal:
    .asciz	"\nVal2 equals val1. \n "	# Declare a null terminated 
									# label "msg" which has string we want to print.
msg_greater:
    .asciz	"\nVal2 is greater than val1. \n "	# Declare a null terminated 
												# label "msg" which has string we want to print.
msg_lower:
    .asciz	"\nVal2 is lower than val1. \n "	# Declare a null terminated 
												# label "msg" which has string we want to print.


double_fmt: 
	.asciz	"%lf"    	# format string for reading .double value

val1:	.double 10.5			# first argument
val2:	.double 1022.6			# second argument
result:	.double -1.0			# result of the operation
zero:	.double	0.0				# constant 0

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

	pushl $val1			# parameter 2 - pointer to place user value
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

	pushl $val2			# parameter 2 - pointer to place user value
	pushl $double_fmt 	# parameter 1 - pointer to format string
	call _scanf

# clean up the stack after calling scanf 

	addl $8,%esp 			# we put 2 longword (8 bytes) on the stack,
							# now we must take them out

/* doing calculation using FP unit*/

	finit			# initialize FP unit - always remember to do it befora executing any FPU instruction

# 
	fldl	(val1)		# val1 -> %st(0) 
	fldl	(val2)		# val2-> %st(0) ; automaticaly  val1->%st(1)
						
# 	compare 	
	fcomi %st(1), %st(0)	# compare %st(0) with %st(1) and set CPU conditon codes
				# we can compare only %st(0) with any other %st(n) registers

# if there is a need to use other comparision insruction (e.g. FCOM), it must be remembered 
# that they set FPU condition codes only
# to use conditional jump instructions, the condition codes from FPU status register 
# must be manually copied into CPU condition codes located in EFLAGS register
# the code below shows how to do it
#
#	fcom %st(1)			# compare st(0) with st(1) and set FPU Cond. Codes
#	fstsw %ax			# copy FPU status regster (with cond. codes)to %ax
#	sahf				# copy %ah register into CPU EFLAGS -> CPU cond. codes now equal FPU cond. codes

# now we can use conditional jumps, but only je, jne, ja, jae, jb, jbe
	ja greater		# if %st(1) is above st(0)
	je equal


# if val1 is not equal nor above must be lower than val2

lower: 	
	# print  lower message

	pushl $msg_lower		# pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

	# clean up the stack after calling printf

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

	jmp end_compare 
	
equal:
	#print  equal
	pushl $msg_equal		# pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

	# clean up the stack after calling printf

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

	jmp end_compare

greater:
	#print  greater
	pushl $msg_greater		# pfintf parameter (pointer to the prompt string) on the stack
	call _printf				# 

	# clean up the stack after calling printf

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

	
end_compare:


/* end program */

end_program:

        movl $0x00, %eax
        ret
