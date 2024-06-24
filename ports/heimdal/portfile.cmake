vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO heimdal/heimdal
    REF heimdal-${VERSION}
    SHA512 8ae1d498f8175cdee7fdeb91ed519e32e9092c75538c02d3c999153781d6438bde6cdc59f08ae8db0830dc52eb9ec8334203bb1caceb97ebb69acca81c0446eb
    HEAD_REF master
    PATCHES
)

vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}"
    AUTOCONFIG
    OPTIONS
        --disable-heimdal-documentation
        --without-berkeley-db
        --disable-otp
        --with-cjson
)
vcpkg_install_make()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/var")


vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
