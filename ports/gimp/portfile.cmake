vcpkg_download_distfile(ARCHIVE
    URLS "https://download.gimp.org/gimp/v3.0/gimp-${VERSION}.tar.xz"
    FILENAME "gimp-${VERSION}.tar.xz"
    SHA512 7a83768caae458b75883522c87d5297e9642b64b0516c482804034b8b9acc6af6afc89d1b4a549fd26de3e33816136c31d440f554f66669c8ccd43536260916a
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    PATCHES
)

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

vcpkg_fixup_pkgconfig()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
