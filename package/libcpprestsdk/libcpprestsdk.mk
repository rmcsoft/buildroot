################################################################################
#
# libcpprestsdk
#
################################################################################

LIBCPPRESTSDK_VERSION = v2.10.10
LIBCPPRESTSDK_SITE = $(call github,Microsoft,cpprestsdk,$(LIBCPPRESTSDK_VERSION))
LIBCPPRESTSDK_LICENSE = MIT
LIBCPPRESTSDK_LICENSE_FILES = license.txt
LIBCPPRESTSDK_SUBDIR = Release
LIBCPPRESTSDK_DEPENDENCIES += host-pkgconf boost openssl zlib
LIBCPPRESTSDK_CONF_OPTS = -DWERROR=OFF -DBUILD_SAMPLES=OFF

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
LIBCPPRESTSDK_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -latomic"
endif

ifeq ($(BR2_PACKAGE_WEBSOCKETPP),y)
LIBCPPRESTSDK_DEPENDENCIES += websocketpp
LIBCPPRESTSDK_CONF_OPTS += -DCPPREST_EXCLUDE_WEBSOCKETS=OFF
else
LIBCPPRESTSDK_CONF_OPTS += -DCPPREST_EXCLUDE_WEBSOCKETS=ON
endif

$(eval $(cmake-package))
