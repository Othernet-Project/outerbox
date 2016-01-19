#############################################################
#
# vdr
#
#############################################################
VDR_VERSION = 2.2.0
VDR_SITE = ftp://ftp.tvdr.de/vdr
VDR_SOURCE = vdr-$(VDR_VERSION).tar.bz2

VDR_XINELIBOUTPUT_VERSION = 1.1.0
VDR_XINELIBOUTPUT_SITE = http://downloads.sourceforge.net/project/xineliboutput/xineliboutput/vdr-xineliboutput-$(VDR_XINELIBOUTPUT_VERSION)
VDR_XINELIBOUTPUT_SOURCE = vdr-xineliboutput-$(VDR_XINELIBOUTPUT_VERSION).tgz
VDR_XINELIBOUTPUT_URL = $(VDR_XINELIBOUTPUT_SITE)/$(VDR_XINELIBOUTPUT_SOURCE)

VDR_INSTALL_STAGING = NO
VDR_INSTALL_TARGET = YES
VDR_SECTION = multimedia
VDR_DESCRIPTION = Video Disk Recorder
VDR_DEPENDENCIES = libcap fontconfig freetype jpeg

define VDR_XINELIBOUTPUT_DOWNLOAD
	$(call DOWNLOAD,$(VDR_XINELIBOUTPUT_URL))
endef

define VDR_XINELIBOUTPUT_EXTRACT
	mkdir -p $(VDR_DIR)/PLUGINS/src/xineliboutput
	$(if $(VDR_XINELIBOUTPUT_SOURCE),$(INFLATE$(suffix $(VDR_XINELIBOUTPUT_SOURCE))) $(DL_DIR)/$(VDR_XINELIBOUTPUT_SOURCE) | \
	$(TAR) --strip-components=1 -C $(VDR_DIR)/PLUGINS/src/xineliboutput $(TAR_OPTIONS) -)
endef

XINELIBOUTPUT_CONFIGURE_OPTS = --disable-libextractor \
  --disable-dbus-glib-1 \
  --disable-xdpms \
  --disable-xinerama \
  --disable-xshape \
  --cc="$(TARGET_CC)" \
  --cxx="$(TARGET_CXX)" \
  --add-cflags="$(TARGET_CFLAGS)"

define VDR_XINELIBOUTPUT_POST_PATCH
	sed -i -e 's|^XINELIBOUTPUT_CONFIGURE_OPTS\ \=|XINELIBOUTPUT_CONFIGURE_OPTS=$(XINELIBOUTPUT_CONFIGURE_OPTS)|' $(VDR_DIR)/PLUGINS/src/xineliboutput/Makefile
endef

ifeq ($(BR2_PACKAGE_VDR_XINELIBOUTPUT),y)
VDR_POST_DOWNLOAD_HOOKS += VDR_XINELIBOUTPUT_DOWNLOAD
VDR_POST_EXTRACT_HOOKS += VDR_XINELIBOUTPUT_EXTRACT
VDR_POST_PATCH_HOOKS += VDR_XINELIBOUTPUT_POST_PATCH
VDR_DEPENDENCIES += xinelib xlib_libXrender

endif
define VDR_REMOVE_SKINCURSES
	rm -rf $(VDR_DIR)/PLUGINS/src/skincurses
endef
VDR_POST_EXTRACT_HOOKS += VDR_REMOVE_SKINCURSES

define VDR_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) STRIP=$(TARGET_CROSS)strip CPUOPT=atom PARALLEL=PARALLEL_128_SSE HOST_CC="$(HOSTCC)" PREFIX=/usr VIDEODIR=/export/vdr/video CONFDIR=/etc/vdr $(MAKE) -C $(@D)
endef

define VDR_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(TARGET_DIR) PREFIX=/usr VIDEODIR=/export/vdr/video CONFDIR=/etc/vdr $(MAKE) -C $(@D) install
endef

define VDR_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/vdr/S50vdr \
		$(TARGET_DIR)/etc/init.d/S50vdr
endef

$(eval $(generic-package))

