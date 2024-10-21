# 1          Integer variables in memory

## 1.1         Word (16 bit data)

![[Pasted image 20231129134813.png]]
We can see that data (.word 0xBEEF, 54321,27 ,-34,-31245) is stored to memory address 0x402000. As the values are word types, they are stored on 2 bytes, so you can see that at each 2-byte jump, the hexadecimal numbers are written backwards.

## 1.2         long word (32-bit data)

![[Pasted image 20231129135907.png]]

We can see that data (num_i32: .long 0xABCDDEAF and .long 1678 and num_i32s: .long -24786) is stored to memory address 0x402000. As the values are long types, they are stored on 4 bytes, so we can see that at each 4-byte jump, the hexadecimal numbers are written backwards 


## 1.3        quad word (.quad)

![[Pasted image 20231129180045.png]]
We can see that the numbers are stored one after the other in memory. The first two bytes store the word number, then the remaining 8 bytes store the first quad number. The .align 8 function then fills in the bytes of the previous line, aligning the next quad numbers over 8 bytes in a row.

![[Pasted image 20231129182227.png]]
Memory representation is similar. The negative quad is implemented in its negative heaxadecimal form using the complement technique and the addition of one bit.

## 1.4         positive and negative value of word, long word quad world

![[Pasted image 20231129184257.png]]
We see that it's always the same: negative words are stored on 2 bytes, long words on 4 bytes and quad words on 8 bytes. Here you can see them lined up one after the other.


## 1.5         .tfloat  number

![[Pasted image 20231129221255.png]]
We can see here that the tfloat number need 10 octets to be sotored in memory but i don't undestand how and why it is stored like that.

# 2         String type variable

![[Pasted image 20231130003124.png]]
The strings are stored in memory like this: 1 byte = 1 character, each after the other, and we can see that there are the characters spaces (0x20) and or \n (0x0a).

The difference is that asciz type strings add an end of string character (0x00), while ascii type strings do not.

![[Pasted image 20231130003624.png]]
Here you can see my full name !
