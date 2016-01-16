#!/bin/bash

set -e

# Arguments
. ${BR2_EXTERNAL}/scripts/parse_args.sh

# Package data
PLATFORM=${BR2_EXTERNAL}/platform
VERSION=${BR2_EXTERNAL}/version
LIBC=${TARGET_DIR}/lib/libc.so.6
LD=${TARGET_DIR}/lib/ld-linux.so.3
LIBC_VER=$(echo $(readlink $LIBC) | grep -Poe '\d+\.\d+')
LD_VER=$(echo $(readlink $LD) | grep -Poe '\d+\.\d+')

# Configuration files
PKGDIR=${BR2_EXTERNAL}/pkg
INIT=${PKGDIR}/init.in
INIT_LIST=${PKGDIR}/init.ramfs.in
INSTALLER=${PKGDIR}/installer.sh

# Output files
KERNEL_UIMAGE=${BINARIES_DIR}/uImage
DTB=${BINARIES_DIR}/wetek_play.dtb
KERNEL_IMAGE=${BINARIES_DIR}/kernel.img
INITRAMFS=${BINARIES_DIR}/initramfs.cpio.gz
ROOTFS_IMAGE=${BINARIES_DIR}/rootfs.ubifs
PKGFILE=${BINARIES_DIR}/$(cat $PLATFORM)-$(cat $VERSION).pkg
INIT_DIR=${BINARIES_DIR}/init
INIT_OUT=${INIT_DIR}/init
INIT_LIST_OUT=${INIT_DIR}/init.ramfs

# Commands
KERNEL_DIR=${BUILD_DIR}/linux-${KERNEL_VERSION}
GENCPIO=${KERNEL_DIR}/usr/gen_init_cpio
MKIMAGE=${KERNEL_DIR}/mkbootimg
MKPKG=${HOST_DIR}/usr/bin/mkpkg

# Sanity check
test -e $KERNEL_UIMAGE || \
    (echo "No kernel image found at $KERNEL_UIMAGE"; exit 1)
test -e $ROOTFS_IMAGE || \
    (echo "No rootfs image found at $ROOTFS_IMAGE"; exit 1)

echo "================================================================="
echo "Kernel version:  $KERNEL_VERSION"
echo "tmpfs size:      ${TMPFS_SIZE} MB"
echo "Signature file:  $SIGNATURE"
echo "Libc version:    $LIBC_VER"
echo "Ld version:      $LD_VER"
echo "Versioned pkg:   $([ "$USE_VERSION" == "y" ] && echo "YES" || echo "NO")"
echo "================================================================="

# Prepare the init script
echo ">>> Creating cpio configuration"
mkdir -p $INIT_DIR
cat "$INIT_LIST" \
    | sed "s|%PREFIX%|${TARGET_DIR}|g" \
    | sed "s|%INIT_DIR%|${INIT_DIR}|g" \
    | sed "s|%LIBC_VER%|${LIBC_VER}|g" \
    | sed "s|%LD_VER%|${LD_VER}|g" \
    > "$INIT_LIST_OUT"
cat "$INIT" \
    | sed "s|%TMPFS_SIZE%|${TMPFS_SIZE}|" \
    > "$INIT_OUT"

# Generate kernel initramfs image
echo ">>> Generating cpio file"
$GENCPIO "$INIT_DIR/init.ramfs" | gzip > "$INITRAMFS"

# Generate kernel image with initramfs
echo ">>> Generating composite image"
$MKIMAGE --kernel "$KERNEL_UIMAGE" --second "$DTB" --ramdisk "$INITRAMFS" \
    --output "$KERNEL_IMAGE"

# Generate signed or unsigned .pkg file

# FIXME: the conditional building of arguments can be fragile when using paths 
# that incldue spaces

echo ">>> Generating .pkg file"
mkpkg_args="${INSTALLER}:run.sh $KERNEL_IMAGE $ROOTFS_IMAGE"

if [ "$USE_VERSION" == "y" ]
then
    mkpkg_args="${VERSION} $mkpkg_args"
fi

if [ -f "$SIGNATURE" ]
then
    read -r -s -p "Package key password: " PASSWORD && \
    mkpkg_args="-k $SIGNATURE -p $PASSWORD $mkpkg_args"
fi

mkpkg_args="-o $PKGFILE $mkpkg_args"

$MKPKG $mkpkg_args
