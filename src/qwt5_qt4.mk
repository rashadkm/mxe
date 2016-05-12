# This file is part of MXE.
# See index.html for further information.

PKG             := qwt5_qt4
$(PKG)_VERSION  := 5.2.3
$(PKG)_CHECKSUM := 37feaf306753230b0d8538b4ff9b255c6fddaa3d6609ec5a5cc39a5a4d020ab7
$(PKG)_SUBDIR   := qwt-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_WEBSITE  := http://qwt.sourceforge.net/
$(PKG)_URL      := http://sourceforge.net/projects/qwt/files/qwt/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc qt

define $(PKG)_UPDATE
    echo 'TODO: Updates for package qwt_qt4 need to be written.' >&2;
endef

define $(PKG)_BUILD

    $(SED) -i 's,INSTALLBASE.*=.*VERSION,INSTALLBASE=$(PREFIX)/$(TARGET),g' '$(1)/qwtconfig.pri'
    $(SED) -i 's,target\.path.*=.*INSTALLBASE/lib,target.path=$(PREFIX)/$(TARGET)/bin,g' '$(1)/qwtconfig.pri'

    $(if $(BUILD_SHARED),\
        echo "LIBS += -L$(PREFIX)/$(TARGET)/bin -lqwt5" >> '$(1)/examples/simple_plot/simple_plot.pro')

    $(if $(BUILD_STATIC),\
        echo "QWT_CONFIG -= QwtDll" >> '$(1)/qwtconfig.pri')
    # build
    cd '$(1)/src' && $(PREFIX)/$(TARGET)/qt/bin/qmake
    $(MAKE) -C '$(1)/src' -f 'Makefile.Release' -j '$(JOBS)' install

    #build simple_plot example to test linkage
    cd '$(1)/examples/simple_plot' && $(PREFIX)/$(TARGET)/qt/bin/qmake
    $(MAKE) -C '$(1)/examples/simple_plot' -f 'Makefile.Release' -j '$(JOBS)'

    # install
    $(INSTALL) -m755 '$(1)/examples/bin/simple.exe' '$(PREFIX)/$(TARGET)/bin/test-qwt5-qt4.exe'
    $(if $(BUILD_SHARED),\
      rm -f $(PREFIX)/$(TARGET)/bin/libqwt5.a)
endef
