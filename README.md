# DiskDump
DiskDump is a amd64 / x86_64 ONLY that wipes almost everything. Bootable from CD/DVD/USB/ISO 
# Info
DiskDump was a project of mine to allow me to wipe eMMC chips. The current alternitave, [ShredOS](https://github.com/PartialVolume/shredos.x86_64) cannont as it sadly doesnt contain the drivers.
# Comparison
[ShredOS](https://github.com/PartialVolume/shredos.x86_64) is good for HDD wiping on 64 and 32 bit machines slightly quicker. (its made with C).
DiskDump is good for large 64 bit systems with ~750 MB+ Ram with HDD or eMMC disks. The difference in time is about 5-10 minutes. (although often smaller). Now how do I use DiskDump?
# Using DiskDump
DiskDump may seem complicated however it is very simple to use.
1. [Get a copy of the image](https://github.com/Awire9966/DiskDump/releases/tag/1.0)
2. [Write image to your media](https://github.com/Awire9966/DiskDump/blob/main/WRITE_TO_DISK.md)
3. Open your computer's boot menu. For HP this is often F9 and for Dells its often F11.
4. When it says "ISOLINUX" press enter.
5. A whole bunch of stuff will come up. When it stops press enter.
6. If your using the release image you login with username ```root``` and password ```wipe```
7. type ```nwipe``` in the shell that appears.
8. Enjoy!
# Build with this sh file
1. run ``sudo apt-get install \
    debootstrap \
    squashfs-tools \
    xorriso \
    isolinux \
    syslinux-efi \
    grub-pc-bin \
    grub-efi-amd64-bin \
    grub-efi-ia32-bin \
    mtools \
    dosfstools``
2. run the script with the following command: ``sudo bash <path to diskdump script>/DiskDumpBuilder.sh <new iso location>``
3. When it asks, enter the password for your distribution of DiskDump
4. Enjoy!

# Credits
1. Will Haley's blogpost on how to make debian livecd https://www.willhaley.com/blog/custom-debian-live-environment/
2. PartialVolume: Inspired me. https://github.com/PartialVolume
3. Martin. Creator of nwipe. https://github.com/martijnvanbrummelen
