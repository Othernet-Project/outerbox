#!/bin/sh

PERSIST=/mnt/persist
SYSCONF=$PERSIST/sysconf
MKDIR=/bin/mkdir
CHMOD=/bin/chmod
MV=/bin/mv
RM=/bin/rm

backup() {
    fpath=$1
    $MV $fpath ${fpath}.backup || true
}

if [ -e $PERSIST/dropbear.rsa ]; then
    $MKDIR -p $SYSCONF/dropbear
    $CHMOD 700 $SYSCONF/dropbear
    $MV $PERSIST/dropbear.* $SYSCONF/dropbear
fi

backup $SYSCONF/dnsmasq.conf
backup $PERSIST/config.xml
