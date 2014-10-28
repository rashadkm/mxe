# This is a template of configuration file for MXE. See
# index.html for more extensive documentations.

# This variable controls the number of compilation processes
# within one package ("intra-package parallelism").
JOBS := 4

# This variable controls the targets that will build.
#MXE_TARGETS :=  i686-pc-mingw32.static i686-pc-mingw32.shared  x86_64-w64-mingw32.static x86_64-w64-mingw32.shared  i686-w64-mingw32.static i686-w64-mingw32.shared

MXE_TARGETS := x86_64-w64-mingw32.shared i686-w64-mingw32.shared

# This variable controls the download mirror for SourceForge,
# when it is used. Enabling the value below means auto.
#SOURCEFORGE_MIRROR := downloads.sourceforge.net

# The three lines below makes `make` build these "local
# packages" instead of all packages.
LOCAL_PKG_LIST := gdal
.DEFAULT local-pkg-list:
local-pkg-list: $(LOCAL_PKG_LIST)
