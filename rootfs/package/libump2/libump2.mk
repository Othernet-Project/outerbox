################################################################################
#
# libump2
#
################################################################################

LIBUMP2_VERSION = ec0680628744f30b8fac35e41a7bd8e23e59c39f
LIBUMP2_SITE = $(call github,linux-sunxi,libump,$(LIBUMP2_VERSION))
LIBUMP2_LICENSE = Apache-2.0
LIBUMP2_INSTALL_STAGING = YES
LIBUMP2_INSTALL_TARGET = YES
LIBUMP2_AUTORECONF = YES
LIBUMP2_AUTORECONF_OPTS = -i

$(eval $(autotools-package))
