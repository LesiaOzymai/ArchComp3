SDK_PREFIX?=arm-none-eabi-
CC = $(SDK_PREFIX)gcc
OBJCOPY = $(SDK_PREFIX)objcopy
QEMU = qemu-system-gnuarmeclipse
MCU = STM32F407VG
CPU_CC = cortex-m4
TARGET = firmware
TCP_ADDR = 1234

OBJS = start.o lab1.o

all: $(TARGET).elf

%.o: %.S
  $(CC) -x assembler-with-cpp -c -O0 -g3 -mcpu=$(CPU_CC) -Wall $< -o $@

$(TARGET).elf: $(OBJS)
  $(CC) $(OBJS) -mcpu=$(CPU_CC) -Wall --specs=nosys.specs -nostdlib -lgcc -T./lscript.ld -o $@
  $(OBJCOPY) -O binary -F elf32-littlearm $@ $(TARGET).bin

qemu:
  $(QEMU) --verbose --verbose --board STM32F4-Discovery --mcu $(MCU) -d unimp,guest_errors --image $(TARGET).bin --semihosting-config enable=on,target=native -gdb tcp::$(TCP_ADDR) -S

clean:
  rm -f *.o *.elf *.bin
