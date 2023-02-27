vcpkg_download_distfile(ARCHIVE
    URLS "https://ftpmirror.gnu.org/octave/octave-${VERSION}.tar.gz"
    FILENAME "octave-${VERSION}.tar.gz"
    SHA512 cafdf4d04c34914a945a0bc3d68b63f91402bb0c43b7c545fb7b2fd23906f516f2186f7a5fb49fef1cf988a78957ab0e662d36178d1e83399d855d040bf1e9fd
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    PATCHES
        
)

set(CPPFLAGS "-I${CURRENT_INSTALLED_DIR}/include/ -w")
set(LDFLAGS "-L${CURRENT_INSTALLED_DIR}/lib/")

vcpkg_configure_make(
    SOURCE_PATH ${SOURCE_PATH}
    AUTOCONFIG
    NO_ADDITIONAL_PATHS
    OPTIONS
    CPPFLAGS=${CPPFLAGS}
    LDFLAGS=${LDFLAGS}
)

vcpkg_install_make()
