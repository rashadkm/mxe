# This file is part of MXE.
# See index.html for further information.

# make opencv MXE_PLUGIN_DIRS='plugins/opencv'

$(info == Custom overrides for opencv: $(lastword $(MAKEFILE_LIST)))
opencv_DEPS     := gcc eigen jpeg lcms1 libpng  tiff xz zlib

define opencv_BUILD
    mkdir '$(1).build'
    cd '$(1).build' && cmake \
			-DBUILD_SHARED_LIBS=$(if $(BUILD_STATIC),OFF,ON) \
      -DWITH_CUDA:BOOL=OFF \
			-DWITH_CUFFT:BOOL=OFF \
			-DWITH_DSHOW:BOOL=OFF \
			-DWITH_EIGEN:BOOL=ON \
			-DWITH_FFMPEG:BOOL=OFF \
			-DWITH_GIGEAPI:BOOL=OFF \
			-DWITH_GSTREAMER_0_10:BOOL=OFF \
			-DWITH_INTELPERC:BOOL=OFF \
			-DWITH_IPP:BOOL=OFF \
			-DWITH_JASPER:BOOL=OFF \
			-DWITH_JPEG:BOOL=ON \
			-DWITH_MSMF:BOOL=OFF \
			-DWITH_NVCUVID:BOOL=OFF \
			-DWITH_OPENCL:BOOL=OFF \
			-DWITH_OPENCLAMDBLAS:BOOL=OFF \
			-DWITH_OPENCLAMDFFT:BOOL=OFF \
			-DWITH_OPENEXR:BOOL=OFF \
			-DWITH_OPENGL:BOOL=OFF \
			-DWITH_OPENMP:BOOL=OFF \
			-DWITH_OPENNI:BOOL=OFF \
			-DWITH_PNG:BOOL=ON \
			-DWITH_PVAPI:BOOL=OFF \
			-DWITH_QT:BOOL=OFF \
			-DWITH_TBB:BOOL=OFF \
			-DWITH_TIFF:BOOL=ON \
			-DWITH_VFW:BOOL=OFF \
			-DWITH_VTK:BOOL=OFF \
			-DWITH_WIN32UI:BOOL=ON \
			-DWITH_XIMEA:BOOL=OFF \
      -DBUILD_DOCS:BOOL=OFF \
      -DBUILD_EXAMPLES:BOOL=OFF \
      -DBUILD_FAT_JAVA_LIB:BOOL=OFF \
      -DBUILD_JASPER:BOOL=OFF \
      -DBUILD_JPEG:BOOL=OFF \
      -DBUILD_OPENEXR:BOOL=OFF \
      -DBUILD_PACKAGE:BOOL=OFF \
      -DBUILD_PERF_TESTS:BOOL=OFF \
      -DBUILD_PNG:BOOL=OFF \
      -DBUILD_TBB:BOOL=OFF \
      -DBUILD_TESTS:BOOL=OFF \
      -DBUILD_TIFF:BOOL=OFF \
      -DBUILD_WITH_DEBUG_INFO:BOOL=OFF \
      -DBUILD_ZLIB:BOOL=OFF \
      -DBUILD_opencv_apps:BOOL=OFF \
      -DBUILD_opencv_calib3d:BOOL=OFF \
      -DBUILD_opencv_contrib:BOOL=ON \
      -DBUILD_opencv_core:BOOL=ON \
      -DBUILD_opencv_features2d:BOOL=ON \
      -DBUILD_opencv_flann:BOOL=ON \
      -DBUILD_opencv_gpu:BOOL=OFF \
      -DBUILD_opencv_highgui:BOOL=ON \
      -DBUILD_opencv_imgproc:BOOL=ON \
      -DBUILD_opencv_legacy:BOOL=OFF \
      -DBUILD_opencv_ml:BOOL=ON \
      -DBUILD_opencv_nonfree:BOOL=ON \
      -DBUILD_opencv_objdetect:BOOL=ON \
      -DBUILD_opencv_ocl:BOOL=OFF \
      -DBUILD_opencv_photo:BOOL=ON \
      -DBUILD_opencv_stitching:BOOL=ON \
      -DBUILD_opencv_superres:BOOL=ON \ \
      -DBUILD_opencv_ts:BOOL=ON \
      -DBUILD_opencv_video:BOOL=OFF \
      -DBUILD_opencv_videostab:BOOL=OFF \
      -DBUILD_opencv_world:BOOL=OFF \
      -DCMAKE_VERBOSE:BOOL=ON \
      -DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)' \
      -DCMAKE_CXX_FLAGS='-D_WIN32_WINNT=0x0500' \
      '$(1)'

    # install
    $(MAKE) -C '$(1).build' -j '$(JOBS)' install VERBOSE=1

    # fixup and install pkg-config file
    # openexr isn't available on x86_64-w64-mingw32
    # opencv builds it's own libIlmImf.a
    $(if $(findstring x86_64-w64-mingw32,$(TARGET)),\
        $(SED) -i 's/OpenEXR//' '$(1).build/unix-install/opencv.pc')
    $(SED) -i 's,share/OpenCV/3rdparty/,,g' '$(1).build/unix-install/opencv.pc'
    $(INSTALL) -m755 '$(1).build/unix-install/opencv.pc' '$(PREFIX)/$(TARGET)/lib/pkgconfig'

endef
