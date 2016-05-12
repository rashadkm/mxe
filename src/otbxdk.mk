# This file is part of MXE.
# See index.html for further information.

#https://www.orfeo-toolbox.org/packages/qt4-native-tools-win64.zip

PKG             := otbxdk
$(PKG)_IGNORE   :=
$(PKG)_VERSION := 1
$(PKG)_UPDATE  := echo 1
$(PKG)_CHECKSUM := 5ef5aee09a3d30800a489b12ec41f3b708a3212a79985cc7685d8f3124f9ccd2
$(PKG)_SUBDIR   := qt4-native-tools
$(PKG)_FILE     := $($(PKG)_SUBDIR).zip
$(PKG)_URL      := https://www.orfeo-toolbox.org/packages/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc
ITK_VER         :=  $(basename $(itk_VERSION))

define $(PKG)_BUILD

  echo "$(ITK_VER)"

	cp '$(1)/$(TARGET)/lrelease.exe' '$(PREFIX)/$(TARGET)/bin/'
	cp '$(1)/$(TARGET)/moc.exe' '$(PREFIX)/$(TARGET)/bin/'
	cp '$(1)/$(TARGET)/qmake.exe' '$(PREFIX)/$(TARGET)/bin/'
	cp '$(1)/$(TARGET)/rcc.exe' '$(PREFIX)/$(TARGET)/bin/'
	cp '$(1)/$(TARGET)/uic.exe' '$(PREFIX)/$(TARGET)/bin/'

	$(SED) -i 's,.{OpenCV_ARCH}/.{OpenCV_RUNTIME}/,,g' '$(PREFIX)/$(TARGET)/OpenCVConfig.cmake'

  # #For OTB Windows XDK: hack hack.. heck!
	$(if $(findstring x86_64-w64-mingw32,$(TARGET)),\
	 	$(SED) -i 's/x86/x64/g' '$(PREFIX)/$(TARGET)/OpenCVConfig.cmake')
	$(if $(findstring i686-w64-mingw32,$(TARGET)),\
	   $(SED) -i 's/x64/x86/g' '$(PREFIX)/$(TARGET)/OpenCVConfig.cmake')

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

	$(SED) -i 's,$(PREFIX)/$(TARGET),\$${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/ITKTargets-release.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\$${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKZLIB.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\$${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKExpat.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\$${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKHDF5.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\$${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKJPEG.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\$${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKTIFF.cmake'
	$(SED) -i 's,$(PREFIX)/$(TARGET),\$${LIB_INSTALL_PREFIX},g' '$(PREFIX)/$(TARGET)/lib/cmake/ITK-$(ITK_VER)/Modules/ITKPNG.cmake'

endef
