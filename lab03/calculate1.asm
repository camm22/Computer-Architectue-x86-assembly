##########################################################################
#
# Program: calculate1
#
# Date: 18/03/2023
#
# Author: WZ
#
# Program reads an integer value a from user and  
# calculate the value of equation :
#  b = 4*a*a + 3*a -2
# and print them on console.
#
##########################################################################

.global  _start                 # we must export the entry point to the
                                # ELF linker or loader. Conventionally,
                                # they recognize _start as their entry
                                # point but this can be overridden with
                                # ld -e "label_name" when linking.

.data                           # .data section declaration

msg:
    .asciz	"Type value for a: " # Declare a null terminated 
                                # label "msg" which has string we want to print.
                            
msg2:	
	.asciz	"The result is %d \n"	# another message to print

val_fmt: 
	.asciz	"%d"             # format string for reading int value

userval:	
	.word 0				# user 32-bit integer

.extern _printf
.extern _scanf

.text                           # .text section declaration

.global _main
   
_main:

        movl %esp, %ebp # for correct debugging
        
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

# calculatng the result of equation :
#  b = 4*a*a + 3*a -2
		
		movl (userval),%eax      # put user number into %eax
		movl $3,%ebx
		mull %ebx 		# %eax=%eax * %ebx (%eax=3*a)
		movl %eax,%ebx		# 3*a -> %ebx
		movl (userval),%eax      # put again user number into %eax
		mull %eax		# 
		movl $4,%ecx		# 
		mull %ecx		# $eax=4*a*a
		addl %ebx,%eax		# $eax=4*a*a + 3*a
		subl $2,%eax		# $eax=4*a*a + 3*a -2
		
#####################################

# printing calculated value from %eax

# put printf parameters on the stack in reverse order

	pushl %eax		# parameter 2 - value that we want to print
	pushl $msg2		# parameter 1 - format string that tell what print
	call _printf
	
	addl $8,%esp	# clean up the stack. this time we put 2 longwords (8 bytes)
					# so we need to take them out from stack


/* end program */
                          
        movl $0x00, %eax
        ret
        
        
            pushl $msgY
    call _printf
    addl $4, %esp
    
    pushl $uservalY
    pushl $val_fmt
    call _scanf
    addl $8, %esp
    
    pushl $msgZ
    call _printf
    addl $4, %esp
    
    pushl $uservalZ
    pushl $val_fmt
    call _scanf
    addl $8, %esp