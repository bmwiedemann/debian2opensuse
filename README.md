Replace a Debian or other Linux VM with an openSUSE image
because some hosters only offer other distributions.

## Pre-requisites

* needs 900MB space in /dev/shm
* needs 600MB space on disk

## usage

Copy this dir onto the target VM and do

```
cd /path/to/debian-to-opensuse
edit customsetup.sh
REALLY=1 ./setup.sh
# after a bit it will stop for the optional customization of openSUSE:
chroot .
passwd
exit
exit
```

