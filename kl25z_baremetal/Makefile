#
# What am I building? → firmware.elf / firmware.bin
# With what tools? → arm-none-eabi-gcc
# For what CPU? → Cortex-M0+ (KL25Z)
# Where do outputs go? → build/

# ===== Project =====
TARGET := firmware
BUILD  := build

# ===== Toolchain =====
CC      := arm-none-eabi-gcc
OBJCOPY := arm-none-eabi-objcopy
SIZE    := arm-none-eabi-size

# ===== MCU DEFINITION =====
CPU     := cortex-m0plus
DEFS    := -DCPU_MKL25Z128VLK4

# ===== Paths =====
CMSIS_CORE   := cmsis/Core/Include
CMSIS_DEV    := cmsis/Device/NXP/MKL25Z4

INCLUDES := \
  -I. \
  -I$(CMSIS_CORE) \
  -I$(CMSIS_DEV)

# ===== Flags =====
CFLAGS := \
  -mcpu=$(CPU) -mthumb \
  -O0 -g3 \
  -ffreestanding \
  -fdata-sections -ffunction-sections \
  -Wall -Wextra \
  $(DEFS) \
  $(INCLUDES)

LDFLAGS := \
  -mcpu=$(CPU) -mthumb \
  -T linker.ld \
  -Wl,--gc-sections \
  -Wl,-Map=$(BUILD)/$(TARGET).map

# ===== Sources =====
SRCS := \
  main.c \
  system_MKL25Z4.c \
  startup.s

OBJS := $(SRCS:%=$(BUILD)/%.o)

# ===== Rules =====
all: $(BUILD)/$(TARGET).elf $(BUILD)/$(TARGET).bin

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%.c.o: %.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/%.s.o: %.s | $(BUILD)
	$(CC) -mcpu=$(CPU) -mthumb -c $< -o $@

$(BUILD)/$(TARGET).elf: $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $@
	$(SIZE) $@

$(BUILD)/$(TARGET).bin: $(BUILD)/$(TARGET).elf
	$(OBJCOPY) -O binary $< $@

clean:
	rm -rf $(BUILD)

flash: all
	pyocd flash $(BUILD)/$(TARGET).elf

.PHONY: all clean flash
