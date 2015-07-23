hid-apple
======================

A Linux HID Apple driver fixed for the early 2015 Apple MacBook Pro 12,1, for Linux kernel 3.19.

Enables the "fn" key that does not work on a bundled hid-apple driver, because it's not recognizing new USB driver.

Fixes the non-functioning touchpad right click and the multitouch.

Hardcoded with the default Ubuntu 15.04 kernel parameters (DEBUG_FS=Y, HIDRAW=Y)

DKMS Installation
-----------------

1. Ensure DKMS is installed: `sudo apt-get install dkms`
2. Add the module to DKMS: `sudo dkms add .`
3. Build the module: `sudo dkms build hid-apple/1.0`
4. Install the module: `sudo dkms install hid-apple/1.0`

This should ensure the module is automatically built remains built
when newer version of the kernel packages are installed.

Manual Installation
-------------------

```sh
make
sudo make install
```

Put the modules into the init ram fs
```
sudo update-initramfs -u
```

Normal options apply. For example if you want to down-priority on Fn action on boot do
```
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
```

For swapping alt and opt do:
```
echo options hid_apple swap_opt_cmd=1 | sudo tee -a /etc/modprobe.d/hid_apple.conf
```
