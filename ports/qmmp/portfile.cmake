string(REGEX MATCH [[^[1-9][0-9]*\.[1-9][0-9]*]] VERSION_MAJOR_MINOR ${VERSION})

vcpkg_download_distfile(ARCHIVE
    URLS "https://qmmp.ylsoftware.com/files/qmmp/${VERSION_MAJOR_MINOR}/qmmp-${VERSION}.tar.bz2"
    FILENAME "qmmp-${VERSION}.tar.bz2"
    SHA512 91637a3293030c21c1d0de689bb5e2227e6ea2bf122e9eeeadc303465bc045c6a3621d74af9971ae2f436f3167026eee67e1bcb005f54e71081961d058523770
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE 
    "${CURRENT_PACKAGES_DIR}/debug/include" 
    "${CURRENT_PACKAGES_DIR}/debug/share"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
