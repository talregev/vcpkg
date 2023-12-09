set(PACKAGE_NAME physics)

ignition_modular_library(
   NAME ${PACKAGE_NAME}
   REF ${PORT}_${VERSION}
   VERSION ${VERSION}
   SHA512 c29594663509234e25c7d0a33848c0fe222c2b9471513978c18ea6873a17c66c43b4037c74e8849995fa6449c2dddc0f2ee669605893daf65119c277a17f39e1
   OPTIONS 
   PATCHES
      dependencies.patch
)

IF(EXISTS "${CURRENT_PACKAGES_DIR}/lib/gz-physics-6/")
   file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/plugins")
   file(RENAME "${CURRENT_PACKAGES_DIR}/lib/gz-physics-6/" "${CURRENT_PACKAGES_DIR}/plugins/gz-physics-6/")
endif()

if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/gz-physics-6/")
   file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/plugins")
   file(RENAME "${CURRENT_PACKAGES_DIR}/debug/lib/gz-physics-6/" "${CURRENT_PACKAGES_DIR}/debug/plugins/gz-physics-6/")
endif()

