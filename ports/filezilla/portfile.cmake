vcpkg_download_distfile(ARCHIVE
    # Cannot put link from official source code. They put protection against automatic downloads.
    URLS "https://salsa.debian.org/debian/filezilla/-/archive/debian/${VERSION}/filezilla-debian-${VERSION}.tar.gz"
    FILENAME "filezilla-${VERSION}.tar.gz"
    SHA512 1fba6874fe678c22b541d4b5236607e6f7b670a7688000f3beb22d79b9a1f3c29b122cfe181a98fe03c6956d297c534aa2d80da2b6f6dfb7f2367b8f2b041312
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
)

vcpkg_make_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        --enable-gui=false
        --disable-locales
)

vcpkg_make_install()

vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
