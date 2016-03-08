################################################################################
#
# python-librarian-filemanager
#
################################################################################

PYTHON_LIBRARIAN_FILEMANAGER_VERSION = e85855f1c31c8196aa7d613e8f1908e368a7ba26
PYTHON_LIBRARIAN_FILEMANAGER_SOURCE = $(PYTHON_LIBRARIAN_FILEMANAGER_VERSION).tar.gz
PYTHON_LIBRARIAN_FILEMANAGER_SITE = https://github.com/Outernet-Project/librarian-filemanager/archive
PYTHON_LIBRARIAN_FILEMANAGER_LICENSE = GPL
PYTHON_LIBRARIAN_FILEMANAGER_DEPENDENCIES = python-librarian-core python-librarian-content
PYTHON_LIBRARIAN_FILEMANAGER_SETUP_TYPE = setuptools

$(eval $(python-package))
