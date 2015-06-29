hid-apple
======================

Patched keyboard driver for the early 2015 Apple MacBook Pro  12,1,  for  Linux kernel 3.19,
Enables teh "fn" key that does not work on a bundled hid-apple driver, because it's not recognizing new USB driver.

Tested on Kubuntu 15.04

Hardcodes default Ubuntu 15.04 kernel parameters (DEBUG_FS=Y, HIDRAW=Y)

The fixed touchpad driver is here - https://github.com/SicVolo/bcm5974-3.19 "SicVolo/bcm5974-3.19 · GitHub"

Installation
---------------------
Get the build dependencies (apt-get build-essentials). Then do the usual:

```sh
make
sudo make install
```

Test by removing and reinstalling the hid stack. This has to be a one-liner because you lose keyboard input after the first module removal. Another way to test is to run the update-initramfs (see below) and reboot your system.
```
modprobe -r hid_generic; modprobe -r usbhid; modprobe -r hid; modprobe hid; modprobe usbhid; modprobe hid_generic; modprobe hid_apple
```
You might have to restart your X server. Make the change permanent
```
sudo update-initramfs -u
````

Normal options apply. For example if you want to de-prioritize Fn action on boot do
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf

For swapping alt and opt do:
echo options hid_apple swap_opt_cmd=1 | sudo tee -a /etc/modprobe.d/hid_apple.conf
