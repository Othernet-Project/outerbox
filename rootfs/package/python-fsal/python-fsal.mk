################################################################################
#
# python-fsal
#
################################################################################

PYTHON_FSAL_VERSION = 6e773033c5a066fba0e5545b7230b06304bd42aa
PYTHON_FSAL_SOURCE = $(PYTHON_FSAL_VERSION).tar.gz
PYTHON_FSAL_SITE = https://github.com/Outernet-Project/fsal/archive
PYTHON_FSAL_LICENSE = GPL
PYTHON_FSAL_SETUP_TYPE = setuptools

$(eval $(python-package))
