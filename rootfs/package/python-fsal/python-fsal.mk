################################################################################
#
# python-fsal
#
################################################################################

PYTHON_FSAL_VERSION = 1698479a0fee355c1c544ceeed5884a74ed81585
PYTHON_FSAL_SOURCE = $(PYTHON_FSAL_VERSION).tar.gz
PYTHON_FSAL_SITE = https://github.com/Outernet-Project/fsal/archive
PYTHON_FSAL_LICENSE = GPL
PYTHON_FSAL_SETUP_TYPE = setuptools

$(eval $(python-package))
