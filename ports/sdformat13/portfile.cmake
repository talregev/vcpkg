vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gazebosim/sdformat
    REF "sdformat13_${VERSION}"
    SHA512 180e28631c02d92bfd17d31ec32edb234e6c56c8fad011d04198481a39bffc26355b9001c598fa63a30ce47ad8abaeaed05e3008957c5e77df3a09b0170f0e6d
    HEAD_REF sdf13
    PATCHES
        no-absolute.patch
        cmake-config.patch
)

# Ruby is required by the sdformat build process
vcpkg_find_acquire_program(RUBY)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        "-DRUBY=${RUBY}"
        -DBUILD_TESTING=OFF
        -DSKIP_PYBIND11=ON
        -DUSE_INTERNAL_URDF=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=ON
        -DCMAKE_REQUIRE_FIND_PACKAGE_GzURDFDOM=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_Python3=ON
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/sdformat13")
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include"
                    "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
