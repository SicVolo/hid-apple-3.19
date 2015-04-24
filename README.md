hid-apple
======================

A Linux HID Apple driver fixed for the early 2015 Apple MacBook Pro  12,1,  for Linux kernel 3.19, bundled with Ubuntu 15.04

"fn" key of does not work on a bundled hid-apple driver, because it's not recognizing new USB driver.

Hardcodes default Ubuntu 15.05 kernel parameters (DEBUG_FS=Y, HIDRAW=Y)

[kui/hid-apple][] driver is a fixed hid-apple driver for the above problem.

[kui/hid-apple]: https://github.com/kui/hid-apple "kui/hid-apple · GitHub"

Installation
---------------------

```sh
make
sudo make install
```

Test
```
modprobe -r hid_generic && modprobe -r hid_microsoft && modprobe -r usbhid && modprobe -r hid_apple && modprobe -r hid && modprobe hid  && modprobe usbhid && modprobe hid_generic && modprobe hid_apple
```

If it's fine make it permanent
```
sudo update-initramfs -u
````

Normal options apply. For example if you want to down-priority on Fn action on boot do
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf

for swapping alt and opt do:
echo options hid_apple swap_opt_cmd=1 | sudo tee -a /etc/modprobe.d/hid_apple.conf
