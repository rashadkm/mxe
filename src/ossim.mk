# This file is part of MXE.
# See index.html for further information.

PKG             := ossim
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.8.20
$(PKG)_CHECKSUM := f01be0296b872b6696ab810fe4fb1e00f297002dc0ded19b0033595dde59ab33
#$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)-1
$(PKG)_SUBDIR   := $(PKG)-minimal-r23537
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.gz
#$(PKG)_URL      := http://download.osgeo.org/ossim/source/$(PKG)-$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_URL      := https://www.orfeo-toolbox.org/packages/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc freetype geos jpeg libpng openthreads proj tiff zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://download.osgeo.org/ossim/source/latest/' | \
    $(SED) -n 's,.*ossim-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    mkdir '$(1).build'
    cd '$(1).build' && '$(TARGET)-cmake' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DCMAKE_VERBOSE_MAKEFILE=TRUE \
        -DPKG_CONFIG_EXECUTABLE='$(PREFIX)/bin/$(TARGET)-pkg-config' \
        -DCMAKE_MODULE_PATH='$(1)/ossim_package_support/cmake/CMakeModules' \
        -DBUILD_OSSIM_FREETYPE_SUPPORT=TRUE \
        -DBUILD_OSSIM_CURL_APPS=FALSE \
        -DBUILD_OSSIM_TEST_APPS=FALSE \
        -DBUILD_OSSIM_APPS=FALSE \
        -DCMAKE_CXX_FLAGS='-DGEOS_INLINE=1' \
        '$(1)/ossim'

    $(MAKE) -C '$(1).build' -j '$(JOBS)' install VERBOSE=1
endef
