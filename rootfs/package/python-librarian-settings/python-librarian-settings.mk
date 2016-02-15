################################################################################
#
# python-librarian-settings
#
################################################################################

PYTHON_LIBRARIAN_SETTINGS_VERSION = 2afd4a8545fdf6e8ed33dea2e557aa61b89ad98d
PYTHON_LIBRARIAN_SETTINGS_SOURCE = $(PYTHON_LIBRARIAN_SETTINGS_VERSION).tar.gz
PYTHON_LIBRARIAN_SETTINGS_SITE = https://github.com/Outernet-Project/librarian-settings/archive
PYTHON_LIBRARIAN_SETTINGS_LICENSE = GPL
PYTHON_LIBRARIAN_SETTINGS_SETUP_TYPE = setuptools

$(eval $(python-package))
