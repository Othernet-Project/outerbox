################################################################################
#
# python-fsal
#
################################################################################

PYTHON_FSAL_VERSION = 1cf490e93e26399e593f61a4bb84e22a592bdc1f
PYTHON_FSAL_SOURCE = $(PYTHON_FSAL_VERSION).tar.gz
PYTHON_FSAL_SITE = https://github.com/Outernet-Project/fsal/archive
PYTHON_FSAL_LICENSE = GPL
PYTHON_FSAL_SETUP_TYPE = setuptools

$(eval $(python-package))
