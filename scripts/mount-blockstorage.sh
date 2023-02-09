#!/bin/sh
# Create new empty partitions:
parted -s /dev/vdb mklabel gpt
parted -s /dev/vdb unit mib mkpart primary 0% 100%
# Create new empty filesystem:
mkfs.ext4 /dev/vdb1
mkdir /opt/share
echo >> /etc/fstab
echo /dev/vdb1               /opt/share       ext4    defaults,noatime,nofail 0 0 >> /etc/fstab
mount /opt/share