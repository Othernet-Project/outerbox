#############################################################
#
# xinelib
#
#############################################################
XINELIB_VERSION = 1.2.6
XINELIB_SITE = http://downloads.sourceforge.net/project/xine/xine-lib/$(XINELIB_VERSION)
XINELIB_SOURCE = xine-lib-$(XINELIB_VERSION).tar.xz

XINELIB_INSTALL_STAGING = NO
XINELIB_INSTALL_TARGET = YES
XINELIB_SECTION = multimedia
XINELIB_DESCRIPTION = Multimedia player
XINE_LIB_DEPENDENCIES = ffmpeg xlib_libXv xlib_libICE xlib_libXext mesa3d alsa-lib libvdpau libbluray libmad libmodplug libvorbis
XINE_LIB_OPKG_DEPENDENCIES = ffmpeg,libxv,libice,libxext,mesa,alsa-lib,libvdpau,libbluray,libmad,libmodplug,libvorbis

# XINE_LIB_CFLAGS=$(TARGET_CFLAGS)

XINE_LIB_CONF_OPT = --disable-ipv6 \
  --disable-nls \
  --disable-aalib \
  --disable-directfb \
  --disable-fb \
  --enable-opengl \
  --enable-glu \
  --disable-vidix \
  --disable-xinerama \
  --disable-static-xv \
  --disable-xvmc \
  --enable-vdpau \
  --with-x \
  --with-alsa \
  --without-sdl \
  --without-imagemagick \
  --disable-vcd \
  --disable-musepack \
  --disable-iconvtest \
  --disable-dxr3 \
  --disable-oss \
  --disable-gdkpixbuf \
  --without-xcb

$(eval $(generic-package))

