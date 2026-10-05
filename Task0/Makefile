MCU := atmega328p

BUILD := Build
TARGET := $(BUILD)/blinky

CC := avr-gcc
OBJCOPY := avr-objcopy
AVRDUDE := avrdude

PORT := /dev/cu.usbserial-1130
BAUD := 115200

CFLAGS := -mmcu=$(MCU) -Wall -Wextra -O2 -std=c11 -ffreestanding

LDFLAGS := -mmcu=$(MCU) \
           -nostdlib \
           -nostartfiles \
           -Wl,-T,atmega328p_ld.ld \
           -Wl,-Map,$(TARGET).map

.PHONY: all clean flash

all: $(TARGET).elf $(TARGET).hex $(BUILD)/main.asm

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/main.o: main.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/main.asm: main.c | $(BUILD)
	$(CC) $(CFLAGS) -S $< -o $@

$(BUILD)/startup.o: atmega328p_s.S | $(BUILD)
	$(CC) -mmcu=$(MCU) \
	      -Wa,-adhln=$(BUILD)/startup.asm \
	      -c $< -o $@

$(TARGET).elf: $(BUILD)/main.o $(BUILD)/startup.o atmega328p_ld.ld
	$(CC) $(LDFLAGS) \
	      $(BUILD)/startup.o \
	      $(BUILD)/main.o \
	      -o $@

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

flash: $(TARGET).hex
	$(AVRDUDE) -c arduino \
	           -p m328p \
	           -P $(PORT) \
	           -b $(BAUD) \
	           -U flash:w:$<

clean:
	rm -rf $(BUILD)