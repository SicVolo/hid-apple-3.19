TARGET		:= $(shell uname -r)
HOME		 = $(shell pwd)
KERNEL_MODULES	:= /lib/modules/$(TARGET)
KERNEL_BUILD	:= $(KERNEL_MODULES)/build
DRIVER		:= hid-apple
MOD_SUBDIR	 = drivers/hid

hid-y		:= hid-core.o hid-input.o hid-debug.o hidraw.o

obj-m	:= hid.o $(DRIVER).o

MAKEFLAGS += --no-print-directory

.PHONY: all install modules clean

all: modules

modules clean:
	@$(MAKE) -C $(KERNEL_BUILD) M=$(CURDIR) $@

install: modules
	install --backup --mode 644 --group root --owner root $(DRIVER).ko $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	install --backup --mode 644 --group root --owner root hid.ko $(KERNEL_MODULES)/kernel/$(MOD_SUBDIR)
	depmod -a $(TARGET)
