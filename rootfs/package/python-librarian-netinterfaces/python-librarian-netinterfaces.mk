################################################################################
#
# python-librarian-netinterfaces
#
################################################################################

PYTHON_LIBRARIAN_NETINTERFACES_VERSION = 48d9ac3da9683f751f4e02b3c7ab33bbd2101e3d
PYTHON_LIBRARIAN_NETINTERFACES_SOURCE = $(PYTHON_LIBRARIAN_NETINTERFACES_VERSION).tar.gz
PYTHON_LIBRARIAN_NETINTERFACES_SITE = https://github.com/Outernet-Project/librarian-netinterfaces/archive
PYTHON_LIBRARIAN_NETINTERFACES_LICENSE = GPL
PYTHON_LIBRARIAN_NETINTERFACES_SETUP_TYPE = setuptools

$(eval $(python-package))
