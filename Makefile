B := rootfs
BOARD = $(B)
BOARD_DIR = ./$(BOARD)
VERSION := $(shell cat $(BOARD_DIR)/version)
PLATFORM := $(shell cat $(BOARD_DIR)/platform)
IMAGE_FILE := images/$(PLATFORM)-$(VERSION).pkg
IMAGE_FILE_GZ = $(IMAGE_FILE).gz
IMAGE_FILE_ZIP = $(IMAGE_FILE).zip
IMAGE_FILE_MD5SUM = $(IMAGE_FILE).md5
UPDATE_ZIP = images/$(PLATFORM)-update-$(VERSION).zip

BUILDROOT = ./buildroot
OUTPUT_DIR = ../$(BOARD)/output
OUTPUT = $(BOARD)/output
CONFIG = $(OUTPUT)/.config
IMAGES_DIR = $(OUTPUT)/images
KERNEL_IMAGE = $(IMAGES_DIR)/uImage
TOOLS_DIR = tools

EXTERNAL = .$(BOARD_DIR)
export BR2_EXTERNAL=$(EXTERNAL)

.PHONY: default version build sdcard gzimage zipimage update image menuconfig linux-menuconfig busybox-menuconfig saveconfig config help clean-build clean

default: build

version:
	@echo v$(VERSION)

build: $(KERNEL_IMAGE)

$(KERNEL_IMAGE): $(CONFIG)
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR)

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

$(CONFIG):
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) buildroot_defconfig

help:
	@cat HELP

clean-build: linux-dirclean
	@-rm -rf $(IMAGES_DIR)/*

clean: $(OUTPUT)
	-rm -rf $(OUTPUT)

.DEFAULT:
	@make -C $(BUILDROOT) O=$(OUTPUT_DIR) $@
