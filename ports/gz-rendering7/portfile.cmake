set(PACKAGE_NAME rendering)

ignition_modular_library(
   NAME ${PACKAGE_NAME}
   REF ${PORT}_${VERSION}
   VERSION ${VERSION}
   SHA512 7c14b268694600b8529fef21130b34f516b26baac771c019b4248a67f84420c40d655e0abedf0b36c53b7cdf19941b3f4f3494696c831a83070632d004b30678
   OPTIONS 
   PATCHES
      fix-dependencies.patch
)

IF(EXISTS "${CURRENT_PACKAGES_DIR}/lib/gz-rendering-7/")
   file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/plugins")
   file(RENAME "${CURRENT_PACKAGES_DIR}/lib/gz-rendering-7/" "${CURRENT_PACKAGES_DIR}/plugins/gz-rendering-7/")
endif()

if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/gz-rendering-7/")
   file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/plugins")
   file(RENAME "${CURRENT_PACKAGES_DIR}/debug/lib/gz-rendering-7/" "${CURRENT_PACKAGES_DIR}/debug/plugins/gz-rendering-7/")
endif()

