#
# fpucircle.asm
# Program calculate the circumference of a circle with given radius
#
# Date: 25/10/2023
#
# Author: Camille Bordes
#
#

.global  _start                 # we must export the entry point to the
                                # ELF linker or loader. Conventionally,
                                # they recognize _start as their entry
                                # point but this can be overridden with
                                # ld -e "label_name" when linking.

.data                           # .data section declaration

info_msg:
    .asciz	"Circle circumference calculator. \n"	# Declare a null terminated 
											# label "msg" which has string we want to print.
msg_radius:
    .asciz	"Radius: \n"	# Declare a null terminated 
											# label "msg" which has string we want to print.
result_msg:
    .asciz	"Circumference of a circle with radius %f is %f .\n"	# Declare a null terminated 

result_msg2:
    .asciz	"Area of a circle with radius %f is %f .\n"	# Declare a null terminated 


									# label "msg" which has string we want to print.
double_fmt: 
	.asciz	"%lf"    	# format string for reading .double value

two:	.int 2			# constant value 2
radius:	.double 0.5		# radius value
result:	.double 1022.6		# result

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
	pushl $msg_radius	# pfintf parameter (pointer to the prompt string) on the stack
	call _printf			# 

	# clean up the stack after calling printf

	addl $4,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out

/*  call "scanf ("%lf",val1)" to read integer value and place them as val1   */

	pushl $radius			# parameter 2 - pointer to place radius value
	pushl $double_fmt 		# parameter 1 - pointer to format string
	call _scanf

# clean up the stack after calling scanf 

	addl $8,%esp 			# we put 2 longword (8 bytes) on the stack,
							# now we must take them out

/* calculating using FP unit*/

	finit			# initialize FP unit - always remember to do it before executing any FPU instruction

	fldl (radius)		# radius -> %st(0) 
	fldpi			# PI number -> %st(0) ; automaticaly  radius->%st(1)
	fildl (two)		# load into %st(0) number 2 and convert it to a extended double
				# now FPU registers contain:
				# %st(0)=2.0 
				# %st(1)= PI
				# %st(2)=radius
						
# calculating 2 * PI * radius

	fmul %st(1),%st(0)	# %st(0)=%st(0)* %st(1) 2*PI
	
	fmul %st(2),%st(0)	# %st(0)=%st(0)* %st(1) 2*PI * radius
	
	fstl (result)		#  store result:  %st(0) -> (result)
	
# printing result value 
# printf ("Circumference of a circle with radius %f is %f .\n",radius,result)
#- %f format string expects .double value (not .float) as argument

# remember to place printf args on the stack in reverse order
# double value ocuppies 8 bytes, to put them into the stack we split it into two 32-bit parts

#  second argument for a result_msg (circumference)

	movl (result+4),%eax		# most significant lword of 'result'
	pushl %eax

	movl (result),%eax		# less significant lword of 'result' go first
	pushl %eax

#  first argument for a result_msg (radius)	

	movl (radius+4),%eax		# most significant lword of 'radius'
	pushl %eax

	movl (radius),%eax		# less significant lword of 'radius' go first
	pushl %eax
	
	pushl $result_msg		# put pfintf parameter (pointer to the prompt string) on the stack
	call _printf		# 

# clean up the stack after calling printf %f

	addl $20,%esp 			# we put 5 longword (20 bytes) on the stack,
					# now we must take them out
	

        finit
        fldl (radius)
        fldl (radius)
        fldpi
        
        fmul %st(1), %st(0)
        fmul %st(2), %st(0)
        
        fstl (result)
        
        
	movl (result+4),%eax		
	pushl %eax

	movl (result),%eax		
	pushl %eax



	movl (radius+4),%eax		
	pushl %eax

	movl (radius),%eax		
	pushl %eax
	
	pushl $result_msg2		
	call _printf		


	addl $20,%esp 		


/* end program */

end_program:

        movl $0x00, %eax
        ret
