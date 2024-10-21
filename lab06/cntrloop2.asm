#counter loop x86 example - for loop
.data
loopcntr:  .long 0
startVal: .long 10  
endVal:   .long 39
incVal:   .long 3

msg:	
	.asciz	"loopcntr value is  %d \n"	# message to print

.text
.extern _printf
.global _main
_main:
      # standard program prologue
	pushl  %ebp
	movl %esp, %ebp #for correct debugging
# 	
	movl startVal, %ecx 	# start value of the loop counter ito %ecx
	movl %ecx, loopcntr
cntrloop:
           # loop condition
	movl loopcntr,%ecx   #restore loop couter i %ecx
        cmpl %ecx, endVal
	jle end_loop
    	
	#loop body begin	
        xorl %ecx,%ecx  # we may even destroy content of %ecx 

        # print current value of the loopcntr
	pushl loopcntr
        pushl $msg		# put pfintf parameter (pointer to the prompt string) on the stack
        call _printf		# 

# clean up the stack after calling 

	addl $8,%esp 	# we put 1 longword (4 bytes) on the stack, now we must take them out
 
        
                      # loop body end
        	movl loopcntr,%ecx   #restore loop couter i %ecx
 	# increase loopcntr by value of incVal
	addl incVal, %ecx	

	movl %ecx,loopcntr # uptade loop couter value
        movl loopcntr, %eax # for debug purpose - verify loopcntr value
	jmp  cntrloop

# finish the loop
end_loop:

# standard program epilogue   
    popl %ebp    
    xorl  %eax, %eax
    ret

