# This file is part of MXE.
# See index.html for further information.

PKG             := openblas
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.2.8
$(PKG)_CHECKSUM := d012ebc2b8dcd3e95f667dff08318a81479a47c3
$(PKG)_SUBDIR   := OpenBLAS-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.gz
$(PKG)_URL      := http://github.com/xianyi/OpenBLAS/archive/v$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://github.com/xianyi/OpenBLAS/releases' | \
    $(SED) -n 's,.*OpenBLAS/archive/v\([0-9][^"]*\)\.tar\.gz.*,\1,p' | \
    grep -v 'rc' | \
    $(SORT) -V | \
    tail -1
endef

$(PKG)_MAKE_OPTS = \
        PREFIX='$(PREFIX)/$(TARGET)' \
        CROSS_SUFFIX='$(TARGET)-' \
        FC='$(TARGET)-gfortran' \
        CC='$(TARGET)-gcc' \
        HOSTFC='gfortran' \
        HOSTCC='gcc' \
        CROSS=1 \
        NO_CBLAS=1 \
        NO_LAPACK=1 \
        USE_THREAD=0 \
        TARGET=CORE2 \
        DYNAMIC_ARCH=1 \
        BINARY=$(if $(findstring x86_64,$(TARGET)),64,32) \
        $(if $(BUILD_STATIC),NO_SHARED=1)

define $(PKG)_BUILD
    $(MAKE) -C '$(1)' -j '$(JOBS)' $($(PKG)_MAKE_OPTS)
    $(MAKE) -C '$(1)' -j 1 install $($(PKG)_MAKE_OPTS)
endef
