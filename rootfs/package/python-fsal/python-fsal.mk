################################################################################
#
# python-fsal
#
################################################################################

PYTHON_FSAL_VERSION = 58b26a82898c70f1fc1835a9eb467f0cd9e08a45
PYTHON_FSAL_SITE = $(call github,Outernet-Project,fsal,$(PYTHON_FSAL_VERSION))
PYTHON_FSAL_LICENSE = GPL
PYTHON_FSAL_SETUP_TYPE = setuptools

$(eval $(python-package))
