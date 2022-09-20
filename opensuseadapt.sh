#!/bin/sh
# to be run on the final openSUSE system
echo -e '
d
n\n\n\n\n\n\n
a\np\nw\n' | fdisk /dev/vda
# after a reboot to activate the new partition table
resize2fs /dev/vda1
