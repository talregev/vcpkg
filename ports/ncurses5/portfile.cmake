vcpkg_download_distfile(
    ARCHIVE_PATH
    URLS
        "https://invisible-mirror.net/archives/ncurses/ncurses-${VERSION}.tar.gz"
        "ftp://ftp.invisible-island.net/ncurses/ncurses-${VERSION}.tar.gz"
        "https://ftp.gnu.org/gnu/ncurses/ncurses-${VERSION}.tar.gz"
    FILENAME "ncurses-${VERSION}.tgz"
    SHA512 d7c5e54b6d4d8b9211f0006ca8786f7609d180cc1aaebf4f25e7e35e12959779cf66447359a602daed625621ca32b0d910d67aef3eb8b6fdc3c373819a88faa1
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE_PATH}"
    PATCHES
        ncurses-5.9-gcc-5.patch
        throw.patch
        casting.patch
        set_cpp_has_try_catch_to_zero.patch
)

vcpkg_list(SET OPTIONS)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    list(APPEND OPTIONS
        --with-cxx-shared
        --with-shared    # "lib model"
        --without-normal # "lib model"
    )
endif()

if(NOT VCPKG_TARGET_IS_MINGW)
    list(APPEND OPTIONS
        --enable-mixed-case
    )
endif()

if(VCPKG_TARGET_IS_MINGW)
    list(APPEND OPTIONS
        --disable-home-terminfo
        --enable-term-driver
        --disable-termcap
    )
endif()

vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    DETERMINE_BUILD_TRIPLET
    NO_ADDITIONAL_PATHS
    OPTIONS
        ${OPTIONS}
        --disable-db-install
        --enable-pc-files
        --without-ada
        --without-debug # "lib model"
        --without-manpages
        --without-progs
        --without-tack
        --without-tests
        --with-pkg-config-libdir=libdir
)
vcpkg_install_make()

vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/README" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
