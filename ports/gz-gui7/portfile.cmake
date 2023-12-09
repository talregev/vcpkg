set(PACKAGE_NAME gui)

ignition_modular_library(
   NAME ${PACKAGE_NAME}
   REF ${PORT}_${VERSION}
   VERSION ${VERSION}
   SHA512 29f37a31bbf90dd35f37e80053c1aff9fb404b7a09c8c10e640da505cc6261387e6ce77e3bf379a911e6131c684f866cf1ef8d83777112b3c7f148b1f95cc72f
   OPTIONS 
   PATCHES
      dependencies.patch
)

IF(EXISTS "${CURRENT_PACKAGES_DIR}/lib/gz-gui-7/")
   file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/plugins")
   file(RENAME "${CURRENT_PACKAGES_DIR}/lib/gz-gui-7/" "${CURRENT_PACKAGES_DIR}/plugins/gz-gui-7/")
endif()

if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/gz-gui-7/")
   file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/plugins")
   file(RENAME "${CURRENT_PACKAGES_DIR}/debug/lib/gz-gui-7/" "${CURRENT_PACKAGES_DIR}/debug/plugins/gz-gui-7/")
endif()


if(VCPKG_TARGET_IS_WINDOWS)
    # Lacking pc files for Qt
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/pkgconfig" "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig")
endif()