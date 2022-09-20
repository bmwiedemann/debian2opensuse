#!/usr/bin/perl -w
use strict;
use LWP::Simple;

my $tmp = "/dev/shm";
my $disk = guessrootdisk() || "/dev/vda";
my $img = "altimagebuild";
#my $URL = "https://download.opensuse.org/repositories/home:/bmwiedemann/openSUSE_Leap_15.4/x86_64/";
my $URL = "https://ftp.gwdg.de/pub/opensuse/repositories/home:/bmwiedemann/openSUSE_Leap_15.4/x86_64/";
my $html=get($URL);
$html =~ m/a href="($img-[^"]*.rpm)"/ || die "$img not found on $URL";
my $imgfile = $1;
my $imgURL = $URL.$imgfile;
if (! -e $imgfile) {
    system("wget -N $imgURL") && die "wget $imgURL failed";
}
system "rpm2cpio $imgfile | cpio --extract --to-stdout > img.qcow2";
system "qemu-img convert img.qcow2 $tmp/img";
#system "grub-install $disk";

# customization 
print "time for some customization in /mnt...\n";
system "mount -o loop,offset=1048576 $tmp/img /mnt";
chdir "/mnt";
system "bash -i";
chdir "/";
system "umount /mnt";


sub sysrq($) {
    open(my $fd, ">/proc/sysrq-trigger") or die $!;
    print $fd $_[0],"\n";
    close $fd;
}
if($ENV{REALLY}) {
    system "swapoff -a"; # could screw up our new data
    # read-only mount old rootfs
    sysrq "s";
    sysrq "u";
    sysrq "s";
    sleep 1;
    # write to disk
    system "dd if=$tmp/img of=$disk bs=1M";
    sleep 1;
    sysrq "s";
    sleep 1;
    sysrq "b"; # reboot
}

sub guessrootdisk
{
    my $mount = `grep /dev/.da /proc/mounts`;
    $mount =~ m!(/dev/[hvs]da)! and return $1;
    return undef;
}
