#!/bin/bash

TOKEN_FILE=$BR2_EXTERNAL/pkg/reset_token
TARGET_FILE=$TARGET_DIR/etc/emergency.token

if [ -f "$TOKEN_FILE" ]
then
    install -m600 "$TOKEN_FILE" "$TARGET_FILE"
fi

