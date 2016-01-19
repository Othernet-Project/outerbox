#############################################################
#
# libvdpau-sunxi
#
#############################################################
LIBVDPAU_SUNXI_VERSION = 743bdfbc81832dc7317b5a79b4d90dcfe1025ff8
LIBVDPAU_SUNXI_SITE = $(call github,linux-sunxi,libvdpau-sunxi,$(LIBVDPAU_SUNXI_VERSION))
LIBVDPAU_SUNXI_INSTALL_STAGING = YES
LIBVDPAU_SUNXI_INSTALL_TARGET = YES
LIBVDPAU_SUNXI_DESCRIPTION = a Video Decode and Presentation API for UNIX.
LIBVDPAU_SUNXI_DEPENDENCIES = libvdpau

define LIBVDPAU_SUNXI_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)"
endef

define LIBVDPAU_SUNXI_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
			CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" \
			DESTDIR=$(STAGING_DIR) install
endef

define LIBVDPAU_SUNXI_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
			CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" \
			DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
