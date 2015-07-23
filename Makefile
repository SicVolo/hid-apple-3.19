TARGET		:= $(shell uname -r)
HOME		 = $(shell pwd)
KERNEL_MODULES	:= /lib/modules/$(TARGET)
KERNEL_BUILD	:= $(KERNEL_MODULES)/build
DRIVER		:= hid-apple
DRIVER_H	:= hid
MOD_SUBDIR	 = drivers/hid
DRIVER_M	:= bcm5974
MOD_SUBDIR_M	 = drivers/input/mouse

hid-y		:= hid-core.o hid-input.o hid-debug.o hidraw.o

obj-m	:= $(DRIVER).o $(DRIVER_H).o $(DRIVER_M).o

MAKEFLAGS += --no-print-directory

.PHONY: all install modules clean

all: modules

modules clean:
	@$(MAKE) -C $(KERNEL_BUILD) M=$(CURDIR) $@

install: modules
	install --backup --mode 644 --group root --owner root $(DRIVER).ko $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	install --backup --mode 644 --group root --owner root $(DRIVER_H).ko $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	install --backup --mode 644 --group root --owner root $(DRIVER_M).ko $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR_M)
	depmod -a $(TARGET)
