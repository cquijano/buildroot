#############################################################
#
# libcdio
#
#############################################################
LIBCDIO_VERSION = 0.82
LIBCDIO_SITE = $(BR2_GNU_MIRROR)/libcdio
LIBCDIO_INSTALL_STAGING = YES
LIBCDIO_LICENSE = GPLv3
LIBCDIO_LICENSE_FILES = COPYING

$(eval $(autotools-package))
