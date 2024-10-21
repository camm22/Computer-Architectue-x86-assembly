.global _start

.data

#.word 0xBEEF, 54321,27 ,-34,-31245

#num_i32: .long 0xABCDDEAF
#         .long 1678

#num_i32s: .long -24786


# 64-bit integer data
#.word 0x55aa
#.quad 0xABCDDEAF12345678
#.align 8
#.quad 0xDEAFBEEF87654321
#.quad -1234567891011

#.word -5
#.long -123456
#.quad -1234567891011

#.tfloat 23.7


#fullname:
#    .long 0x4d617474    # 'C' 'a' 'm' 'i'
#    .long 0x656f204c    # 'l' 'l' 'e ' ' '
 #   .long 0x616d6265    # 'B' 'o' 'r' 'd'
 #   .long 0x7274        # 'e' 's'
  #  .long 0x0           # Null terminator


#val:    .word 0xBAB
#         .long 0xbeefdeaf
  #       .word -88


.quad 0xadacacad55aabeef

.text
.global _main
_main:
    movl %esp, %ebp
    nop
    
    
        
    xorl  %eax, %eax
    ret
