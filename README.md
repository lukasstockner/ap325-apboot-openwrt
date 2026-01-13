# OpenWRT-compatible bootloader for the AP-325 (board name Octomore)

This repo contains a version of APBoot, an Aruba-specific fork of U-Boot, that has been modified to work in combination with OpenWRT.

The source code is based on the GPL code release at https://github.com/shalzz/aruba-ap-310/ (despite the name, this targets the AP-325).

## Changes

### Splitting out the bootloader
The original repo linked above contains many additional components, while this one is purely for the bootloader.
### Fixing compilation on modern systems
The original source code assumes a VERY outdated build environment. Therefore, the code and build scripts have been tweaked to compile successfully on Debian Trixie using GCC 14.
### Removing signature verification
The original APBoot enforces image signatures, both for flashing and at boot time. In this version, the checks have been disabled, allowing unsigned images to be loaded.

## Building

In order to have a consistent build environment, the repo also has a `Dockerfile` that will compile the bootloader during its building phase, and executing it will print out `u-boot.mbn`, the binary data to be written to the `APPSBL` MTD partition (offset `0x220000` size `0x100000`) on the SPI flash.

```
docker build . -t apboot
docker run --rm apboot > u-boot.mbn
```

## Flashing

From an AP-325 running stock bootloader (tested on `APBoot 1.5.5.9 (build 58433), Built: 2017-02-15 at 14:48:27`), you can flash the built binary as follows:
```
autoreboot off
dhcp
setenv serverip <your TFTP server IP>
setenv autostart n
netget 44000000 u-boot.mbn
sf probe 0
sf erase 220000 100000
sf write 44000000 220000 100000
reset
```
Summary:
- `autoreboot off` disables the auto-reboot on inactivity
- `dhcp` and `setenv serverip` set the network config
- `setenv autostart n` prevents APBoot from trying to execute data after loading it
- `netget 44000000 u-boot.mbn` fetches `u-boot.mbn` via TFTP and loads it into memory address `0x44000000` (the reserved staging memory area)
- `sf probe 0` selects the SPI flash
- `sf erase 220000 100000` erases the `APPSBL` partition that contains the bootloader
- `sf write 44000000 220000 100000` writes the loaded data to the `APPSBL` partition
  - note that you could reduce `100000` (the *hexadecimal* number of bytes to be written) to the *hexadecimal* number of bytes reported by `netget`
- `reset` boots into the new bootloader
