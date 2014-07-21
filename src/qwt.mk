# This file is part of MXE.
# See index.html for further information.

PKG             := qwt
$(PKG)_VERSION  := 5.2.2
$(PKG)_CHECKSUM := 22abf7675aaf39cf2be400caa6dd78e8bdce4709
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).zip
$(PKG)_WEBSITE  := http://qwt.sourceforge.net/
$(PKG)_URL      := http://$(SOURCEFORGE_MIRROR)/project/$(PKG)/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc qtbase qtsvg

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://sourceforge.net/projects/qwt/files/qwt/' | \
    $(SED) -n 's,.*/\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    $(if $(BUILD_STATIC),\
        echo "QWT_CONFIG -= QwtDll" >> '$(1)/qwtconfig.pri')

    # build
    cd '$(1)/src' && $(PREFIX)/$(TARGET)/qt5/bin/qmake
    $(MAKE) -C '$(1)/src' -f 'Makefile.Release' -j '$(JOBS)' install

    #build sinusplot example to test linkage
    cd '$(1)/examples/sinusplot' && $(PREFIX)/$(TARGET)/qt5/bin/qmake
    $(MAKE) -C '$(1)/examples/sinusplot' -f 'Makefile.Release' -j '$(JOBS)'

    # install
    $(INSTALL) -m755 '$(1)/examples/bin/sinusplot.exe' '$(PREFIX)/$(TARGET)/bin/test-qwt.exe'
endef
