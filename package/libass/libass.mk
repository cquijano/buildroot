#############################################################
#
# libass
#
#############################################################
LIBASS_VERSION = 0.9.12
LIBASS_SITE = http://libass.googlecode.com/files
LIBASS_INSTALL_STAGING = YES
LIBASS_DEPENDENCIES = freetype fontconfig libenca
LIBASS_LICENSE = BSD-3c
LIBASS_LICENSE_FILES = COPYING

$(eval $(autotools-package))
