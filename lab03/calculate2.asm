##########################################################################
#
# Program: calculate2
#
# Date: 18/03/2023
#
# Author: WZ
#
# Program demonstrtes usage of div (divl, 32-bit division) instruction 
# and ilustrates the problem of accuracy of integer calculations

# Author: WZ
#
##########################################################################

.global  _start                 # we must export the entry point to the
                                # ELF linker or loader. Conventionally,
                                # they recognize _start as their entry
                                # point but this can be overridden with
                                # ld -e "label_name" when linking.

.data                           # .data section declaration

msg1:
    .asciz	"Value of (7/5)*5 is: %d \n"    # Declare a null terminated 
					       # label "msg1" which has string we want to print.
                            
msg2:	
	.asciz	"Value of (7*5)/5 is: %d \n"	# another message to print

val_a:	
	.int 0				# 32-bit integer result of (7/5)*5

val_b:	
	.int 0				# 32-bit integer result of (7/5)*5



.extern _printf
.extern _scanf

.text                           # .text section declaration

.global _main
   
_main:

        movl %esp, %ebp # for correct debugging

# calculatng the result of equation 
#  a = (7/5)*5

# 		in x_86_32 the divident by default can only be in %edx:%eax 
#		more significant part is in %edx and less significant part is in %eax
#		divider must be in any other register - we will use mostly %ebx 
#		the result is stored in %eax
		
		movl $0,%edx		#  %edx - more significant part of the divident
		movl $7,%eax 		#  %eax=7	
		movl $5,%ebx		#  %ebx=5

		divl %ebx		# %eax=%eax / %ebx 
		movl $5,%ebx		# %ebx=5

		mull %ebx		# %eax= %eax * %ebx (result (7/5)*5)
		
		movl %eax,(val_a)	# store result in memory

# print the result
		
		pushl %eax		# parameter 2 - value that we want to print
		pushl $msg1		# parameter 1 - format string that tell what print
		call _printf
	
		addl $8,%esp	# clean up the stack. this time we put 2 longwords (8 bytes)
						# so we need to take them out from stack

# calculatng the result of equation 
#  b = (7*5)/5
		
		movl $0,%edx		# %edx - more significant part of the divident
		movl $7,%eax 		# %eax=7	
		movl $5,%ebx		# %ebx=5
		mull %ebx			# %eax= %eax * %ebx (7*5)
		movl $5,%ebx		# %ebx=5
		divl %ebx			# %eax=%eax / %ebx (7*5)/5
		movl %eax,(val_b)	# store result in memory
				
# print the result
		
		pushl %eax		# parameter 2 - value that we want to print
		pushl $msg2		# parameter 1 - format string that tell what print
		call _printf
	
		addl $8,%esp	# clean up the stack. this time we put 2 longwords (8 bytes)
						# so we need to take them out from stack

/* end program */
                          
        movl $0x00, %eax
        ret
        
                            
        