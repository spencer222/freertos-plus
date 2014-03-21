QEMU_STM32 ?= ../qemu_stm32/arm-softmmu/qemu-system-arm
BUILD_TARGET = $(OUTDIR)/$(TARGET)
export SHELL := /bin/bash

qemu: $(BUILD_TARGET).bin $(QEMU_STM32)
	$(QEMU_STM32) -M stm32-p103 \
	    -monitor stdio \
	    -kernel $(BUILD_TARGET).bin \
	    -semihosting

qemudbg: $(BUILD_TARGET).bin $(QEMU_STM32)
	$(QEMU_STM32) -M stm32-p103 \
	    -monitor stdio \
	    -gdb tcp::3333 -S \
	    -kernel $(BUILD_TARGET).bin -semihosting 2>&1>/dev/null & \
	    $(CROSS_COMPILE)gdbtui -x $(TOOLDIR)/gdbscript
