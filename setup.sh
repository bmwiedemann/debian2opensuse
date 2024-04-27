#!/bin/sh
apt -yy update
apt -y install wget libgnutls30 ca-certificates rpm qemu-utils libwww-perl
./customsetup.sh

chmod a+x setup.pl
# run perl script
./setup.pl
