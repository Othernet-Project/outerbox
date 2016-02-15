################################################################################
#
# python-librarian-settings
#
################################################################################

PYTHON_LIBRARIAN_SETTINGS_VERSION = e688766f71e31f820db56b21e188ee9cefc67f0e
PYTHON_LIBRARIAN_SETTINGS_SOURCE = $(PYTHON_LIBRARIAN_SETTINGS_VERSION).tar.gz
PYTHON_LIBRARIAN_SETTINGS_SITE = https://github.com/Outernet-Project/librarian-settings/archive
PYTHON_LIBRARIAN_SETTINGS_LICENSE = GPL
PYTHON_LIBRARIAN_SETTINGS_SETUP_TYPE = setuptools

$(eval $(python-package))
