# This file is part of MXE.
# See index.html for further information.

PKG             := uriparser
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.8.1
$(PKG)_CHECKSUM := 4405d8baa0d9f5bc0319e6d5e68770acab67b602
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://heanet.dl.sourceforge.net/project/$(PKG)/Sources/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
echo "TODO: to be writen"
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
		--disable-test \
		--disable-doc \
        $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS=
endef
