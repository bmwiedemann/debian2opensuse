#!/bin/sh
apt -yy update
apt -y install wget libgnutls30 ca-certificates rpm qemu-utils libwww-perl
./customsetup.sh

# fetch perl script
#TODO

chmod a+x setup.pl
# run perl script
./setup.pl
