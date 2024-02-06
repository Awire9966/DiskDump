# DiskDump
DiskDump is a amd64 / x86_64 ONLY wiping CD/DVD/USB/ISO 
# Info
DiskDump was a project of mine to allow me to wipe eMMC chips. The current alternitave, [ShredOS](https://github.com/PartialVolume/shredos.x86_64) cannont as it sadly doesnt contain the drivers.
# Comparison
[ShredOS](https://github.com/PartialVolume/shredos.x86_64) is good for HDD wiping on 64 and 32 bit machines slightly quicker. (its made with C).
DiskDump is good for large 64 bit systems with ~750 MB+ Ram with HDD or eMMC disks. The difference in time is about 5-10 minutes. (although often smaller). Now how do I use DiskDump?
# Using DiskDump
DiskDump may seem complicated however it is very simple to use.
1. [Get a copy of the image](https://github.com/Awire9966/DiskDump/releases/tag/1.0)
2. [Write image to your media](https://github.com/Awire9966/DiskDump/releases/tag/1.0)
3. Open your computer's boot menu. For HP this is often F9 and for Dells its often F11.
4. When it says "ISOLINUX" press enter.
5. A whole bunch of stuff will come up. When it stops press enter.
6. If your using the release image you login with username ```root``` and password ```wipe```
7. type ```nwipe``` in the shell that appears.
8. Enjoy!
