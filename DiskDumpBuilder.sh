
mkdir -p "./DiskDump/LIVE_BOOT"
sudo debootstrap \
    --arch=amd64 \
    --variant=minbase \
    stable \
    "./DiskDump/LIVE_BOOT/chroot" \
    http://ftp.us.debian.org/debian/
echo "DiskDump" | sudo tee "./DiskDump/LIVE_BOOT/chroot/etc/hostname"
sudo chroot "./DiskDump/LIVE_BOOT/chroot" << EOF
apt-get update && \
apt-get install -y --no-install-recommends \
    linux-image-amd64 \
    live-boot \
    systemd-sysv
EOF
sudo chroot "./DiskDump/LIVE_BOOT/chroot" << EOF
apt-get install -y --no-install-recommends \
    nwipe\
    nano
EOF
echo 'Enter a Password for the main user'
echo 'The main password for the releases is wipe'
sudo chroot "./DiskDump/LIVE_BOOT/chroot" passwd root
mkdir -p "./DiskDump/LIVE_BOOT"/{staging/{EFI/BOOT,boot/grub/x86_64-efi,isolinux,live},tmp}
sudo mksquashfs \
    "./DiskDump/LIVE_BOOT/chroot" \
    "./DiskDump/LIVE_BOOT/staging/live/filesystem.squashfs" \
    -e boot
cp "./DiskDump/LIVE_BOOT/chroot/boot"/vmlinuz-* \
    "./DiskDump/LIVE_BOOT/staging/live/vmlinuz" && \
cp "./DiskDump/LIVE_BOOT/chroot/boot"/initrd.img-* \
    "./DiskDump/LIVE_BOOT/staging/live/initrd"
curl -o "./DiskDump/LIVE_BOOT/staging/isolinux/isolinux.cfg" "https://raw.githubusercontent.com/Awire9966/DiskDump/main/data/isolinux.cfg"
curl -o "./DiskDump/LIVE_BOOT/staging/boot/grub/grub.cfg" "https://raw.githubusercontent.com/Awire9966/DiskDump/main/data/grub.cfg"
cp "./DiskDump/LIVE_BOOT/staging/boot/grub/grub.cfg" "./DiskDump/LIVE_BOOT/staging/EFI/BOOT/"
curl -o "./DiskDump/LIVE_BOOT/tmp/grub-embed.cfg" "https://raw.githubusercontent.com/Awire9966/DiskDump/main/data/grub-embed.cfg"
cp /usr/lib/ISOLINUX/isolinux.bin "./DiskDump/LIVE_BOOT/staging/isolinux/" && \
cp /usr/lib/syslinux/modules/bios/* "./DiskDump/LIVE_BOOT/staging/isolinux/"
grub-mkstandalone -O i386-efi \
    --modules="part_gpt part_msdos fat iso9660" \
    --locales="" \
    --themes="" \
    --fonts="" \
    --output="./DiskDump/LIVE_BOOT/staging/EFI/BOOT/BOOTIA32.EFI" \
    "boot/grub/grub.cfg=./DiskDump/LIVE_BOOT/tmp/grub-embed.cfg"
grub-mkstandalone -O x86_64-efi \
    --modules="part_gpt part_msdos fat iso9660" \
    --locales="" \
    --themes="" \
    --fonts="" \
    --output="./DiskDump/LIVE_BOOT/staging/EFI/BOOT/BOOTx64.EFI" \
    "boot/grub/grub.cfg=./DiskDump/LIVE_BOOT/tmp/grub-embed.cfg"
(cd "./DiskDump/LIVE_BOOT/staging" && \
    dd if=/dev/zero of=efiboot.img bs=1M count=20 && \
    mkfs.vfat efiboot.img && \
    mmd -i efiboot.img ::/EFI ::/EFI/BOOT && \
    mcopy -vi efiboot.img \
        "./DiskDump/LIVE_BOOT/staging/EFI/BOOT/BOOTIA32.EFI" \
        "./DiskDump/LIVE_BOOT/staging/EFI/BOOT/BOOTx64.EFI" \
        "./DiskDump/LIVE_BOOT/staging/boot/grub/grub.cfg" \
        ::/EFI/BOOT/
)
mkdir "./DiskDump/LIVE_BOOT/staging/art"
curl -o "./DiskDump/LIVE_BOOT/staging/art/bg.png" "https://raw.githubusercontent.com/Awire9966/DiskDump/main/data/bg.png"

xorriso \
    -as mkisofs \
    -iso-level 3 \
    -o "./DiskDump/LIVE_BOOT/DiskDump.iso" \
    -full-iso9660-filenames \
    -volid "DDUMP" \
    --mbr-force-bootable -partition_offset 16 \
    -joliet -joliet-long -rational-rock \
    -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
    -eltorito-boot \
        isolinux/isolinux.bin \
        -no-emul-boot \
        -boot-load-size 4 \
        -boot-info-table \
        --eltorito-catalog isolinux/isolinux.cat \
    -eltorito-alt-boot \
        -e --interval:appended_partition_2:all:: \
        -no-emul-boot \
        -isohybrid-gpt-basdat \
    -append_partition 2 C12A7328-F81F-11D2-BA4B-00A0C93EC93B ./DiskDump/LIVE_BOOT/staging/efiboot.img \
    "./DiskDump/LIVE_BOOT/staging"
mv "./DiskDump/LIVE_BOOT/DiskDump.iso" "$1"
