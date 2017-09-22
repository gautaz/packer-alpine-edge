#!/bin/sh
set -e

sudo apk upgrade --update-cache --available

echo "Setting Alpine Linux up"
sudo setup-alpine -f /tmp/setup-alpine.conf <<- EOS
vagrant
vagrant
y
EOS

echo "Mounting target"
sudo mount /dev/sda3 /mnt
sudo mount /dev/sda1 /mnt/boot
sudo mount --bind /proc /mnt/proc
sudo mount --bind /dev /mnt/dev
sudo mount --bind /sys /mnt/sys
sudo mount --bind /tmp /mnt/tmp

echo "Chrooting in target"
sudo chmod u+x /tmp/chroot.sh
sudo chroot /mnt /tmp/chroot.sh

echo "Unmounting target"
sudo umount /mnt/tmp
sudo umount /mnt/sys
sudo umount /mnt/dev
sudo umount /mnt/proc
sudo umount /mnt/boot
sudo umount /mnt
