Replace a Debian or other Linux VM with an openSUSE image
because some hosters only offer other distributions.

## usage

Copy this dir onto the target VM, cd into it

```
edit customsetup.sh
REALLY=1 ./setup.sh
# optional customization of openSUSE:
chroot .
passwd
exit
exit
```

