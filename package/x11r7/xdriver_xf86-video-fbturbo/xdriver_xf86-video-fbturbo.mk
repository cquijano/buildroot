################################################################################
#
# xdriver_xf86-video-fbturbo -- video driver for framebuffer device
#
################################################################################

XDRIVER_XF86_VIDEO_FBTURBO_VERSION = master
XDRIVER_XF86_VIDEO_FBTURBO_SITE = git://github.com/ssvb/xf86-video-fbturbo.git
XDRIVER_XF86_VIDEO_FBTURBO_DEPENDENCIES = xserver_xorg-server xproto_xf86driproto xproto_fontsproto xproto_randrproto xproto_renderproto xproto_videoproto xproto_xproto
XDRIVER_XF86_VIDEO_FBTURBO_AUTORECONF = YES

define XDRIVER_XF86_VIDEO_FBTURBO_INSTALL_XINIT
	cp $(BUILD_DIR)/xorg.conf $(TARGET_DIR)/usr/share/X11/xorg.conf.d/01-fbturbo.conf
endef

$(eval $(autotools-package))
