################################################################################
#
# python-librarian-content
#
################################################################################

PYTHON_LIBRARIAN_CONTENT_VERSION = c71bb0325add063edc4afedf6f543ede2ca664b7
PYTHON_LIBRARIAN_CONTENT_SOURCE = $(PYTHON_LIBRARIAN_CONTENT_VERSION).tar.gz
PYTHON_LIBRARIAN_CONTENT_SITE = https://github.com/Outernet-Project/librarian-content/archive
PYTHON_LIBRARIAN_CONTENT_LICENSE = GPL
PYTHON_LIBRARIAN_CONTENT_SETUP_TYPE = setuptools

$(eval $(python-package))
