#############################################################
#
# xinelib
#
#############################################################
XINELIB_VERSION = 1.2.6
XINELIB_SITE = http://downloads.sourceforge.net/project/xine/xine-lib/$(XINELIB_VERSION)
XINELIB_SOURCE = xine-lib-$(XINELIB_VERSION).tar.xz

XINELIB_INSTALL_STAGING = YES
XINELIB_INSTALL_TARGET = YES
XINELIB_SECTION = multimedia
XINELIB_DESCRIPTION = Multimedia player
XINELIB_DEPENDENCIES = ffmpeg xlib_libSM xlib_libXv xlib_libICE xlib_libXext mesa3d alsa-lib libvdpau libbluray libmad libmodplug libvorbis
XINELIB_CONF_OPTS = --disable-ipv6 \
  --disable-nls \
  --disable-aalib \
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
  --without-xcb \
  --with-libFLAC-libraries=$(STAGING_DIR)/usr/lib \
  --with-libFLAC-includes=$(STAGING_DIR)/usr/include
$(eval $(autotools-package))

