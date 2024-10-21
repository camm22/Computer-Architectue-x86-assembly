#counter loop x86 example
.data
loopcntr:  .long 0
startVal: .long 10  
endVal:   .long 20
incVal:   .long 2

.text
.global _main
_main:
      # standard program prologue
	pushl  %ebp
	movl %esp, %ebp #for correct debugging
	
	movl startVal, %ecx 	# start value of the loop counter ito %ecx
	movl %ecx, loopcntr
cntrloop:
        	
	#loop body	
        xorl %ecx,%ecx  # we may even destroy content of %ecx 
        # loop body end
        # loop condition
	movl loopcntr,%ecx   #restore loop couter i %ecx
        cmpl %ecx, endVal
	jle end_loop
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

