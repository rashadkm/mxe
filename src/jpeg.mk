# This file is part of MXE.
# See index.html for further information.

PKG             := jpeg
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.4.1
$(PKG)_CHECKSUM := 363a149f644211462c45138a19674f38100036d3
$(PKG)_SUBDIR   := libjpeg-turbo-$($(PKG)_VERSION)
$(PKG)_FILE     := libjpeg-turbo-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://sourceforge.net/projects/libjpeg-turbo/files/1.4.1/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://www.ijg.org/' | \
    $(SED) -n 's,.*jpegsrc\.v\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-jpeg8 \
        --without-simd \
        --without-java

    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS= man_MANS=

    # create pkg-config file
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'Name: jpeg'; \
     echo 'Version: 0'; \
     echo 'Description: jpeg'; \
     echo 'Libs: -ljpeg';) \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/jpeg.pc'

    '$(TARGET)-gcc' \
        -W -Wall -Werror -ansi -pedantic \
        '$(2).c' -o '$(PREFIX)/$(TARGET)/bin/test-jpeg.exe' \
        `'$(TARGET)-pkg-config' jpeg --libs`
endef
