################################################################################
#
# python-zippie
#
################################################################################

PYTHON_ZIPPIE_VERSION = 6d568e7a71c2b89c82149391bf6bff51d67e05a1
PYTHON_ZIPPIE_SOURCE = $(PYTHON_ZIPPIE_VERSION).tar.gz
PYTHON_ZIPPIE_SITE = https://github.com/integricho/zippie/archive
PYTHON_ZIPPIE_LICENSE = PROPRIETARY
PYTHON_ZIPPIE_SETUP_TYPE = distutils

$(eval $(python-package))
