#!/bin/bash
#
# Create a .pkg file containing an arbitrary script.
#
# This file is part of outerbox.
# outerbox is free sofware licensed under the
# GNU GPL version 3 or any later version.
#
# (c) 2016 Outernet Inc
# Some rights reserved.

set -e

SCRIPTDIR="$(dirname $0)"
ROOTDIR="$(cd "$SCRIPTDIR/../.."; pwd)"
EXTERNALDIR="$(cd "$SCRIPTDIR/.."; pwd)"
HOSTDIR="$ROOTDIR/build/rootfs/host"
MKPKG="$HOSTDIR/usr/bin/mkpkg"
SIGNATURE="$EXTERNALDIR/pkg/package.pem"

SCRIPT="$1"

usage() {
  echo "
Usage: $0 PATH

Arugments:

  PATH    Path to the script file.
"
}

[ -x "$SCRIPT" ] || (echo "Script must be a valid executable file"; usage; exit 0)
[ -x "$MKPKG" ] || (echo "Please build host-pkgtool first."; exit 1)

read -rsp "Package key password: " PASSWORD
$MKPKG "${SCRIPT}:run.sh" -k "$SIGNATURE" -p "$PASSWORD" -o outernet-rx.pkg
