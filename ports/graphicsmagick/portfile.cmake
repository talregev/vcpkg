string(REPLACE "." "_" graphicsmagick_version "GraphicsMagick-${VERSION}")

vcpkg_from_gitlab(
    OUT_SOURCE_PATH SOURCE_PATH
    GITLAB_URL https://foss.heptapod.net/
    REPO graphicsmagick/graphicsmagick
    REF ${graphicsmagick_version}
    SHA512 c6ee4ded9df4816c5f9522b825d51d23b8c3bef3218b630891f16950452a98633c6a9076b87c07b47493af44b6b4c4cfddfed456a715c885ac3d1d4c6252a6a7
    PATCHES
        # GM always requires a dynamic BZIP2. This patch makes this dependent if _DLL is defined
        dynamic_bzip2.patch

        # Bake GM's own modules into the .dll itself.  This fixes a bug whereby
        # 'vcpkg install graphicsmagick' did not lead to a copy of GM that could
        # load either PNG or JPEG files (due to missing GM Modules, with names
        # matching "IM_*.DLL").
        disable_graphicsmagick_modules.patch
)

vcpkg_make_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_make_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

# copy config
file(COPY "${SOURCE_PATH}/config/colors.mgk" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}/config")
file(COPY "${SOURCE_PATH}/config/log.mgk" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}/config")
file(COPY "${SOURCE_PATH}/config/modules.mgk" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}/config")

file(READ "${SOURCE_PATH}/config/type-windows.mgk.in" TYPE_MGK)
string(REPLACE "@windows_font_dir@" "$ENV{SYSTEMROOT}/Fonts/" TYPE_MGK "${TYPE_MGK}")
file(WRITE "${CURRENT_PACKAGES_DIR}/share/graphicsmagick/config/type.mgk" "${TYPE_MGK}")

configure_file("${SOURCE_PATH}/config/delegates.mgk.in" "${CURRENT_PACKAGES_DIR}/share/${PORT}/config/delegates.mgk" @ONLY)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

set(FILE_LIST
        "GraphicsMagick++-config"
        "GraphicsMagick-config"
        "GraphicsMagickWand-config"
)
foreach(filename ${FILE_LIST})
    
    set(file "${CURRENT_PACKAGES_DIR}/tools/graphicsmagick/bin/${filename}")
    vcpkg_replace_string("${file}" "${CURRENT_INSTALLED_DIR}" "`dirname $0`/../../..")
    if(NOT VCPKG_BUILD_TYPE)
        set(debug_file "${CURRENT_PACKAGES_DIR}/tools/graphicsmagick/debug/bin/${filename}")
        vcpkg_replace_string("${debug_file}" "${CURRENT_INSTALLED_DIR}/debug" "`dirname $0`/../../../..")
        vcpkg_replace_string("${debug_file}" "${CURRENT_INSTALLED_DIR}" "`dirname $0`/../../..")
    endif()
endforeach()
# copy license
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/Copyright.txt")
