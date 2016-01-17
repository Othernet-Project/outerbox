#!/bin/sh

INSTALLER=$1

CONTENTS=$($INSTALLER --list)

SFXMAJ_FAC=100
PAT_FAC=1000
MIN_FAC=1000000
MAJ_FAC=1000000000

hasfile() {
  filename=$1
  echo $CONTENTS | grep "$filename" 2>&1 >/dev/null
}

suffix() {
  echo "$1" | egrep -o '(a|b|rc)[0-9]+'
}

mainver() {
  echo "$1" | egrep -o '[0-9]+\.[0-9]+(\.[0-9]+)?'
}

normalize() {
  # Convert a version number to a single integer
  ver=$(mainver $1)
  sfx=$(suffix $1)
  sfxtype=$(echo $sfx | egrep -o "[a-z]+")
  sfxnum=$(echo $sfx | egrep -o "[0-9]+")
  vmaj=$(echo "$ver" | cut -d. -f1)
  vmin=$(echo "$ver" | cut -d. -f2)
  vpat=$(echo "$ver" | cut -d. -f3)

  if [ -z $vpat ]; then
    vpat=0
  fi

  case "$sfxtype" in
    a)
      sfxmaj=1
      ;;
    b)
      sfxmaj=2
      ;;
    rc)
      sfxmaj=3
      ;;
    *)
      sfxmaj=4
      ;;
  esac

  if [ -z $sfxnum ]; then
    sfxnum=1
  fi
  echo $(expr $MAJ_FAC \* $vmaj + $MIN_FAC \* $vmin + $PAT_FAC \* $vpat + $SFXMAJ_FAC \* $sfxmaj + $sfxnum)
}

vercmp() {
  test $(normalize $1) -gt $(normalize $2)
}

# Platform check
if [ "$(cat /etc/platform 2> /dev/null)" != "wt200" ]; then
  echo "Incorrect platform"
  exit 1
fi

# Check for version if present
if hasfile version; then
  PKG_VER=$($INSTALLER --extract version -)
  OS_VER=$(cat /etc/version 2> /dev/null)

  if ! vercmp "$PKG_VER" "$OS_VER"; then
    echo "Package already installed or newer version installed"
    exit 1
  fi
fi

# look for a pre-update script
if hasfile pre-install.sh; then
  $INSTALLER --extract pre-install.sh /tmp
  [ -x /tmp/pre-install.sh ] && ( /tmp/pre-install.sh $INSTALLER || exit 1 )
  rm /tmp/pre-install.sh
fi

# Install kernel
if hasfile kernel.img; then
  MTD_BOOT=$(grep boot /proc/mtd | sed 's/^mtd\([0-9]\+\).*/\1/')
  MTD_RECOVERY=$(grep recovery /proc/mtd | sed 's/^mtd\([0-9]\+\).*/\1/')
  if [ -z "$MTD_BOOT" ] || [ -z "$MTD_RECOVERY" ]; then
    logger -s -t installer.sh "Could not determine kernel mtd partitions"
    exit 1
  fi
  $INSTALLER --flash kernel.img $MTD_RECOVERY || exit 1
  $INSTALLER --flash kernel.img $MTD_BOOT || exit 1
fi

# Install rotfs
if hasfile rootfs.ubifs; then
  $INSTALLER --ubi rootfs.ubifs ubi0:rootfs || exit 1
fi

# u-boot
if hasfile u-boot.bin; then
  MTD_UBOOT=$(grep bootloader /proc/mtd | sed 's/^mtd\([0-9]\+\).*/\1/')
  if [ -z "$MTD_UBOOT" ]; then
    logger -s -t installer.sh "Could not determine u-boot mtd partitions"
    exit 1
  fi
  $INSTALLER --flash u-boot.bin $MTD_UBOOT || exit 1
fi

# look for a post-install script
if hasfile post-install.sh; then
  $INSTALLER --extract post-install.sh /tmp
  [ -x /tmp/post-install.sh ] && ( /tmp/post-install.sh $INSTALLER || exit 1 )
  rm /tmp/post-install.sh
fi

logger -s -t installer.sh "Installation complete"
/sbin/reboot

# vim: set tabstop=2 softtabstop=2 shiftwidth=2:
