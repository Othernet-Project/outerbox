################################################################################
#
# xdriver_xf86-video-fbturbo-ump
#
################################################################################

XDRIVER_XF86_VIDEO_FBTURBO_UMP_VERSION = f9a6ed78419f0b98cf2c3ce3cdd4c97fe9a46195
XDRIVER_XF86_VIDEO_FBTURBO_UMP_SITE = $(call github,ssvb,xf86-video-fbturbo,$(XDRIVER_XF86_VIDEO_FBTURBO_UMP_VERSION))
XDRIVER_XF86_VIDEO_FBTURBO_UMP_LICENSE = MIT
XDRIVER_XF86_VIDEO_FBTURBO_UMP_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_FBTURBO_UMP_DEPENDENCIES = \
	xserver_xorg-server \
	libdrm \
	libump2 \
	pixman \
	xproto_fontsproto \
	xproto_randrproto \
	xproto_renderproto \
	xproto_videoproto \
	xproto_xproto \
	xproto_xf86driproto
XDRIVER_XF86_VIDEO_FBTURBO_UMP_AUTORECONF = YES
XDRIVER_XF86_VIDEO_FBTURBO_UMP_AUTORECONF_OPTS = -vi

ifeq ($(BR2_PACKAGE_LIBPCIACCESS),y)
XDRIVER_XF86_VIDEO_FBTURBO_UMP_DEPENDENCIES += libpciaccess
XDRIVER_XF86_VIDEO_FBTURBO_UMP_CONF_OPTS += --enable-pciaccess
else
XDRIVER_XF86_VIDEO_FBTURBO_UMP_CONF_OPTS += --disable-pciaccess
endif

define XDRIVER_XF86_VIDEO_FBTURBO_UMP_INSTALL_CONF_FILE
	$(INSTALL) -m 0644 -D $(@D)/xorg.conf $(TARGET_DIR)/etc/X11/xorg.conf
endef

XDRIVER_XF86_VIDEO_FBTURBO_UMP_POST_INSTALL_TARGET_HOOKS += XDRIVER_XF86_VIDEO_FBTURBO_UMP_INSTALL_CONF_FILE

$(eval $(autotools-package))
