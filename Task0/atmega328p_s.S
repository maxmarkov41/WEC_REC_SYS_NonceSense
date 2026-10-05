.section .vectors, "ax", @progbits

.global __vectors
.global RESET

__vectors:
    jmp RESET
    jmp DEFAULT_ISR
    jmp DEFAULT_ISR
    jmp DEFAULT_ISR
    jmp DEFAULT_ISR
    jmp DEFAULT_ISR
    jmp DEFAULT_ISR
    jmp DEFAULT_ISR
    jmp DEFAULT_ISR
    jmp DEFAULT_ISR
    jmp DEFAULT_ISR
    jmp __vector_11

.text

RESET:
    ldi r16, hi8(__stack)
    out 0x3E, r16

    ldi r16, lo8(__stack)
    out 0x3D, r16

    clr r1

    call main
hang:
    rjmp hang

DEFAULT_ISR:
    rjmp DEFAULT_ISR