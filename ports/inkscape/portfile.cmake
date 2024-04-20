
vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com/
    OUT_SOURCE_PATH SOURCE_PATH
    REPO inkscape/inkscape
    REF "INKSCAPE_1_3_2"
    HEAD_REF master
    SHA512 f31951ecbdace6a18fb9f772616137cb8732163b37448fef4daf1af60ba8479c94d498dcdaf4880468c80012c77a446da585926a99704a9a940b80e546080cf3
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

# License and man
file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

vcpkg_copy_pdbs()
