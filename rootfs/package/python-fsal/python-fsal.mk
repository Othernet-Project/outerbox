################################################################################
#
# python-fsal
#
################################################################################

PYTHON_FSAL_VERSION = a473ac8ff5b4a5a66a4b32594747a1a1bd29b595
PYTHON_FSAL_SOURCE = $(PYTHON_FSAL_VERSION).tar.gz
PYTHON_FSAL_SITE = https://github.com/Outernet-Project/fsal/archive
PYTHON_FSAL_LICENSE = GPL
PYTHON_FSAL_SETUP_TYPE = setuptools

$(eval $(python-package))
