#############################################################
#
# jasper (libraries needed by some apps)
#
#############################################################
JASPER_VERSION = 1.900.1
JASPER_SITE = http://sources.openelec.tv/devel
JASPER_SOURCE = jasper-$(JASPER_VERSION).tar.bz2
JASPER_INSTALL_STAGING = YES
JASPER_DEPENDENCIES = jpeg
JASPER_LICENSE = MIT
JASPER_LICENSE_FILE = LICENSE

$(eval $(autotools-package))
