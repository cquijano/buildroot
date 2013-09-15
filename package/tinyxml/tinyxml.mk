#############################################################
#
# tinyxml
#
#############################################################

TINYXML_VERSION = 2.6.2_2
TINYXML_SITE = http://mirrors.xbmc.org/build-deps/sources
TINYXML_AUTORECONF = YES
TINYXML_INSTALL_STAGING = YES

$(eval $(autotools-package))
