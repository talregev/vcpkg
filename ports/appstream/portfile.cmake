
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ximion/appstream
    REF "v${VERSION}"
    SHA512 604b1e467e189540c17e72a6df10a7cfd0b89603975aa04790d4e971c5b2f9861d8f0e62ca88148dde66ecff759000fd641bd1a3697ec1d07041a730964ce2e1
    HEAD_REF main
)

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -Dstemming=false
        -Dsystemd=false
        -Dvapi=false
        -Dqt=false
        -Dcompose=false
        -Dapt-support=false
        -Dgir=false
        -Dsvg-support=false
        -Dzstd-support=false
        -Ddocs=false
        -Dapidocs=false
        -Dinstall-docs=false
    ADDITIONAL_BINARIES
        "gperf = ['${CURRENT_HOST_INSTALLED_DIR}/tools/gperf/gperf${VCPKG_HOST_EXECUTABLE_SUFFIX}']"
)

vcpkg_install_meson()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
