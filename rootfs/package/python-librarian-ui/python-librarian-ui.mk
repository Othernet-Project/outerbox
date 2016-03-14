################################################################################
#
# python-librarian-ui
#
################################################################################

PYTHON_LIBRARIAN_UI_VERSION = 7612cf49593396d82651cda62a42619b631b9eaa
PYTHON_LIBRARIAN_UI_SITE = $(call github,Outernet-Project,librarian-ui,$(PYTHON_LIBRARIAN_UI_VERSION))
PYTHON_LIBRARIAN_UI_LICENSE = GPL
PYTHON_LIBRARIAN_UI_SETUP_TYPE = setuptools

$(eval $(python-package))
