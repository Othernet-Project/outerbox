B := rootfs
BOARD = $(B)
BOARD_DIR = ./$(BOARD)
VERSION := $(shell cat $(BOARD_DIR)/version)
PLATFORM := $(shell cat $(BOARD_DIR)/platform)
TARGET_NAME := outerbox
TARGET_DIR := images
TARGET_FILE_NAME=$(TARGET_NAME)-$(VERSION).pkg
TARGET_MD5_NAME=$(TARGET_NAME)-$(VERSION).md5
TARGET_FILE = $(TARGET_DIR)/$(TARGET_FILE_NAME)
TARGET_MD5 = $(TARGET_DIR)/$(TARGET_MD5_NAME)

BUILDROOT = ./buildroot
OUTPUT_DIR = ../$(BOARD)/output
OUTPUT = $(BOARD)/output
CONFIG = $(OUTPUT)/.config
IMAGES_DIR = $(OUTPUT)/images
IMAGE_FILE := $(IMAGES_DIR)/$(PLATFORM)-$(VERSION).pkg
TOOLS_DIR = tools
EXTERNAL = .$(BOARD_DIR)
export BR2_EXTERNAL=$(EXTERNAL)

.PHONY: default version build sdcard menuconfig linux-menuconfig busybox-menuconfig saveconfig config help clean-build clean

default: build

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
	@-rm -f $(IMAGES_DIR)/kernel.img
	@-rm -f $(IMAGES_DIR)/*.pkg

clean: $(OUTPUT)
	-rm -rf $(OUTPUT)

$(TARGET_MD5): $(TARGET_FILE)
	@cd $(TARGET_DIR); md5sum $(TARGET_FILE_NAME) > $(TARGET_MD5_NAME)

$(TARGET_FILE): $(IMAGE_FILE) $(TARGET_DIR)
	@cp $< $@

$(TARGET_DIR):
	mkdir -p $@

$(IMAGE_FILE): $(CONFIG)
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR)

$(CONFIG):
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) buildroot_defconfig

.DEFAULT:
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) $@
