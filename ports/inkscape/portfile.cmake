
vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com/
    OUT_SOURCE_PATH SOURCE_PATH
    REPO inkscape/inkscape
    REF "master"
    HEAD_REF master
    SHA512 e8fb48d4a55c6596db46b1954084a098981af0e6a1a405a8978afc698bb7590afea263b3dd82c1264613572f0b2bc18526e5316ac7dff03ef9ac9c1037852bc8
)

vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com/
    OUT_SOURCE_PATH LIBCROCO_PATH
    REPO inkscape/libcroco
    REF "ea3de62c"
    HEAD_REF master
    SHA512 ebed31ac1bb33eb91429aac0baa4fd0446314f427a72d99acaaac82f2a17b082b89d0661f97d2177acfc4bc7c5661c0bc3debe98c215136f179e1c6a2caf1594
)

if(NOT EXISTS "${SOURCE_PATH}/src/3rdparty/libcroco/CMakeLists.txt")
    file(REMOVE_RECURSE "${SOURCE_PATH}/src/3rdparty/libcroco/")
    file(RENAME "${LIBCROCO_PATH}" "${SOURCE_PATH}/src/3rdparty/libcroco/")
endif()

vcpkg_from_gitlab(
    GITLAB_URL https://gitlab.com/
    OUT_SOURCE_PATH LIB2GEOM_PATH
    REPO inkscape/lib2geom
    REF "5957e323"
    HEAD_REF master
    SHA512 c28dec8c0569ea9edd9d3ab8e2b12a767b8d6962a135b6dc74ef5a97c9dc0725010e7726e885bead540ae45e7feefa52a14f9712ff73fe601402250b913949f2
)

if(NOT EXISTS "${SOURCE_PATH}/src/3rdparty/2geom/CMakeLists.txt")
    file(REMOVE_RECURSE "${SOURCE_PATH}/src/3rdparty/2geom/")
    file(RENAME "${LIB2GEOM_PATH}" "${SOURCE_PATH}/src/3rdparty/2geom/")
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DWITH_GNU_READLINE=OFF
        -DENABLE_LCMS=OFF
        -DWITH_SVG2=OFF
        -DWITH_LPETOOL=OFF
        -DLPE_ENABLE_TEST_EFFECTS=OFF
        -DWITH_PROFILING=OFF
        -DBUILD_SHARED_LIBS=OFF
        -DWITH_POPPLER=OFF
        -DENABLE_POPPLER_CAIRO=OFF
        -DWITH_IMAGE_MAGICK=OFF
        -DWITH_GRAPHICS_MAGICK=OFF
        -DWITH_LIBCDR=OFF
        -DWITH_LIBVISIO=OFF
        -DWITH_LIBWPG=OFF
        -DWITH_LIBSPELLING=OFF
        -DWITH_GSOURCEVIEW=OFF
        -DWITH_NLS=OFF
        -DWITH_JEMALLOC=OFF
        -DWITH_ASAN=OFF
        -DWITH_INTERNAL_2GEOM=OFF
        -DWITH_CROSSINK=OFF
        -DWITH_X11=OFF
        -DWITH_FUZZ=OFF
        -DENABLE_BINRELOC=OFF
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

# License and man
file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

vcpkg_copy_pdbs()
