#define PORTB *((volatile unsigned char *)0x25)
#define DDRB *((volatile unsigned char *)0x24)
#define TCCR1A *((volatile unsigned char *)0x80)
#define TCCR1B *((volatile unsigned char *)0x81)
#define OCR1AH *((volatile unsigned char *)0x89)
#define OCR1AL *((volatile unsigned char *)0x88)
#define TIMSK1 *((volatile unsigned char *)0x6F)
// #define TIFR1 *((volatile unsigned char *)0x36)
#define TCNT1 *((volatile unsigned int *)0x84)

#define CS12 2
#define CS11 1
#define CS10 0

#define PORTB5 5
#define DDRB5 5

#define TOV1 0

#define OCIE1A 1
// #define OCF1A 1

#define COM1A1 7
#define COM1A0 6

#define WGM12 3 // CTC Mode

void __vector_11(void) __attribute__((signal, used, externally_visible));

void __vector_11(void)
{
    PORTB ^= (1 << PORTB5); // xor with 00100000
    // TIFR1 ^= (1 << OCF1A);  // Clear Timer1 Compare Match A Flag // xor with 0..10 | apparently a write one to clear register, so entering the interrupt vector clears the register?
}

int main()
{
    // Setting Timer1 Control Registers
    TCNT1 = 0;  // Initialize Timer1 Counter to 0
    TCCR1A = 0; // Initialize Timer1 Control Register A to 0
    TCCR1B = 0; // Initialize Timer1 Control Register B to 0

    // Store the value 15624 in OCR1A register
    OCR1AH = 31249 >> 8;
    OCR1AL = 31249 & 0xFF;

    // Clear Timer1 Compare Match A Flag
    // TIFR1 ^= (1 << OCF1A); // Clear Timer1 Compare Match A Flag

    TCCR1B |= (1 << WGM12) | (1 << CS12); // Set Timer1 Clock Prescaler to 256 and CTC Mode

    DDRB |= (1 << DDRB5); // Set PORTB5 as output (Pin 13 on Arduino Uno)

    // Setting Interrupts
    __asm__ __volatile__("cli" ::: "memory"); // Disable Global Interrupt

    TIMSK1 = (1 << OCIE1A); // Enable Timer1 Compare Match A Interrupt

    __asm__ __volatile__("sei" ::: "memory"); // Enable Global Interrupt


    // Set PORTB5 to High
    PORTB |= (1 << PORTB5); // Set PORTB5 to High


    // Infinite Loop
    while (1);
}

