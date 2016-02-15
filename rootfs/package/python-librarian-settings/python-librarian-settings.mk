################################################################################
#
# python-librarian-settings
#
################################################################################

PYTHON_LIBRARIAN_SETTINGS_VERSION = 79cb7f96159bb36fef50835eac088a8fdde87063
PYTHON_LIBRARIAN_SETTINGS_SOURCE = $(PYTHON_LIBRARIAN_SETTINGS_VERSION).tar.gz
PYTHON_LIBRARIAN_SETTINGS_SITE = https://github.com/Outernet-Project/librarian-settings/archive
PYTHON_LIBRARIAN_SETTINGS_LICENSE = GPL
PYTHON_LIBRARIAN_SETTINGS_SETUP_TYPE = setuptools

$(eval $(python-package))
