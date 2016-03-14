################################################################################
#
# python-greentasks
#
################################################################################

PYTHON_GREENTASKS_VERSION = 58b26a82898c70f1fc1835a9eb467f0cd9e08a45
PYTHON_GREENTASKS_SITE = $(call github,Outernet-Project,greentasks,$(PYTHON_GREENTASKS_VERSION))
PYTHON_GREENTASKS_LICENSE = GPL
PYTHON_GREENTASKS_SETUP_TYPE = setuptools

$(eval $(python-package))
