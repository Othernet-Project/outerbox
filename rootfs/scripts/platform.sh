#!/bin/bash

cp $BR2_EXTERNAL/version $TARGET_DIR/etc/version
echo "$PLATFORM" > $TARGET_DIR/etc/platform
