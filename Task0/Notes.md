## Sources
- https://www.youtube.com/watch?v=HCfq44NNBaU
- https://www.youtube.com/watch?v=9FTUa-2eIDU
- https://github.com/Hashu-17/blinky-arduino-baremetal/
- https://www.youtube.com/watch?v=j4xw8QomkXs
- https://blog.stackademic.com/blinking-into-the-heart-of-arduino-8b552976592c
- https://captdam.com/avrld/en
- https://stackoverflow.com/questions/77347544/avr-creating-and-understanding-minimum-startup-code-and-linker-scripts-from-scr
- https://electronics.stackexchange.com/questions/408115/how-does-avr-gcc-linker-know-to-put-the-datasection-at-0x800100-rather-than
- https://sourceware.org/binutils/docs/ld.html#Miscellaneous-Commands


### Tooling / Commands

```
brew tap osx-cross/avr
brew install avr-gcc
brew install avrdude
brew install make
brew install minicom
brew install avr-gdb
```

#### figure out which port the arduino is connected to
- `ls /dev/cu.*`

```
Reading 146 bytes for flash from input file blinky.hex
Writing 146 bytes to flash
Writing | ################################################## | 100% 0.06 s 
Reading | ################################################## | 100% 0.03 s 
146 bytes of flash verified

Avrdude done.  Thank you.
```