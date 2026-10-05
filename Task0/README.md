# Task 0 — Bare-Metal Blinky on ATmega328P

## Overview

This task implements a bare-metal 1 Hz LED blink on an **ATmega328P**, without using Arduino APIs, HALs, vendor startup code, or vendor linker scripts.

The program directly accesses the ATmega328P hardware registers and uses a custom:

- startup assembly file
- linker script
- Makefile

The program was built and flashed entirely from the terminal using the AVR GCC toolchain and was tested on hardware.

## Project Structure

```text
Task0/
├── main.c
├── atmega328p_s.S
├── atmega328p_ld.ld
├── Makefile
├── Notes.md
└── Build/
    ├── main.o
    ├── main.asm
    ├── startup.o
    ├── startup.asm
    ├── blinky.elf
    ├── blinky.hex
    └── blinky.map
```

`Build/` contains generated files and intermediate build artifacts.

## Hardware

Target MCU:

```text
ATmega328P
```

The LED is connected to **PB5**, which is Arduino Uno digital pin 13 on an Uno-compatible board.

The implementation assumes a **16 MHz CPU clock**.

## Implementation

### `main.c`

The C program directly defines the required ATmega328P register addresses instead of including device headers.

Timer1 is configured in:

- CTC (Clear Timer on Compare Match) mode
- `/256` prescaler
- Compare Match A interrupt enabled

The Timer1 Compare A interrupt toggles PB5.

The timer compare value is chosen so that the interrupt occurs approximately every 0.5 seconds. Since the ISR toggles the LED on every interrupt, one complete ON/OFF cycle takes approximately 1 second, producing a 1 Hz blink.

### `atmega328p_s.S`

This is the custom startup and interrupt-vector assembly.

It:

1. Provides the interrupt vector table.
2. Routes the Timer1 Compare A vector to `__vector_11`.
3. Initializes the stack pointer using the linker-defined `__stack` symbol.
4. Clears `r1`, as required by the AVR-GCC calling convention.
5. Calls `main()`.
6. Provides a default infinite-loop handler for unused interrupt vectors.

The reset flow is therefore:

```text
RESET
  ↓
Reset vector at 0x0000
  ↓
RESET
  ↓
Initialize stack pointer
  ↓
Clear r1
  ↓
main()
```

The Timer1 interrupt flow is:

```text
Timer1 Compare Match A
        ↓
TIMER1_COMPA vector
        ↓
__vector_11()
        ↓
Toggle PB5
        ↓
reti
```

### `atmega328p_ld.ld`

The custom linker script describes the ATmega328P memory layout:

```text
FLASH: 32 KB
SRAM:   2 KB
```

It places:

```text
.vectors → FLASH
.text    → FLASH
```

and defines:

```text
__stack
```

as the top of SRAM.

This allows the startup code to obtain the stack address from the linker rather than hard-coding the RAM size into the assembly file.

## Build

From the `Task0` directory:

```bash
make
```

The build uses:

```text
-Wall
-Wextra
-O2
-nostdlib
-nostartfiles
```

The generated ELF, HEX, object files, assembly listings, and linker map are placed in `Build/`.

## Flash

The serial port can be supplied when invoking `make flash`:

```bash
make flash PORT=/dev/cu.usbmodemXXXX
```

The Makefile uses `avrdude` to write `Build/blinky.hex` to the ATmega328P.

## Useful Inspection Commands

Disassemble the final ELF:

```bash
avr-objdump -d Build/blinky.elf
```

Inspect symbols:

```bash
avr-nm Build/blinky.elf
```

Inspect section layout:

```bash
avr-objdump -h Build/blinky.elf
```

Check the final size:

```bash
avr-size Build/blinky.elf
```

The linker map is available at:

```text
Build/blinky.map
```

## Result

The final program was successfully built and flashed to an ATmega328P using the custom startup code, linker script, and Makefile. The LED blink was verified on hardware.