################################################################################
#
# python-librarian-library
#
################################################################################

PYTHON_LIBRARIAN_LIBRARY_VERSION = 75174c430de5b702b6e0b97c4c9cf3dad54df9a3
PYTHON_LIBRARIAN_LIBRARY_SOURCE = $(PYTHON_LIBRARIAN_LIBRARY_VERSION).tar.gz
PYTHON_LIBRARIAN_LIBRARY_SITE = https://github.com/Outernet-Project/librarian-library/archive
PYTHON_LIBRARIAN_LIBRARY_LICENSE = GPL
PYTHON_LIBRARIAN_LIBRARY_DEPENDENCIES = python-librarian-core python-librarian-content python-librarian-filemanager python-scandir
PYTHON_LIBRARIAN_LIBRARY_SETUP_TYPE = setuptools

$(eval $(python-package))
