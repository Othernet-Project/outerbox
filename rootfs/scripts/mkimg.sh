#!/bin/bash

set -e

# Arguments
. ${BR2_EXTERNAL}/scripts/parse_args.sh

# Package data
VERSION=${BR2_EXTERNAL}/version
LIBC=${TARGET_DIR}/lib/libc.so.6
LD=${TARGET_DIR}/lib/ld-linux*.so.3
LIBC_VER=$(echo $(readlink $LIBC) | grep -Poe '\d+\.\d+')
LD_VER=$(echo $(readlink $LD) | grep -Poe '\d+\.\d+')
LD_SFX=$(echo $LD | sed 's|.*/lib/ld-linux||' | sed 's|\.so\.3||')
PKGDIR=${BR2_EXTERNAL}/pkg

# Output directories
INIT_DIR=${BINARIES_DIR}/init

# Bootable SD card image
INIT=${PKGDIR}/init-boot.in
INIT_LIST=${PKGDIR}/init-boot.ramfs.in
INIT_OUT=${INIT_DIR}/init-boot
INIT_LIST_OUT=${INIT_DIR}/init-boot.ramfs
INITRAMFS=${BINARIES_DIR}/initramfs-boot.cpio.gz
KERNEL_IMAGE=${BINARIES_DIR}/boot.img
ROOTFS_IMAGE=${BINARIES_DIR}/rootfs.squashfs

# Kernel
KERNEL_UIMAGE=${BINARIES_DIR}/uImage
DTB=${BINARIES_DIR}/wetek_play.dtb

# Output files
ZIPFILE=${BINARIES_DIR}/${PLATFORM}-$(cat $VERSION).zip

# Commands
KERNEL_DIR=${BUILD_DIR}/linux-${KERNEL_VERSION}
GENCPIO=${KERNEL_DIR}/usr/gen_init_cpio
MKIMAGE=${KERNEL_DIR}/mkbootimg
MKPKG=${HOST_DIR}/usr/bin/mkpkg

patch_init_list() {
    init_list=$1
    output=$2
    cat "$init_list" \
        | sed "s|%PREFIX%|${TARGET_DIR}|g" \
        | sed "s|%INIT_DIR%|${INIT_DIR}|g" \
        | sed "s|%LIBC_VER%|${LIBC_VER}|g" \
        | sed "s|%LD_VER%|${LD_VER}|g" \
        | sed "s|%LD_SFX%|${LD_SFX}|g" \
        > "$output"
}

patch_init() {
    init=$1
    output=$2
    cat "$init" \
        | sed "s|%TMPFS_SIZE%|${TMPFS_SIZE}|" \
        > "$output"
}


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
echo "================================================================="

# Prepare the init script
echo ">>> Creating cpio configuration"
mkdir -p $INIT_DIR
patch_init_list "$INIT_LIST" "$INIT_LIST_OUT"
patch_init "$INIT" "$INIT_OUT"

# Generate kernel initramfs image
echo ">>> Generating cpio file"
$GENCPIO "$INIT_LIST_OUT" | gzip > "$INITRAMFS"
test -e "$INITRAMFS" || (echo "No $INITRAMFS written"; exit 1)

# Generate kernel image with initramfs
echo ">>> Generating composite image"
$MKIMAGE --kernel "$KERNEL_UIMAGE" --second "$DTB" \
    --ramdisk "$INITRAMFS" --output "$KERNEL_IMAGE"

# Create boot kit
echo ">>> Creating bootable SD card zipball"
zip -j "$ZIPFILE" "$KERNEL_IMAGE" "$ROOTFS_IMAGE"
