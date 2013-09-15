################################################################################
#
# xbmc
#
#################################################################################

XBMC_VERSION = d86d6ba9fbf7263ba0c652d5c7f4f919e8cba485
XBMC_SITE_METHOD = git
XBMC_SITE = https://github.com/xbmc/xbmc.git
XBMC_INSTALL_STAGING = YES
XBMC_INSTALL_TARGET = YES
XBMC_LICENSE = GPLv2
XBMC_LICENSE_FILES = LICENSE.GPL

XBMC_DEPENDENCIES = host-lzo host-sdl 
XBMC_MAKE_OPT += -j1

XBMC_CONF_ENV += PYTHON_VERSION="$(PYTHON_VERSION_MAJOR)"
XBMC_CONF_ENV += PYTHON_LDFLAGS="-L$(STAGING_DIR)/usr/lib/ -lpython$(PYTHON_VERSION_MAJOR) -lpthread -ldl -lutil -lm"
XBMC_CONF_ENV += PYTHON_CPPFLAGS="-I$(STAGING_DIR)/usr/include/python$(PYTHON_VERSION_MAJOR)"
XBMC_CONF_ENV += PYTHON_SITE_PKG="$(STAGING_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages"
XBMC_CONF_ENV += PYTHON_NOVERSIONCHECK="no-check"
XBMC_CONF_ENV += USE_TEXTUREPACKER_NATIVE_ROOT="$(STAGING_DIR)/usr"
XBMC_PLATFORM = default

XBMC_CONF_OPT += --enable-gles --disable-gl --disable-sdl --disable-x11 --disable-xrandr \
               --disable-openmax --disable-optical-drive --disable-dvdcss --disable-joystick \
               --disable-debug --disable-crystalhd --disable-vtbdecoder --disable-vaapi \
               --disable-vdpau --disable-pulse --disable-projectm --enable-optimizations \
               --disable-alsa --disable-ssh --disable-hal 

XBMC_DEPENDENCIES += libmpeg2 bzip2 python lzo zlib libgcrypt \
		openssl sqlite fontconfig freetype jpeg  \
		libpng libungif tiff libcurl boost libfribidi ncurses pcre \
		readline expat libxml2 yajl taglib \
		libass libmodplug tinyxml jasper libcdio sdl \
#		jasper libcdio libmodplug libplist tinyxml \ 

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
XBMC_DEPENDENCIES += rpi-userland
XBMC_CONF_OPT += --with-platform=raspberry-pi --enable-player=omxplayer
XBMC_PLATFORM = raspberrypi
XBMC_CONF_ENV += INCLUDES="-I$(STAGING_DIR)/opt/vc/include \
			-I$(STAGING_DIR)/usr/include \
			-I$(STAGING_DIR)/opt/vc/include/interface/vcos/pthreads \
			-I$(STAGING_DIR)/opt/vc/include/interface/vmcs_host/linux"

XBMC_CONF_ENV += LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/opt/vc/lib"
endif

ifeq ($(BR2_PACKAGE_DBUS),y)
XBMC_DEPENDENCIES += dbus
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBUSB),y)
XBMC_DEPENDENCIES += libusb-compat
XBMC_CONF_OPT += --enable-libusb
else
XBMC_CONF_OPT += --disable-libusb
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBMICROHTTPD),y)
XBMC_DEPENDENCIES += libmicrohttpd
XBMC_CONF_OPT += --enable-webserver
else
XBMC_CONF_OPT += --disable-webserver
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBSMBCLIENT),y)
XBMC_DEPENDENCIES += samba
XBMC_CONF_OPT += --enable-samba
else
XBMC_CONF_OPT += --disable-samba
endif

ifeq ($(BR2_PACKAGE_XBMC_MYSQL_CLIENT),y)
XBMC_DEPENDENCIES += mysql_client
XBMC_CONF_OPT += --enable-mysql
else
XBMC_CONF_OPT += --disable-mysql
endif

ifeq ($(BR2_PACKAGE_XBMC_VORBIS),y)
XBMC_DEPENDENCIES += libogg libvorbis
XBMC_CONF_OPT += --enable-libvorbisenc
else
XBMC_CONF_OPT += --disable-libvorbisenc
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBNFS),y)
XBMC_DEPENDENCIES += libnfs
XBMC_CONF_OPT += --enable-nfs
else
XBMC_CONF_OPT += --disable-nfs
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBRTMP),y)
XBMC_DEPENDENCIES += librtmp
XBMC_CONF_OPT += --enable-rtmp
else
XBMC_CONF_OPT += --disable-rtmp
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBBLURAY),y)
XBMC_DEPENDENCIES += libbluray
XBMC_CONF_OPT += --enable-libbluray
else
XBMC_CONF_OPT += --disable-libbluray
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBSHAIRPORT),y)
XBMC_DEPENDENCIES += libshairport
XBMC_CONF_OPT += --enable-airplay
else
XBMC_CONF_OPT += --disable-airplay
endif

ifeq ($(BR2_PACKAGE_XBMC_AVAHI),y)
XBMC_DEPENDENCIES += avahi
XBMC_CONF_OPT += --enable-avahi
else
XBMC_CONF_OPT += --disable-avahi
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBCEC),y)
XBMC_DEPENDENCIES += libcec
XBMC_CONF_OPT += --enable-libcec
else
XBMC_CONF_OPT += --disable-libcec
endif

ifeq ($(BR2_PACKAGE_XBMC_FLAC),y)
XBMC_DEPENDENCIES += flac
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBASS),y)
XBMC_DEPENDENCIES += libass
endif

ifeq ($(BR2_PACKAGE_XBMC_MAD),y)
XBMC_DEPENDENCIES += libmad
endif

ifeq ($(BR2_PACKAGE_XBMC_LIBSAMPLERATE),y)
XBMC_DEPENDENCIES += libsamplerate
endif

ifeq ($(BR2_PACKAGE_XBMC_WAVPACK),y)
XBMC_DEPENDENCIES += wavpack
endif

define XBMC_BOOTSTRAP
	cd $(@D) && ./bootstrap
endef

define XBMC_INSTALL_ETC
	$(INSTALL) -D -d -m 755 $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 755 package/xbmc/S99xbmc.$(XBMC_PLATFORM) $(TARGET_DIR)/etc/init.d/S99xbmc
endef

define XBMC_CLEAN_UNUSED_ADDONS
	rm -rf $(TARGET_DIR)/usr/share/xbmc/addons/screensaver.rsxs.plasma
	rm -rf $(TARGET_DIR)/usr/share/xbmc/addons/visualization.milkdrop
	rm -rf $(TARGET_DIR)/usr/share/xbmc/addons/visualization.projectm
	rm -rf $(TARGET_DIR)/usr/share/xbmc/addons/visualization.itunes
endef

define XBMC_CLEAN_CONFLUENCE_SKIN
	find $(TARGET_DIR)/usr/share/xbmc/addons/skin.confluence/media -name *.png -delete
	find $(TARGET_DIR)/usr/share/xbmc/addons/skin.confluence/media -name *.jpg -delete
endef

XBMC_PRE_CONFIGURE_HOOKS += XBMC_BOOTSTRAP
XBMC_POST_INSTALL_TARGET_HOOKS += XBMC_INSTALL_ETC
XBMC_POST_INSTALL_TARGET_HOOKS += XBMC_CLEAN_UNUSED_ADDONS
XBMC_POST_INSTALL_TARGET_HOOKS += XBMC_CLEAN_CONFLUENCE_SKIN

$(eval $(autotools-package))
