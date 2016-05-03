# This file is part of MXE.
# See index.html for further information.

PKG             := itk
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.8.2
$(PKG)_CHECKSUM := fec268ba180bdb78d760aa4f6f467d0a5fc71b3a34e3201d8425d0edfa23ef5f
$(PKG)_SUBDIR   := InsightToolkit-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.xz
$(PKG)_URL      := http://$(SOURCEFORGE_MIRROR)/project/$(PKG)/$(PKG)/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc expat hdf5 jpeg libpng tiff zlib
ITK_VER         := 4.8

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://itk.org/ITK/resources/software.html' | \
    $(SED) -n 's,.*InsightToolkit-\([0-9][^>]*\)\.tar\.xz.*,\1,p' | \
    $(SORT) -V |
    tail -1
endef

define $(PKG)_BUILD
    mkdir '$(1).build'
    cd '$(1).build' && '$(TARGET)-cmake' \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DCMAKE_VERBOSE_MAKEFILE=TRUE \
        -DITK_FORBID_DOWNLOADS=TRUE \
        -DBUILD_TESTING=FALSE \
        -DBUILD_EXAMPLES=FALSE \
        -DITK_USE_SYSTEM_EXPAT=TRUE \
        -DITK_USE_SYSTEM_HDF5=TRUE \
        -DITK_USE_SYSTEM_JPEG=TRUE \
        -DITK_USE_SYSTEM_PNG=TRUE \
        -DITK_USE_SYSTEM_TIFF=TRUE \
        -DITK_USE_SYSTEM_ZLIB=TRUE \
        '$(1)'
    $(MAKE) -C '$(1).build' -j '$(JOBS)' install VERBOSE=1

#[OTB] For relocatable development files. hack hack.. heck!
	$(SED) -i 's,set.CMAKE_IMPORT_FILE_VERSION..., \
	set(CMAKE_IMPORT_FILE_VERSION 1)\n \
	set(LIB_INSTALL_PREFIX)\n \
	get_filename_component(CURRENT_FILE_DIR \"$${CMAKE_CURRENT_LIST_FILE}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${CURRENT_FILE_DIR}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH),g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/ITKTargets-release.cmake'

	$(SED) -i 's,set.ITKZLIB_LOADED..., \
	set(ITKZLIB_LOADED 1)\n \
	set(LIB_INSTALL_PREFIX)\n \
	get_filename_component(CURRENT_FILE_DIR \"$${CMAKE_CURRENT_LIST_FILE}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${CURRENT_FILE_DIR}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX\ \"$${LIB_INSTALL_PREFIX}\" PATH),g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKZLIB.cmake'

	$(SED) -i 's,set.ITKExpat_LOADED..., \
	set(ITKExpat_LOADED 1)\n \
	set(LIB_INSTALL_PREFIX)\n \
	get_filename_component(CURRENT_FILE_DIR \"$${CMAKE_CURRENT_LIST_FILE}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${CURRENT_FILE_DIR}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX\ \"$${LIB_INSTALL_PREFIX}\" PATH),g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKExpat.cmake'

	$(SED) -i 's,set.ITKHDF5_LOADED..., \
	set(ITKHDF5_LOADED 1)\n \
	set(LIB_INSTALL_PREFIX)\n \
	get_filename_component(CURRENT_FILE_DIR \"$${CMAKE_CURRENT_LIST_FILE}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${CURRENT_FILE_DIR}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX\ \"$${LIB_INSTALL_PREFIX}\" PATH),g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKHDF5.cmake'

	$(SED) -i 's,set.ITKJPEG_LOADED..., \
	set(ITKJPEG_LOADED 1)\n \
	set(LIB_INSTALL_PREFIX)\n \
	get_filename_component(CURRENT_FILE_DIR \"$${CMAKE_CURRENT_LIST_FILE}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${CURRENT_FILE_DIR}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX\ \"$${LIB_INSTALL_PREFIX}\" PATH),g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKJPEG.cmake'

	$(SED) -i 's,set.ITKTIFF_LOADED..., \
	set(ITKTIFF_LOADED 1)\n \
	set(LIB_INSTALL_PREFIX)\n \
	get_filename_component(CURRENT_FILE_DIR \"$${CMAKE_CURRENT_LIST_FILE}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${CURRENT_FILE_DIR}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX\ \"$${LIB_INSTALL_PREFIX}\" PATH),g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKTIFF.cmake'

	$(SED) -i 's,set.ITKPNG_LOADED..., \
	set(ITKPNG_LOADED 1)\n \
	set(LIB_INSTALL_PREFIX)\n \
	get_filename_component(CURRENT_FILE_DIR \"$${CMAKE_CURRENT_LIST_FILE}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${CURRENT_FILE_DIR}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX \"$${LIB_INSTALL_PREFIX}\" PATH)\n \
	get_filename_component(LIB_INSTALL_PREFIX\ \"$${LIB_INSTALL_PREFIX}\" PATH),g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKPNG.cmake'

	$(SED) -i 's,$(PREFIX)/$(TARGET),\${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/ITKTargets-release.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKZLIB.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKExpat.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKHDF5.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKJPEG.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKTIFF.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKPNG.cmake'

endef
