################################################################################
#
# python-fsal
#
################################################################################

PYTHON_FSAL_VERSION = b32da3e4c9afae5d44367bbb829d567757778250
PYTHON_FSAL_SOURCE = $(PYTHON_FSAL_VERSION).tar.gz
PYTHON_FSAL_SITE = https://github.com/Outernet-Project/fsal/archive
PYTHON_FSAL_LICENSE = GPL
PYTHON_FSAL_SETUP_TYPE = setuptools

$(eval $(python-package))
