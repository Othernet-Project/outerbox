B := rootfs

include $(B).mk

# Board-agnostic settings
BUILDROOT = ./buildroot
CONFIG = $(OUTPUT)/.config
BOARD_DIR = ./$(BOARD)
VERSION := $(shell cat $(BOARD_DIR)/version)
PLATFORM := $(shell cat $(BOARD_DIR)/platform_$(B))

# Build target
TARGET_FILE_NAME=$(TARGET_NAME)-$(VERSION).$(TARGET_EXT)
TARGET_MD5_NAME=$(TARGET_NAME)-$(VERSION).md5
TARGET_FILE = $(TARGET_DIR)/$(TARGET_FILE_NAME)
TARGET_MD5 = $(TARGET_DIR)/$(TARGET_MD5_NAME)

# Build output files
OUTPUT = build/$(B)
OUTPUT_DIR = ../$(OUTPUT)
IMAGES_DIR = $(OUTPUT)/images
IMAGE_FILE := $(IMAGES_DIR)/$(PLATFORM)-$(VERSION).$(TARGET_EXT)

# External dir
EXTERNAL = .$(BOARD_DIR)

# Global vars
export BR2_EXTERNAL=$(EXTERNAL)
export PLATFORM=$(PLATFORM)

.PHONY: default version build sdcard menuconfig linux-menuconfig \
	busybox-menuconfig saveconfig config help clean-build clean

default: build

rebuild: clean-build build

version:
	@echo v$(VERSION)

build: $(TARGET_MD5)

menuconfig: $(CONFIG)
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) menuconfig

linux-menuconfig: $(CONFIG)
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) linux-menuconfig

busybox-menuconfig: $(CONFIG)
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) busybox-menuconfig

saveconfig: $(CONFIG)
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) savedefconfig
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) linux-update-defconfig
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) busybox-update-config

config: $(CONFIG)

clean-build:
	@-rm $(TARGET_FILE)
	@-rm $(TARGET_MD5)
	@-rm -f $(IMAGES_DIR)/rootfs*
	@-rm -rf $(IMAGES_DIR)/init*
	@-rm -f $(IMAGES_DIR)/*.img
	@-rm -f $(IMAGES_DIR)/*.$(TARGET_EXT)

clean: $(OUTPUT)
	-rm -rf $(OUTPUT)

$(TARGET_MD5): $(TARGET_FILE)
	cd $(TARGET_DIR); md5sum $(TARGET_FILE_NAME) > $(TARGET_MD5_NAME)

$(TARGET_FILE): $(IMAGE_FILE) $(TARGET_DIR)
	cp $< $@

$(TARGET_DIR):
	mkdir -p $@

$(IMAGE_FILE): $(CONFIG)
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR)

$(CONFIG):
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) $(DEFCONFIG)

.DEFAULT:
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) $@
