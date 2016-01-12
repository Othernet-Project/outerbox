################################################################################
#
# pkgtool
#
################################################################################

PKGTOOL_VERSION = 1.0.0
PKGTOOL_SOURCE = pkgtool-$(PKGTOOL_VERSION).tar.gz
PKGTOOL_SITE = https://outernet.is
PKGTOOL_DEPENDENCIES = openssl
PKGTOOL_LICENSE = GPL

define PKGTOOL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" -C $(@D) pkgtool
endef

define PKGTOOL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/pkgtool $(TARGET_DIR)/usr/sbin/pkgtool
endef

define HOST_PKGTOOL_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) CFLAGS="$(HOST_CFLAGS)" \
		LDFLAGS="$(HOST_LDFLAGS)" CROSS_COMPILE=$(TARGET_CROSS) \
		TARGET_CFLAGS="$(TARGET_CFLAGS)" TARGET_LDFLAGS="$(TARGET_LDFLAGS)" \
		-C $(@D) mkpkg
endef

define HOST_PKGTOOL_INSTALL_CMDS
	$(INSTALL) -D -m 755 $(@D)/mkpkg $(HOST_DIR)/usr/bin/mkpkg
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
