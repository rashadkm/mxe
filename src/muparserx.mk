# This file is part of MXE.
# See index.html for further information.

PKG             := muparserx
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3_0_3
$(PKG)_CHECKSUM := d476899a024b6b720591484f615464dc1eb25b23
$(PKG)_SUBDIR   := $(PKG)_v$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)_v3_0_2.zip
$(PKG)_URL 	    := https://sourceforge.net/projects/mxedeps/files/$($(PKG)_FILE)
$(PKG)_URL_2    := http://muparserx.googlecode.com/svn/archives/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
echo "TODO: write update for muparserx"
endef

define $(PKG)_BUILD
    mkdir '$(1).build'
    cd '$(1).build' && cmake \
        -DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)' \
        -DBUILD_SHARED_LIBS=$(if $(BUILD_STATIC),FALSE,TRUE) \
        '$(1)'
	$(MAKE) -C '$(1).build' install
endef
