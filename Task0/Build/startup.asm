   1               	# 1 "atmega328p_s.S"
   1               	.section .vectors, "ax", @progbits
   0               	
   0               	
   2               	
   3               	.global __vectors
   4               	.global RESET
   5               	
   6               	__vectors:
   7 0000 0C94 0000 	    jmp RESET
   8 0004 0C94 0000 	    jmp DEFAULT_ISR
   9 0008 0C94 0000 	    jmp DEFAULT_ISR
  10 000c 0C94 0000 	    jmp DEFAULT_ISR
  11 0010 0C94 0000 	    jmp DEFAULT_ISR
  12 0014 0C94 0000 	    jmp DEFAULT_ISR
  13 0018 0C94 0000 	    jmp DEFAULT_ISR
  14 001c 0C94 0000 	    jmp DEFAULT_ISR
  15 0020 0C94 0000 	    jmp DEFAULT_ISR
  16 0024 0C94 0000 	    jmp DEFAULT_ISR
  17 0028 0C94 0000 	    jmp DEFAULT_ISR
  18 002c 0C94 0000 	    jmp __vector_11
  19               	
  20               	.text
  21               	
  22               	RESET:
  23 0000 00E0      	    ldi r16, hi8(__stack)
  24 0002 0EBF      	    out 0x3E, r16
  25               	
  26 0004 00E0      	    ldi r16, lo8(__stack)
  27 0006 0DBF      	    out 0x3D, r16
  28               	
  29 0008 1124      	    clr r1
  30               	
  31 000a 0E94 0000 	    call main
  32               	hang:
  33 000e 00C0      	    rjmp hang
  34               	
  35               	DEFAULT_ISR:
  36 0010 00C0      	    rjmp DEFAULT_ISR...
