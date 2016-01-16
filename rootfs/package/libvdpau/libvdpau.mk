#############################################################
#
# libvdpau
#
#############################################################
LIBVDPAU_VERSION = 1.1.1
LIBVDPAU_SITE = http://people.freedesktop.org/~aplattner/vdpau
LIBVDPAU_SOURCE = libvdpau-$(LIBVDPAU_VERSION).tar.gz
LIBVDPAU_INSTALL_STAGING = YES
LIBVDPAU_INSTALL_TARGET = YES
LIBVDPAU_SECTION = multimedia
LIBVDPAU_DESCRIPTION = a Video Decode and Presentation API for UNIX.
LIBVDPAU_DEPENDENCIES = xlib_libX11
LIBVDPAU_CONF_OPTS = \
  --disable-documentation \
  --enable-dri2 \
#  --with-module-dir=/usr/lib/vdpau

$(eval $(autotools-package))
